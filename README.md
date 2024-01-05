<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [Introduction](#introduction)
  - [Star History](#star-history)
- [Requirements](#requirements)
- [Installation](#installation)
  - [lazy.nvim](#lazynvim)
  - [vim-plug](#vim-plug)
- [Commands](#commands)
- [Configuration](#configuration)
  - [Default configuration](#default-configuration)
- [Automatic Setup Usage](#automatic-setup-usage)
  - [Example Config](#example-config)
- [Handlers usage](#handlers-usage)
- [Setup](#setup)
  - [Primary Source of Truth is `mason-null-ls`](#primary-source-of-truth-is-mason-null-ls)
  - [Primary Source of Truth is `null-ls`.](#primary-source-of-truth-is-null-ls)
- [Available Null-ls sources](#available-null-ls-sources)
  - [Auto-resolve logic](#auto-resolve-logic)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

`mason-null-ls` bridges `mason.nvim` with the `null-ls` plugin - making it
easier to use both plugins together.

# Introduction

<p align="center">
    <a href="https://github.com/jay-babu/mason-null-ls.nvim/pulse">
      <img src="https://img.shields.io/github/last-commit/jay-babu/mason-null-ls.nvim?style=for-the-badge&logo=github&color=7dc4e4&logoColor=D9E0EE&labelColor=302D41"/>
    </a>
    <a href="https://github.com/jay-babu/mason-null-ls.nvim/releases/latest">
      <img src="https://img.shields.io/github/v/release/jay-babu/mason-null-ls.nvim?style=for-the-badge&logo=gitbook&color=8bd5ca&logoColor=D9E0EE&labelColor=302D41"/>
    </a>
    <a href="https://github.com/jay-babu/mason-null-ls.nvim/stargazers">
      <img src="https://img.shields.io/github/stars/jay-babu/mason-null-ls.nvim?style=for-the-badge&logo=apachespark&color=eed49f&logoColor=D9E0EE&labelColor=302D41"/>
    </a>
</p>

`mason-null-ls.nvim` closes some gaps that exist between `mason.nvim` and
`null-ls`. Its main responsibilities are:

- provide extra convenience APIs such as the `:NullLsInstall` command
- allow you to (i) automatically install, and (ii) automatically set up a
  predefined list of sources
- translate between `null-ls` source names and `mason.nvim` package names (e.g.
  `haml_lint` <-> `haml-lint`)

It is recommended to use this extension if you use `mason.nvim` and `null-ls`.
Please read the whole README.md before jumping to [Setup](#setup).

**Note**: this plugin uses the `null-ls` source names in the APIs it exposes -
not `mason.nvim` package names.

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=jay-babu/mason-null-ls.nvim,jay-babu/mason-nvim-dap.nvim&type=Date)](https://star-history.com/#jay-babu/mason-null-ls.nvim&jay-babu/mason-nvim-dap.nvim&Date)

# Requirements

- neovim `>= 0.7.0`
- [`mason.nvim`](https://github.com/williamboman/mason.nvim)
- [`null-ls.nvim`](https://github.com/jose-elias-alvarez/null-ls.nvim)

# Installation

## [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("your.null-ls.config") -- require your null-ls config here (example below)
    end,
}
```

## vim-plug

```vim
Plug 'williamboman/mason.nvim'
Plug 'nvimtools/none-ls.nvim'
Plug 'jay-babu/mason-null-ls.nvim'
```

# Commands

Available after calling `setup`.

- `:NullLsInstall [<source>...]` - installs the provided sources
- `:NoneLsInstall [<source>...]` - installs the provided sources
- `:NullLsUninstall <source> ...` - uninstalls the provided sources
- `:NoneLsUninstall <source> ...` - uninstalls the provided sources

# Configuration

You may optionally configure certain behavior of `mason-null-ls.nvim` when
calling the `.setup()` function. Refer to the
[default configuration](#default-configuration) for a list of all available
settings.

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
    -- See [#handlers-usage](#handlers-usage) section
    handlers = nil,
}
```

# Automatic Setup Usage

Automatic Setup is a need feature that removes the need to configure `null-ls`
for supported sources. Sources found installed in `mason` will automatically be
setup for null-ls.

## Example Config

```lua
require("mason").setup()
require("mason-null-ls").setup({
    handlers = {},
})
```

See the Default Configuration section to understand how the default configs
can be overridden.

# Handlers usage

The `handlers` table provides a dynamic way of setting up sources and any other
needed logic, It can also do that during runtime.

Providing an empty `handlers` will cause all sources to be automatically
registered in `null-ls`. See below example on how to disable.

```lua
local null_ls = require 'null-ls'
null_ls.setup()

require ('mason-null-ls').setup({
    ensure_installed = {'stylua', 'jq'},
    handlers = {
        function() end, -- disables automatic setup of all null-ls sources
        stylua = function(source_name, methods)
          null_ls.register(null_ls.builtins.formatting.stylua)
        end,
        shfmt = function(source_name, methods)
          -- custom logic
          require('mason-null-ls').default_setup(source_name, methods) -- to maintain default behavior
        end,
    },
})
```

# Setup

There are primarily 2 paths to setup.

## Primary Source of Truth is `mason-null-ls`

This involves making sure tools are installed through `mason-null-ls` when
available.

```lua
require("mason").setup()
require("mason-null-ls").setup({
    ensure_installed = {
        -- Opt to list sources here, when available in mason.
    },
    automatic_installation = false,
    handlers = {},
})
require("null-ls").setup({
    sources = {
        -- Anything not supported by mason.
    }
})

Note: This is my personal preference.
```

## Primary Source of Truth is `null-ls`.

```lua
require("mason").setup()
require("null-ls").setup({
    sources = {
        -- all sources go here.
    }
})
require("mason-null-ls").setup({
    ensure_installed = nil,
    automatic_installation = true,
})
```

# Available Null-ls sources

Ever since this
[commit](https://github.com/jay-babu/mason-null-ls.nvim/commit/e2144bd62b703c1fa298b9e154296caeef389553),
this plugin attempts to auto-resolve between mason and null-ls. If this is not
possible, then there is a way to add
[exceptions](https://github.com/jay-babu/mason-null-ls.nvim/blob/main/lua/mason-null-ls/mappings/source.lua).

## Auto-resolve logic

null-ls source name `google_java_format`, `mason-null-ls` will attempt to look
for an override and if not found, then will attempt to look for a mason named:
`google-java-format`.
