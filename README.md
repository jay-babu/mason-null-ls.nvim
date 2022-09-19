`mason-null-ls` bridges `mason.nvim` with the `null-ls` plugin - making it easier to use both plugins together.


# Introduction

`mason-null-ls.nvim` closes some gaps that exist between `mason.nvim` and `null-ls`. Its main responsibilities are:

-   provide extra convenience APIs such as the `:NullLsInstall` command
-   allow you to (i) automatically install, and (ii) automatically set up a predefined list of sources
-   translate between `null-ls` source names and `mason.nvim` package names (e.g. `haml_lint` <-> `haml-lint`)

It is recommended to use this extension if you use `mason.nvim` and `null-ls`.

**Note: this plugin uses the `null-ls` source names in the APIs it exposes - not `mason.nvim` package names.


# Requirements

-   neovim `>= 0.7.0`
-   `mason.nvim`
-   `null-ls.nvim`


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


# Setup

It's important that you set up the plugins in the following order:

1. `mason.nvim`
2. `null-ls`
3. `mason-null-ls.nvim`

Pay extra attention to this if you're using a plugin manager to load plugins for you, as there are no guarantees it'll
load plugins in the correct order unless explicitly instructed to.

```lua
require("mason").setup()
require("null-ls").setup()
require("mason-null-ls").setup()
```

Refer to the [Configuration](#configuration) section for information about which settings are available.


# Commands

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
    automatic_installation = false,
}
```


# Setup handlers usage

The `setup_handlers()` function provides a dynamic way of setting up sources and any other needed logic, It can also do that during runtime.

```lua
local null_ls = require 'null-ls'

require ('mason-null-ls').setup({
    ensure_installed = {'stylua', 'jq'}
})
  
require 'mason-null-ls'.setup_handlers {
    function(source_name)
      -- all sources with no handler get passed here
    end,
    stylua = function()
      null_ls.register(null_ls.builtins.formatting.stylua)
    end,
    jq = function()
      null_ls.register(null_ls.builtins.formatting.jq)
    end
}

-- will setup any installed and configured sources above
null_ls.setup()
```


# Available Null-ls sources


| Filetype                                                  | Source name            |
|-----------------------------------------------------------|------------------------|
| bzl                                                       | `buildifier`           |
| c cpp                                                     | `cpplint`              |
| django jinja.html htmldjango                              | `djlint`               |
| dockerfile                                                | `hadolint`             |
| eruby                                                     | `erb_lint`             |
| gitcommit                                                 | `gitlint`              |
| go                                                        | `golangci_lint`        |
| go                                                        | `revive`               |
| go                                                        | `staticcheck`          |
| haml                                                      | `haml_lint`            |
| javascript javascriptreact typescript typescriptreact     | `xo`                   |
| javascript javascriptreact typescript typescriptreact vue | `eslint_d`             |
| jinja.html htmldjango                                     | `curlylint`            |
| json                                                      | `jq`                   |
| kotlin                                                    | `ktlint`               |
| lua                                                       | `luacheck`             |
| lua                                                       | `selene`               |
| lua                                                       | `stylua`               |
| markdown                                                  | `alex`                 |
| markdown                                                  | `markdownlint`         |
| markdown                                                  | `write_good`           |
| markdown tex                                              | `proselint`            |
| markdown tex asciidoc                                     | `vale`                 |
| php                                                       | `psalm`                |
| proto                                                     | `buf`                  |
| python                                                    | `flake8`               |
| python                                                    | `mypy`                 |
| python                                                    | `pylint`               |
| python                                                    | `vulture`              |
| ruby                                                      | `rubocop`              |
| ruby                                                      | `standardrb`           |
| sh                                                        | `shellcheck`           |
| sh                                                        | `shfmt`                |
| solidity                                                  | `solhint`              |
| sql                                                       | `sqlfluff`             |
| vim                                                       | `vint`                 |
| yaml                                                      | `actionlint`           |
| yaml                                                      | `yamllint`             |
| yaml Json                                                 | `cfn-lint`             |
|                                                           | `cspell`               |
|                                                           | `editorconfig_checker` |
|                                                           | `misspell`             |
|                                                           | `textlint`             |
