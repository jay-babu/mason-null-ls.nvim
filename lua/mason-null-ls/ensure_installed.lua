local settings = require('mason-null-ls.settings')

---@param null_ls_source_name string
local function resolve_package(null_ls_source_name)
	local registry = require('mason-registry')
	local Optional = require('mason-core.optional')
	local source_mapping = require('mason-null-ls.mappings.source')

	return Optional.of_nilable(source_mapping.null_ls_to_package[null_ls_source_name]):map(function(package_name)
		local ok, pkg = pcall(registry.get_package, package_name)
		if ok then
			return pkg
		end
	end)
end

return function()
	for _, source_identifier in ipairs(settings.current.ensure_installed) do
		local Package = require('mason-core.package')

		local source_name, version = Package.Parse(source_identifier)
		resolve_package(source_name):if_present(
			-- -@param pkg Package
			function(pkg)
				if not pkg:is_installed() then
					pkg:install({
						version = version,
					})
				end
			end
		)
	end
end
