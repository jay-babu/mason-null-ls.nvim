local settings = require('mason-null-ls.settings')

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

local function auto_get_packages()
	local sources = {}
	sources = vim.list_extend(sources, vim.tbl_keys(require('null-ls.builtins').diagnostics))
	sources = vim.list_extend(sources, vim.tbl_keys(require('null-ls.builtins').formatting))
	sources = vim.list_extend(sources, vim.tbl_keys(require('null-ls.builtins').code_actions))
	sources = vim.list_extend(sources, vim.tbl_keys(require('null-ls.builtins').completion))
	sources = vim.list_extend(sources, vim.tbl_keys(require('null-ls.builtins').hover))
	local tools = removeArrayDuplicates(sources)
	return tools
end

---@param null_ls_source_name string
local function resolve_package(null_ls_source_name)
	local registry = require('mason-registry')
	local Optional = require('mason-core.optional')
	local source_mappings = require('mason-null-ls.mappings.source')

	return Optional.of_nilable(source_mappings.null_ls_to_package[null_ls_source_name]):map(function(package_name)
		local ok, pkg = pcall(registry.get_package, package_name)
		if ok then
			return pkg
		end
	end)
end

local function difference(a, b)
	if b == nil then
		return a
	end
	local aa = {}
	for _, v in pairs(a) do
		aa[v] = true
	end
	for _, v in pairs(b) do
		aa[v] = nil
	end

	local ret = {}
	local n = 0
	for _, v in pairs(a) do
		if aa[v] then
			n = n + 1
			ret[n] = v
		end
	end
	return ret
end

return function()
	local sources = auto_get_packages()
	local auto_install = settings.current.automatic_installation
	if type(auto_install) == 'table' then
		sources = difference(sources, auto_install.exclude)
	end

	for _, source_identifier in ipairs(sources) do
		local Package = require('mason-core.package')

		local source_name, version = Package.Parse(source_identifier)
		resolve_package(source_name):if_present(
			-- -@param pkg Package
			function(pkg)
				if not pkg:is_installed() then
                    vim.notify(("[mason-null-ls] automatically installing %s"):format(pkg.name))
					pkg:install({
						version = version,
                    }):once(
                        'closed',
                        vim.schedule_wrap(function()
                            if pkg:is_installed() then
                                vim.notify(("[mason-null-ls] %s was automatically installed"):format(pkg.name))
                            end
                        end)
                    )
				end
			end
		)
	end
end
