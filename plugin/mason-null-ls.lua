vim.api.nvim_create_autocmd({ 'VimEnter' }, {
	callback = require('mason-null-ls').run_on_start,
})
