local M = {}

---@class MasonNullLsMethods
---@field diagnostics boolean
---@field formatting boolean
---@field code_actions boolean
---@field completion boolean
---@field hover boolean

---@class MasonNullLsSettings
---@field handlers table | nil
---@field methods MasonNullLsMethods
---@field ensure_installed table
---@field automatic_installation boolean | table
local DEFAULT_SETTINGS = {
	-- A list of sources to automatically install if they're not already installed. Example: { "stylua" }
	-- This setting has no relation with the `automatic_installation` setting.
	ensure_installed = {},
	-- A list of null-ls methods to ignore when calling handlers.
	-- This setting is useful if some functionality is handled by other plugins such as `conform` and `nvim-lint`
	methods = {
		diagnostics = true,
		formatting = true,
		code_actions = true,
		completion = true,
		hover = true,
	},
	-- NOTE: this is left here for future porting in case needed
	-- Whether sources that are set up (via null-ls) should be automatically installed if they're not already installed.
	-- This setting has no relation with the `ensure_installed` setting.
	-- Can either be:
	--   - false: Servers are not automatically installed.
	--   - true: All servers set up via lspconfig are automatically installed.
	--   - { exclude: string[] }: All servers set up via mason-null-ls, except the ones provided in the list, are automatically installed.
	--       Example: automatic_installation = { exclude = { "stylua", "eslint", } }
	automatic_installation = false,
	handlers = nil,
}

M._DEFAULT_SETTINGS = DEFAULT_SETTINGS
M.current = M._DEFAULT_SETTINGS

---@param opts MasonNullLsSettings
function M.set(opts)
	M.current = vim.tbl_deep_extend('force', M.current, opts)
	vim.validate({
		ensure_installed = { M.current.ensure_installed, 'table', true },
		methods = { M.current.methods, 'table', true },
		automatic_installation = { M.current.automatic_installation, { 'boolean', 'table' }, true },
		handlers = { M.current.handlers, { 'table' }, true },
	})
end

return M
