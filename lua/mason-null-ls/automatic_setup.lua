local _ = require('mason-core.functional')
local null_ls = require('null-ls')

-- @param source string
-- @param types string[]
return _.memoize(function(source, types)
	if not null_ls.is_registered(source) then
		vim.tbl_map(function(type)
			null_ls.register(null_ls.builtins[type][source])
		end, types)
	end
end)
