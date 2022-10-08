local M = {}

---@class MasonNullLsSettings
local DEFAULT_SETTINGS = {
	-- A list of sources to automatically install if they're not already installed. Example: { "stylua" }
	-- This setting has no relation with the `automatic_installation` setting.
	ensure_installed = {},

	-- NOTE: this is left here for future porting in case needed
	-- Whether sources that are set up (via null-ls) should be automatically installed if they're not already installed.
	-- This setting has no relation with the `ensure_installed` setting.
	-- Can either be:
	--   - false: Servers are not automatically installed.
	--   - true: All servers set up via lspconfig are automatically installed.
	--   - { exclude: string[] }: All servers set up via mason-null-ls, except the ones provided in the list, are automatically installed.
	--       Example: automatic_installation = { exclude = { "stylua", "eslint", } }
	automatic_installation = false,
}

M._DEFAULT_SETTINGS = DEFAULT_SETTINGS
M.current = M._DEFAULT_SETTINGS

---@param opts MasonNullLsSettings
function M.set(opts)
	M.current = vim.tbl_deep_extend('force', M.current, opts)
	vim.validate({
		ensure_installed = { M.current.ensure_installed, 'table', true },
		automatic_installation = { M.current.automatic_installation, { 'boolean', 'table' }, true },
	})
end

return M
