vim.api.nvim_create_autocmd({ 'VimEnter' }, {
	callback = function()
		print('running mason-null-ls')
		return require('mason-null-ls').run_on_start
	end,
})
vim.api.nvim_create_user_command('MasonNullLsUpdate', function()
	require('mason-tool-installer').check_install(true)
end, { force = true })
vim.api.nvim_create_user_command('MasonNullLsInstall', function()
	require('mason-tool-installer').check_install(false)
end, { force = true })
