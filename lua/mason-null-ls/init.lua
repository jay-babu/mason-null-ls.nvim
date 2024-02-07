local log = require('mason-core.log')
local _ = require('mason-core.functional')

local M = {}

-- Currently this only needs to be evaluated for the same list passed in.
-- @param source string
-- @param types string[]
M.default_setup = require('mason-null-ls.automatic_setup')

---@param handlers table<string, fun(source_name: string, methods: string[])> | nil
---@return nil
local function setup_handlers(handlers)
	handlers = handlers or {}

	local Optional = require('mason-core.optional')
	local source_mappings = require('mason-null-ls.mappings.source')
	local registry = require('mason-registry')
	local notify = require('mason-core.notify')

	local default_handler = Optional.of_nilable(handlers[1]):or_(_.always(Optional.of_nilable(M.default_setup)))

	_.each(function(handler)
		if type(handler) == 'string' and not source_mappings.getPackageFromNullLs(handler) then
			notify(
				('mason-null-ls.setup_handlers: Received handler for unknown null-ls source name: %s.'):format(handler),
				vim.log.levels.WARN
			)
		end
	end, _.keys(handlers))

	---@param pkg_name string
	local function get_source_name(pkg_name)
		return Optional.of_nilable(source_mappings.getNullLsFromPackage(pkg_name))
	end

	local function call_handler(source_name)
		log.fmt_trace('Checking handler for %s', source_name)

		Optional.of_nilable(handlers[source_name]):or_(_.always(default_handler)):if_present(function(handler)
			log.fmt_trace('Calling handler for %s', source_name)

			local ignored_methods = require('mason-null-ls.settings').current.ignore_methods
			local types = _.filter_map(function(method)
				if vim.tbl_contains(ignored_methods, method) then
					return Optional.empty()
				end
				local ok, _ = pcall(require, string.format('null-ls.builtins.%s.%s', method, source_name))
				if ok then
					return Optional.of(method)
				else
					return Optional.empty()
				end
			end, { 'diagnostics', 'formatting', 'code_actions', 'completion', 'hover' })

			local ok, err = pcall(handler, source_name, types)

			if not ok then
				vim.notify(err, vim.log.levels.ERROR)
			end
		end)
	end

	local installed_sources = _.filter_map(get_source_name, registry.get_installed_package_names())
	_.each(call_handler, installed_sources)
	registry:on(
		'package:install:success',
		vim.schedule_wrap(function(pkg)
			get_source_name(pkg.name):if_present(call_handler)
		end)
	)
end

---@param config MasonNullLsSettings | nil
function M.setup(config)
	local settings = require('mason-null-ls.settings')

	if config then
		settings.set(config)
	end

	-- NOTE: this is left here for future porting in case needed
	-- local ok, err = pcall(function()
	--     require "mason-lspconfig.lspconfig_hook"()
	--     require "mason-lspconfig.server_config_extensions"()
	-- end)
	-- if not ok then
	--     log.error("Failed to set up lspconfig integration.", err)
	-- end

	if #settings.current.ensure_installed > 0 then
		require('mason-null-ls.ensure_installed')()
	end

	if settings.current.automatic_installation then
		require('mason-null-ls.automatic_installation')()
	end

	if settings.current.handlers then
		setup_handlers(settings.current.handlers)
	end

	require('mason-null-ls.api.command')
end

---@return string[]
function M.get_installed_sources()
	local Optional = require('mason-core.optional')
	local registry = require('mason-registry')
	local source_mappings = require('mason-null-ls.mappings.source')

	return _.filter_map(function(pkg_name)
		return Optional.of_nilable(source_mappings.getNullLsFromPackage(pkg_name))
	end, registry.get_installed_package_names())
end

---@param filetype string | string[]
local function is_source_in_filetype(filetype)
	local filetype_mappings = require('mason-null-ls.mappings.filetype')

	local function get_sources_by_filetype(ft)
		return filetype_mappings[ft] or {}
	end

	local source_candidates = _.compose(
		_.set_of,
		_.cond({
			{ _.is('string'), get_sources_by_filetype },
			{ _.is('table'), _.compose(_.flatten, _.map(get_sources_by_filetype)) },
			{ _.T, _.always({}) },
		})
	)(filetype)

	---@param source_name string
	---@return boolean
	return function(source_name)
		return source_candidates[source_name]
	end
end

---Get a list of available sources in mason-registry
---@param filter { filetype: string | string[] }?: (optional) Used to filter the list of source names.
--- The available keys are
---   - filetype (string | string[]): Only return sources with matching filetype
---@return string[]
function M.get_available_sources(filter)
	local registry = require('mason-registry')
	local source_mappings = require('mason-null-ls.mappings.source')
	local Optional = require('mason-core.optional')
	filter = filter or {}
	local predicates = {}

	if filter.filetype then
		table.insert(predicates, is_source_in_filetype(filter.filetype))
	end

	return _.filter_map(function(pkg_name)
		return Optional.of_nilable(source_mappings.getNullLsFromPackage(pkg_name)):map(function(source_name)
			if #predicates == 0 or _.all_pass(predicates, source_name) then
				return source_name
			end
		end)
	end, registry.get_all_package_names())
end

return M
