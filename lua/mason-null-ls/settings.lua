local M = {}

---@class MasonNullLsSettings
---@field handlers table | nil
---@field automatic_setup boolean | table
---@field ensure_installed table
---@field automatic_installation boolean | table
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
	-- Whether sources that are installed in mason should be automatically set up in null-ls.
	-- Removes the need to set up null-ls manually.
	-- Can either be:
	-- 	- false: Null-ls is not automatically registered.
	-- 	- true: Null-ls is automatically registered.
	-- 	- { types = { SOURCE_NAME = {TYPES} } }. Allows overriding default configuration.
	-- 	Ex: { types = { eslint_d = {'formatting'} } }
	automatic_setup = false,
	handlers = nil,
}

M._DEFAULT_SETTINGS = DEFAULT_SETTINGS
M.current = M._DEFAULT_SETTINGS

---@param opts MasonNullLsSettings
function M.set(opts)
	if opts.automatic_setup == true then
		opts.automatic_setup = {}
	end

	M.current = vim.tbl_deep_extend('force', M.current, opts)
	vim.validate({
		ensure_installed = { M.current.ensure_installed, 'table', true },
		automatic_installation = { M.current.automatic_installation, { 'boolean', 'table' }, true },
		automatic_setup = { M.current.automatic_setup, { 'boolean', 'table' }, true },
		handlers = { M.current.handlers, { 'table' }, true },
	})
end

return M
