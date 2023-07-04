local _ = require('mason-core.functional')
local Optional = require('mason-core.optional')

local M = {}

---Maps null_ls source name to its corresponding package name.
local null_ls_to_package = {
	['cmake_format'] = 'cmakelang',
	['eslint_d'] = 'eslint_d',
	['goimports_reviser'] = 'goimports_reviser',
	['phpcsfixer'] = 'php-cs-fixer',
	['verible_verilog_format'] = 'verible',
	['lua_format'] = 'luaformatter',
	['ansiblelint'] = 'ansible-lint',
    ['deno_fmt'] = 'deno',
}

local package_to_null_ls = _.invert(null_ls_to_package)

---@param source string: Source Name from NullLs
---@return string: Package Name from Mason
M.getPackageFromNullLs = _.memoize(function(source)
	return Optional.of_nilable(null_ls_to_package[source]):or_else_get(_.always(source:gsub('%_', '-')))
end)

---@param package string: Package Name from Mason
---@return string: NullLs Source Name
M.getNullLsFromPackage = _.memoize(function(package)
	return Optional.of_nilable(package_to_null_ls[package]):or_else_get(_.always(package:gsub('%-', '_')))
end)

return M
