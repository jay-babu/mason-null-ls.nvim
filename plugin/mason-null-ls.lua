vim.api.nvim_create_autocmd({ 'VimEnter' }, {
	callback = function()
		print('running mason-null-ls')
		return require('mason-null-ls').run_on_start
	end,
})
