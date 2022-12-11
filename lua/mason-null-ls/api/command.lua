local a = require('mason-core.async')
local Optional = require('mason-core.optional')
local notify = require('mason-core.notify')
local _ = require('mason-core.functional')

--@async
--@param user_args string[]: The arguments, as provided by the user.
local function parse_packages_from_user_args(user_args)
	local registry = require('mason-registry')
	local Package = require('mason-core.package')
	local source_mappings = require('mason-null-ls.mappings.source')
	local language_mappings = require('mason.mappings.language')

	return _.filter_map(function(source_specifier)
		local source_name, version = Package.Parse(source_specifier)
		-- 1. first see if the provided arg is an actual null-ls source name
		return Optional
			.of_nilable(source_mappings.getPackageFromNullLs(source_name))
			-- 2. if not, check if it's a language specifier (e.g., "typescript" or "java")
			:or_(function()
				return Optional.of_nilable(language_mappings(source_name)):map(function(package_names)
					local package_names = _.filter(function(package_name)
						return source_mappings.getPackageFromNullLs(package_name) ~= nil
					end, package_names)

					if #package_names == 0 then
						return nil
					end

					return a.promisify(vim.ui.select)(package_names, {
						prompt = ('Please select which source you want to install for language %q:'):format(
							source_name
						),
						format_item = function(package_name)
							local source_name = source_mappings.getPackageFromNullLs(package_name)
							if registry.is_installed(package_name) then
								return ('%s (installed)'):format(source_name)
							else
								return source_name
							end
						end,
					})
				end)
			end)
			:map(function(package_name)
				return { package = package_name, version = version }
			end)
			:if_not_present(function()
				notify(('Could not find Null-ls Source %q.'):format(source_name), vim.log.levels.ERROR)
			end)
	end, user_args)
end

---@async
local function parse_packages_from_heuristics()
	local source_mappings = require('mason-null-ls.mappings.source')
	local registry = require('mason-registry')

	-- Prompt user which source they want to install (based on the current filetype)
	local current_ft = vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), 'filetype')
	local filetype_mappings = require('mason-null-ls.mappings.filetype')
	return Optional.of_nilable(filetype_mappings[current_ft])
		:map(function(source_names)
			return a.promisify(vim.ui.select)(source_names, {
				prompt = ('Please select which source you want to install for filetype %q:'):format(current_ft),
				format_item = function(source_name)
					if registry.is_installed(source_mappings.getPackageFromNullLs(source_name)) then
						return ('%s (installed)'):format(source_name)
					else
						return source_name
					end
				end,
			})
		end)
		:map(function(source_name)
			local package_name = source_mappings.getPackageFromNullLs(source_name)
			return { { package = package_name, version = nil } }
		end)
		:or_else_get(function()
			notify(('No Null-ls sources found for filetype %q.'):format(current_ft), vim.log.levels.ERROR)
			return {}
		end)
end

local parse_packages_to_install = _.cond({
	{ _.compose(_.gt(0), _.length), parse_packages_from_user_args },
	{ _.compose(_.equals(0), _.length), parse_packages_from_heuristics },
	{ _.T, _.always({}) },
})

local NullLsInstall = a.scope(function(sources)
	local packages_to_install = parse_packages_to_install(sources)
	if #packages_to_install > 0 then
		local registry = require('mason-registry')
		_.each(function(target)
			local pkg = registry.get_package(target.package)
			pkg:install({ version = target.version })
		end, packages_to_install)
		local ui = require('mason.ui')
		ui.open()
		ui.set_view('All')
		vim.schedule(function()
			ui.set_sticky_cursor('installing-section')
		end)
	end
end)

vim.api.nvim_create_user_command('NullLsInstall', function(opts)
	NullLsInstall(opts.fargs)
end, {
	desc = 'Install one or more Null-ls sources.',
	nargs = '*',
	complete = 'custom,v:lua.mason_null_ls_completion.available_source_completion',
})

local function NullLsUninstall(sources)
	require('mason.ui').open()
	require('mason.ui').set_view('All')
	local registry = require('mason-registry')
	local source_mappings = require('mason-null-ls.mappings.source')
	for _, source_specifier in ipairs(sources) do
		local package_name = source_mappings.getPackageFromNullLs(source_specifier)
		local pkg = registry.get_package(package_name)
		pkg:uninstall()
	end
end

vim.api.nvim_create_user_command('NullLsUninstall', function(opts)
	NullLsUninstall(opts.fargs)
end, {
	desc = 'Uninstall one or more Null-ls sources.',
	nargs = '+',
	complete = 'custom,v:lua.mason_null_ls_completion.installed_source_completion',
})

_G.mason_null_ls_completion = {
	available_source_completion = function()
		local available_sources = require('mason-null-ls').get_available_sources()
		local language_mappings = require('mason.mappings.language')
		local sort_deduped = _.compose(_.sort_by(_.identity), _.uniq_by(_.identity))
		local completions = sort_deduped(_.concat(_.keys(language_mappings), available_sources))
		return table.concat(completions, '\n')
	end,
	installed_source_completion = function()
		local installed_sources = require('mason-null-ls').get_installed_sources()
		return table.concat(installed_sources, '\n')
	end,
}

return {
	NullLsInstall = NullLsInstall,
	NullLsUninstall = NullLsUninstall,
}
