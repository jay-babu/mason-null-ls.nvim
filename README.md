# mason-null-ls

Install or upgrade the required tools needed for null-ls where available in Mason.

Currently installation of the tools must occur using a command on startup. 

`require("mason-null-ls").check_install()`

Uses Mason do the heavy lifting of installing the dependencies.

**Can automatically parse the null-ls table and install the necessary tools available in Mason.**

Note: Going through all null-ls builtins and mapping it to the correct tool name in Mason is still a WIP.
Feel free to create an issue or PR with a source you would like available immediately.

## Dependencies

- [mason.nvim](https://github.com/williamboman/mason.nvim.git)
- [mason-tools-installer](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim.git)
- [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim.git)
- Neovim >0.7

## Installation

### Packer Example

```lua
use {
	"jayp0521/mason-null-ls.nvim",
	after = {
		"null-ls.nvim",
		"mason.nvim",
		"mason-tool-installer.nvim"
	},
}
```

### Recommended
```lua
use {
	"jayp0521/mason-null-ls.nvim",
	after = {
		"null-ls.nvim",
		"mason.nvim",
		"mason-tool-installer.nvim"
	},
	config = function()
		require("mason-null-ls").setup({
			automatic_installation = true,
		})
		require("mason-null-ls").check_install(true)
	end,
}
```

## Configuration

```lua
require('mason-null-ls').setup {

  -- a list of all tools you want to ensure are installed upon
  -- start; they should be the names Mason uses for each tool
  ensure_installed = {

    -- you can pin a tool to a particular version
    { 'golangci-lint', version = '1.47.0' },

    -- you can turn off/on auto_update per tool
    { 'shellcheck', auto_update = true },

    'stylua',
    'shellcheck',
    'editorconfig-checker',
    'revive',
    'shellcheck',
    'shfmt',
    'staticcheck',
    'vint',
  },

	null_ls_sources = {
		-- Will install the all necessary tools from Mason, in this case `write-good`.
		-- Source must map to the source name in `null-ls`.
		-- Pinning a version or toggling auto_update per tool is not supported.
		'write_good',
	},

  -- if set to true this will check each tool for updates. If updates
  -- are available the tool will be updated. This setting does not
  -- affect :MasonNullLsUpdate or :MasonNullLsInstall.
  -- Default: false
  auto_update = false,

  -- if set to true, the tool will check null-ls for the available sources,
  -- and then install the dependency(ies) if available in mason.
  -- Default: true
  automatic_installation = true
}
```

## Commands

`:MasonNullLsInstall` - only installs tools that are missing or at the incorrect version
`:MasonNullLsUpdate` - install missing tools and update already installed tools

## Events

Upon completion of any `mason-null-ls` initiated installation/update a user event will be
emitted named `MasonNullLsUpdateCompleted`. To use this event you can setup an event handler like so:

```lua
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MasonNullLsUpdateCompleted',
    callback = function()
      vim.schedule(print 'mason-null-ls has finished')
    end,
  })
```

## Suggestions / Complaints / Help

Create an issue at: https://github.com/jayp0521/mason-null-ls.nvim/issues

## Acknowledgments

This tool depends on `mason.nvim` and `null-ls.nvim` as mentioned earlier.
It is also heavily inspired by [`mason-tool-installer`](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim).
Much of the code and even this README.md is based off of it.
