# Changelog

## [2.1.0](https://github.com/jay-babu/mason-null-ls.nvim/compare/v2.0.2...v2.1.0) (2023-07-04)


### Features

* add deno_fmt mapping ([398a0e9](https://github.com/jay-babu/mason-null-ls.nvim/commit/398a0e9a01539f0a3f00ac7a801f6479c6478fb0))
* add mapping for ansible linter ([#75](https://github.com/jay-babu/mason-null-ls.nvim/issues/75)) ([ce6b1b5](https://github.com/jay-babu/mason-null-ls.nvim/commit/ce6b1b55088ac2f6bc3bde2ca9e2977b581e5d33))

## [2.0.2](https://github.com/jay-babu/mason-null-ls.nvim/compare/v2.0.1...v2.0.2) (2023-04-22)


### Bug Fixes

* don't import removed mason.mappings.language module from mason ([#66](https://github.com/jay-babu/mason-null-ls.nvim/issues/66)) ([dbf3486](https://github.com/jay-babu/mason-null-ls.nvim/commit/dbf34867375d9a7250d7c4fb1266895842a76c64))

## [2.0.1](https://github.com/jay-babu/mason-null-ls.nvim/compare/v2.0.0...v2.0.1) (2023-04-19)


### Bug Fixes

* don't memoize default_setup ([#62](https://github.com/jay-babu/mason-null-ls.nvim/issues/62)) ([0bf4c84](https://github.com/jay-babu/mason-null-ls.nvim/commit/0bf4c84f1c37506430c088f089d68c561245d3dc))

## [2.0.0](https://github.com/jay-babu/mason-null-ls.nvim/compare/v1.2.0...v2.0.0) (2023-04-09)


### ⚠ BREAKING CHANGES

* removing `setup_handlers` function. automatic_setup is now implicitly true. ([#59](https://github.com/jay-babu/mason-null-ls.nvim/issues/59))

### Features

* removing `setup_handlers` function. automatic_setup is now implicitly true. ([#59](https://github.com/jay-babu/mason-null-ls.nvim/issues/59)) ([a0c4dc1](https://github.com/jay-babu/mason-null-ls.nvim/commit/a0c4dc10106521e5956f106a5ab6a2541737fde1))

## [1.2.0](https://github.com/jay-babu/mason-null-ls.nvim/compare/v1.1.0...v1.2.0) (2023-03-27)


### Features

* allowing handlers to be passed in via `setup` function ([35ce897](https://github.com/jay-babu/mason-null-ls.nvim/commit/35ce897a8c924b37c0f4ea8789ade6205e347591))
* refresh registry before installing servers in ensure_installed ([43f33ba](https://github.com/jay-babu/mason-null-ls.nvim/commit/43f33ba1ba81fa3864f8683b1157efa099f8c9bc))

## [1.1.0](https://github.com/jay-babu/mason-null-ls.nvim/compare/v1.0.0...v1.1.0) (2023-02-18)


### Features

* **java:** add google_java_format ([8cb04ca](https://github.com/jay-babu/mason-null-ls.nvim/commit/8cb04ca019a1f1e0df86ca56a04bd40fff142dc8))

## 1.0.0 (2023-02-16)


### ⚠ BREAKING CHANGES

* source.lua is not required for package names following normal conventions ([#40](https://github.com/jay-babu/mason-null-ls.nvim/issues/40))
* port mason-lspconfig features

### Features

* add beautysh ([#20](https://github.com/jay-babu/mason-null-ls.nvim/issues/20)) ([46e4122](https://github.com/jay-babu/mason-null-ls.nvim/commit/46e41221dd419eb7f4f3119dec50d861a0a6158f))
* add latexindent ([#48](https://github.com/jay-babu/mason-null-ls.nvim/issues/48)) ([13c6ab4](https://github.com/jay-babu/mason-null-ls.nvim/commit/13c6ab4a4f810cbbb1799a9cf4d4a27fd862d885))
* add ocamlformat ([#45](https://github.com/jay-babu/mason-null-ls.nvim/issues/45)) ([c4b4a6f](https://github.com/jay-babu/mason-null-ls.nvim/commit/c4b4a6fe3cb8d8590b831c22b3475166dc9a894e))
* add stylelint ([1d07c80](https://github.com/jay-babu/mason-null-ls.nvim/commit/1d07c80722f3e2c67b932797c4c7672d8769d587))
* **commitlint:** support for `commitlint` is enabled ([#33](https://github.com/jay-babu/mason-null-ls.nvim/issues/33)) ([1128f0d](https://github.com/jay-babu/mason-null-ls.nvim/commit/1128f0d940cb2e93397d58a7177c866e8ca2f11f))
* **jsonlint:** support for `jsonlint` is enabled ([#32](https://github.com/jay-babu/mason-null-ls.nvim/issues/32)) ([564ed12](https://github.com/jay-babu/mason-null-ls.nvim/commit/564ed1231ee78144ac1bb2da914c4c7791552005))
* **lua_format:** add support for lua_format ([bb5ee05](https://github.com/jay-babu/mason-null-ls.nvim/commit/bb5ee05e1f0ea01a6780e1a99f26b7adba94c83d))
* port mason-lspconfig features ([38fba6a](https://github.com/jay-babu/mason-null-ls.nvim/commit/38fba6aaf51dd7b6f13113d80192b2e9a4130de6))
* **registry:** add protolint ([1f83f0d](https://github.com/jay-babu/mason-null-ls.nvim/commit/1f83f0de996cd011fb20ad3c60fa4517912179f0))
* source.lua is not required for package names following normal conventions ([#40](https://github.com/jay-babu/mason-null-ls.nvim/issues/40)) ([e2144bd](https://github.com/jay-babu/mason-null-ls.nvim/commit/e2144bd62b703c1fa298b9e154296caeef389553))
* **source:** add python pylama source ([#21](https://github.com/jay-babu/mason-null-ls.nvim/issues/21)) ([633d4ca](https://github.com/jay-babu/mason-null-ls.nvim/commit/633d4ca96d11c351768f099327e650f1d6534f9c))
