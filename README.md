<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [Introduction](#introduction)
  - [Star History](#star-history)
- [Requirements](#requirements)
- [Installation](#installation)
  - [Packer](#packer)
  - [lazy.nvim](#lazy.nvim)
  - [vim-plug](#vim-plug)
- [Commands](#commands)
- [Configuration](#configuration)
  - [Default configuration](#default-configuration)
- [Automatic Setup Usage](#automatic-setup-usage)
  - [Example Config](#example-config)
- [Setup handlers usage](#setup-handlers-usage)
- [Setup](#setup)
  - [Primary Source of Truth is `mason-null-ls`](#primary-source-of-truth-is-mason-null-ls)
  - [Primary Source of Truth is `null-ls`.](#primary-source-of-truth-is-null-ls)
- [Available Null-ls sources](#available-null-ls-sources)
  - [Auto-resolve logic](#auto-resolve-logic)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

`mason-null-ls` bridges `mason.nvim` with the `null-ls` plugin - making it easier to use both plugins together.

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

`mason-null-ls.nvim` closes some gaps that exist between `mason.nvim` and `null-ls`. Its main responsibilities are:

- provide extra convenience APIs such as the `:NullLsInstall` command
- allow you to (i) automatically install, and (ii) automatically set up a predefined list of sources
- translate between `null-ls` source names and `mason.nvim` package names (e.g. `haml_lint` <-> `haml-lint`)

It is recommended to use this extension if you use `mason.nvim` and `null-ls`.
Please read the whole README.md before jumping to [Setup](#setup).

**Note**: this plugin uses the `null-ls` source names in the APIs it exposes - not `mason.nvim` package names.

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=jay-babu/mason-null-ls.nvim,jay-babu/mason-nvim-dap.nvim&type=Date)](https://star-history.com/#jay-babu/mason-null-ls.nvim&jay-babu/mason-nvim-dap.nvim&Date)

# Requirements

- neovim `>= 0.7.0`
- [`mason.nvim`](https://github.com/williamboman/mason.nvim)
- [`null-ls.nvim`](https://github.com/jose-elias-alvarez/null-ls.nvim)

# Installation

## [Packer](https://github.com/wbthomason/packer.nvim)

```lua
use {
    "williamboman/mason.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "jay-babu/mason-null-ls.nvim",
}
```

## [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require("your.null-ls.config") -- require your null-ls config here (example below)
    end,
}
```

## vim-plug

```vim
Plug 'williamboman/mason.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jay-babu/mason-null-ls.nvim'
```

# Commands

Available after calling `setup`.

- `:NullInstall [<source>...]` - installs the provided sources
- `:NullUninstall <source> ...` - uninstalls the provided sources

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

See the Default Configuration section to understand how the default dap configs can be overridden.

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

      -- To keep the original functionality of `automatic_setup = true`,
      -- please add the below.
      require("mason-null-ls.automatic_setup")(source_name, methods)
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
require("null-ls").setup({
    sources = {
        -- Anything not supported by mason.
    }
})

require 'mason-null-ls'.setup_handlers() -- If `automatic_setup` is true.

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
    automatic_setup = false,
})
```

# Available Null-ls sources

Ever since this [commit](https://github.com/jay-babu/mason-null-ls.nvim/commit/e2144bd62b703c1fa298b9e154296caeef389553), 
this plugin attempts to auto-resolve between mason and null-ls. If this is not possible, then there is a way to add 
[exceptions](https://github.com/jay-babu/mason-null-ls.nvim/blob/main/lua/mason-null-ls/mappings/source.lua).

## Auto-resolve logic

null-ls source name `google_java_format`, `mason-null-ls` will attempt to look for an override and if not found,
then will attempt to look for a mason named: `google-java-format`.
