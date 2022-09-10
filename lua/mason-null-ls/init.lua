local mr = require('mason-registry')
local mappings = require('mason-null-ls.mappings')

local SETTINGS = {
	ensure_installed = {},
	null_ls_sources = {},
	auto_update = false,
	automatic_installation = false,
}

function dump(o)
	if type(o) == 'table' then
		local s = '{ '
		for k, v in pairs(o) do
			if type(k) ~= 'number' then
				k = '"' .. k .. '"'
			end
			s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
		end
		return s .. '} '
	else
		return tostring(o)
	end
end

-- local function getKeysAsSet(tab)
-- 	if tab == nil then
-- 		return nil
-- 	end
-- 	local keyset = {}
--
-- 	for k, _ in pairs(tab) do
-- 		keyset[k] = true
-- 	end
-- 	return keyset
-- end

local function removeArrayDuplicates(arr)
	if arr == nil then
		return nil
	end

	local table = {}
	for _, item in ipairs(arr) do
		table[item] = true
	end

	return vim.tbl_keys(table)
end

local function lookup(t)
	print(dump(t))
	local tools = {}
	for _, source in ipairs(t) do
		print(dump(source))
		local wantedTools = mappings[source] or {}
		for _, tool in pairs(wantedTools) do
			tools[tool] = true
		end
	end
	return tools
end

local setup = function(settings)
	SETTINGS = vim.tbl_deep_extend('force', SETTINGS, settings)
	vim.validate({
		ensure_installed = { SETTINGS.ensure_installed, 'table', true },
		null_ls_sources = { SETTINGS.null_ls_sources, 'table', true },
		auto_update = { SETTINGS.auto_update, 'boolean', true },
		automatic_installation = { SETTINGS.automatic_installation, 'boolean', true },
	})
end

local show = function(msg)
	vim.schedule_wrap(print(string.format('[mason-null-ls] %s', msg)))
end

local show_error = function(msg)
	vim.schedule_wrap(vim.api.nvim_err_writeln(string.format('[mason-null-ls] %s', msg)))
end

local auto_get_packages = function()
	local sources = {}
	sources = vim.tbl_deep_extend('force', sources, vim.tbl_keys(require('null-ls.builtins').diagnostics))
	sources = vim.tbl_deep_extend('force', sources, vim.tbl_keys(require('null-ls.builtins').formatting))
	sources = vim.tbl_deep_extend('force', sources, vim.tbl_keys(require('null-ls.builtins').code_actions))
	sources = vim.tbl_deep_extend('force', sources, vim.tbl_keys(require('null-ls.builtins').completion))
	sources = vim.tbl_deep_extend('force', sources, vim.tbl_keys(require('null-ls.builtins').hover))
	local tools = vim.tbl_keys(lookup(removeArrayDuplicates(sources)))
	return tools
end

local do_install = function(p, version, on_close)
	if version ~= nil then
		show(string.format('%s: updating to %s', p.name, version))
	else
		show(string.format('%s: installing', p.name))
	end
	p:once('install:success', function()
		show(string.format('%s: successfully installed', p.name))
	end)
	p:once('install:failed', function()
		show_error(string.format('%s: failed to install', p.name))
	end)
	p:install({ version = version }):once('closed', vim.schedule_wrap(on_close))
end

local check_install = function(force_update)
	SETTINGS.ensure_installed =
		vim.tbl_deep_extend('force', lookup(SETTINGS.null_ls_sources), SETTINGS.ensure_installed)

	if SETTINGS.automatic_installation then
		SETTINGS.ensure_installed = vim.tbl_deep_extend('force', auto_get_packages(), SETTINGS.ensure_installed)
	end
	local completed = 0
	local total = vim.tbl_count(SETTINGS.ensure_installed)
	local on_close = function()
		completed = completed + 1
		if completed >= total then
			vim.api.nvim_exec_autocmds('User', {
				pattern = 'MasonNullLsUpdateCompleted',
				-- 'data' doesn't work with < 0.8.0
				-- data = { packages = SETTINGS.ensure_installed },
			})
		end
	end
	for _, item in ipairs(SETTINGS.ensure_installed or {}) do
		local name, version, auto_update
		if type(item) == 'table' then
			name = item[1]
			version = item.version
			auto_update = item.auto_update
		else
			name = item
		end
		local p = mr.get_package(name)
		if p:is_installed() then
			if version ~= nil then
				p:get_installed_version(function(ok, installed_version)
					if ok and installed_version ~= version then
						do_install(p, version, on_close)
					else
						completed = completed + 1
					end
				end)
			elseif
				force_update or (force_update == nil and (auto_update or (auto_update == nil and SETTINGS.auto_update)))
			then
				p:check_new_version(function(ok, version)
					if ok then
						do_install(p, version.latest_version, on_close)
					else
						completed = completed + 1
					end
				end)
			else
				completed = completed + 1
			end
		else
			do_install(p, version, on_close)
		end
	end
end

return {
	check_install = check_install,
	setup = setup,
}
