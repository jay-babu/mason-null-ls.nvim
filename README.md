`mason-null-ls` bridges `mason.nvim` with the `null-ls` plugin - making it easier to use both plugins together.


# Introduction

`mason-null-ls.nvim` closes some gaps that exist between `mason.nvim` and `null-ls`. Its main responsibilities are:

-   provide extra convenience APIs such as the `:NullLsInstall` command
-   allow you to (i) automatically install, and (ii) automatically set up a predefined list of sources
-   translate between `null-ls` source names and `mason.nvim` package names (e.g. `haml_lint` <-> `haml-lint`)

It is recommended to use this extension if you use `mason.nvim` and `null-ls`.
Please read the whole README.md before jumping to [Setup](#setup).

**Note: this plugin uses the `null-ls` source names in the APIs it exposes - not `mason.nvim` package names.


# Requirements

-   neovim `>= 0.7.0`
-   [`mason.nvim`](https://github.com/williamboman/mason.nvim)
-   [`null-ls.nvim`](https://github.com/jose-elias-alvarez/null-ls.nvim)


# Installation

## [Packer](https://github.com/wbthomason/packer.nvim)

```lua
use {
    "williamboman/mason.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "jayp0521/mason-null-ls.nvim",
}
```

## vim-plug

```vim
Plug 'williamboman/mason.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jayp0521/mason-null-ls.nvim'
```

# Commands

Available after calling `setup`.

-   `:NullInstall [<source>...]` - installs the provided sources
-   `:NullUninstall <source> ...` - uninstalls the provided sources


# Configuration

You may optionally configure certain behavior of `mason-null-ls.nvim` when calling the `.setup()` function. Refer to
the [default configuration](#default-configuration) for a list of all available settings.

Example:

```lua
require("mason-null-ls").setup({
    ensure_installed = { "stylua", "jq" }
})
```

## Default configuration

```lua
local DEFAULT_SETTINGS = {
    -- A list of sources to install if they're not already installed.
    -- This setting has no relation with the `automatic_installation` setting.
    ensure_installed = {},
    -- Run `require("null-ls").setup`.
    -- Will automatically install masons tools based on selected sources in `null-ls`.
    -- Can also be an exclusion list.
    -- Example: `automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }`
    automatic_installation = false,

	-- Whether sources that are installed in mason should be automatically set up in null-ls.
	-- Removes the need to set up null-ls manually.
	-- Can either be:
	-- 	- false: Null-ls is not automatically registered.
	-- 	- true: Null-ls is automatically registered.
	-- 	- { types = { SOURCE_NAME = {TYPES} } }. Allows overriding default configuration.
	-- 	Ex: { types = { eslint_d = {'formatting'} } }
	automatic_setup = false,
}
```

# Automatic Setup Usage

Automatic Setup is a need feature that removes the need to configure `null-ls` for supported sources.
Sources found installed in `mason` will automatically be setup for null-ls.

## Example Config

```lua
require("mason").setup()
require("mason-null-ls").setup({
    automatic_setup = true,
})
```

See the Default Configuration section to understand how the default dap configs can be overriden.


# Setup handlers usage

The `setup_handlers()` function provides a dynamic way of setting up sources and any other needed logic, It can also do that during runtime.

**NOTE:** When setting `automatic_setup = true`, the handler function needs to be called at a minimum like:
`require 'mason-null-ls'.setup_handlers()`. When passing in a custom handler function for the the default or a source,
then the automatic_setup function one won't be invoked. See below to keep original functionality inside the custom handler.

```lua
local null_ls = require 'null-ls'

require ('mason-null-ls').setup({
    ensure_installed = {'stylua', 'jq'}
})

require 'mason-null-ls'.setup_handlers {
    function(source_name, methods)
      -- all sources with no handler get passed here
    end,
    stylua = function(source_name, methods)
      null_ls.register(null_ls.builtins.formatting.stylua)
    end,
}

-- will setup any installed and configured sources above
null_ls.setup()
```

# Setup

There are primarily 2 paths to setup.

## Primary Source of Truth is `mason-null-ls`

This involves making sure tools are installed through `mason-null-ls` when available.

```lua
require("mason").setup()
require("mason-null-ls").setup({
    ensure_installed = {
        -- Opt to list sources here, when available in mason.
    },
    automatic_installation = false,
    automatic_setup = true, -- Recommended, but optional
})
require("null-ls").setup(
    sources = {
        -- Anything not supported by mason.
    }
)

require 'mason-null-ls'.setup_handlers() -- If `automatic_setup` is true.
```


## Primary Source of Truth is `null-ls`.
```lua
require("mason").setup()
require("null-ls").setup(
    sources = {
        -- all sources go here.
    }
)
require("mason-null-ls").setup({
    ensure_installed = nil,
    automatic_installation = true,
    automatic_setup = false,
})
```

Note: This is my personal preference.


# Available Null-ls sources


| Filetype                                                                                                                              | Source name            |
|---------------------------------------------------------------------------------------------------------------------------------------|------------------------|
| blade                                                                                                                                 | `blade_formatter`      |
| bzl                                                                                                                                   | `buildifier`           |
| c cpp                                                                                                                                 | `cpplint`              |
| c cpp cs java cuda                                                                                                                    | `clang_format`         |
| clj                                                                                                                                   | `joker`                |
| cs                                                                                                                                    | `csharpier`            |
| django jinja.html htmldjango                                                                                                          | `djlint`               |
| dockerfile                                                                                                                            | `hadolint`             |
| elm                                                                                                                                   | `elm_format`           |
| eruby                                                                                                                                 | `erb_lint`             |
| gitcommit                                                                                                                             | `gitlint`              |
| go                                                                                                                                    | `gofumpt`              |
| go                                                                                                                                    | `goimports`            |
| go                                                                                                                                    | `goimports_reviser`    |
| go                                                                                                                                    | `golangci_lint`        |
| go                                                                                                                                    | `golines`              |
| go                                                                                                                                    | `revive`               |
| go                                                                                                                                    | `staticcheck`          |
| haml                                                                                                                                  | `haml_lint`            |
| javascript typescript                                                                                                                 | `rome`                 |
| javascript javascriptreact typescript typescriptreact                                                                                 | `xo`                   |
| javascript javascriptreact typescript typescriptreact vue                                                                             | `eslint_d`             |
| javascript javascriptreact typescript typescriptreact vue css scss less html json jsonc yaml markdown markdown.mdx graphql handlebars | `prettier`             |
| javascript javascriptreact typescript typescriptreact vue css scss less html json jsonc yaml markdown markdown.mdx graphql handlebars | `prettierd`            |
| jinja.html htmldjango                                                                                                                 | `curlylint`            |
| json                                                                                                                                  | `fixjson`              |
| json                                                                                                                                  | `jq`                   |
| kotlin                                                                                                                                | `ktlint`               |
| lua                                                                                                                                   | `luacheck`             |
| lua                                                                                                                                   | `selene`               |
| lua                                                                                                                                   | `stylua`               |
| markdown                                                                                                                              | `alex`                 |
| markdown                                                                                                                              | `markdownlint`         |
| markdown                                                                                                                              | `write_good`           |
| markdown org                                                                                                                          | `cbfmt`                |
| markdown tex                                                                                                                          | `proselint`            |
| markdown tex asciidoc                                                                                                                 | `vale`                 |
| php                                                                                                                                   | `phpcbf`               |
| php                                                                                                                                   | `psalm`                |
| proto                                                                                                                                 | `buf`                  |
| proto                                                                                                                                 | `protolint`            |
| python                                                                                                                                | `autopep8`             |
| python                                                                                                                                | `black`                |
| python                                                                                                                                | `blue`                 |
| python                                                                                                                                | `flake8`               |
| python                                                                                                                                | `isort`                |
| python                                                                                                                                | `mypy`                 |
| python                                                                                                                                | `pylint`               |
| python                                                                                                                                | `vulture`              |
| python                                                                                                                                | `yapf`                 |
| ruby                                                                                                                                  | `rubocop`              |
| ruby                                                                                                                                  | `standardrb`           |
| sh                                                                                                                                    | `shellcheck`           |
| sh                                                                                                                                    | `shellharden`          |
| sh                                                                                                                                    | `shfmt`                |
| solidity                                                                                                                              | `solhint`              |
| sql                                                                                                                                   | `sqlfluff`             |
| sql                                                                                                                                   | `sql_formatter`        |
| toml                                                                                                                                  | `taplo`                |
| vim                                                                                                                                   | `vint`                 |
| yaml                                                                                                                                  | `actionlint`           |
| yaml                                                                                                                                  | `yamlfmt`              |
| yaml                                                                                                                                  | `yamllint`             |
| yaml json                                                                                                                             | `cfn_lint`             |
|                                                                                                                                       | `codespell`            |
|                                                                                                                                       | `cspell`               |
|                                                                                                                                       | `editorconfig_checker` |
|                                                                                                                                       | `misspell`             |
|                                                                                                                                       | `textlint`             |
