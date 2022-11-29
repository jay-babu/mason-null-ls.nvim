-- THIS FILE SHOULD BE GENERATED
-- stylua: ignore
return {
        -- Jenkinsfile = {
        --   "npm_groovy_lint"
        -- },
        -- arduino = {
        --   "astyle"
        -- },
        asciidoc = {
                "vale"
        },
        -- asm = {
        --   "asmfmt"
        -- },
        bash = {
                "beautysh"
        },
        -- beancount = {
        --   "bean_format"
        -- },
        -- bib = {
        --   "bibclean"
        -- },
        blade = {
                "blade_formatter"
        },
        bzl = {
                "buildifier"
        },
        c = {
                --   "clang_check",
                --   "cppcheck",
                "cpplint",
                --   "gccdiag",
                --   "astyle",
                "clang_format",
                --   "uncrustify"
        },
        -- cabal = {
        --   "cabal_fmt"
        -- },
        clj = {
                "joker"
        },
        -- clojure = {
        --   "clj_kondo",
        --   "cljstyle",
        --   "zprint"
        -- },
        cmake = {
                "cmake_format",
                "gersemi"
        },
        cpp = {
                --   "clang_check",
                --   "cppcheck",
                "cpplint",
                --   "gccdiag",
                --   "astyle",
                "clang_format",
                --   "uncrustify"
        },
        -- crystal = {
        --   "crystal_format"
        -- },
        cs = {
        --   "astyle",
                "clang_format",
                "csharpier",
        --   "uncrustify"
        },
        csh = {
                "beautysh"
        },
        css = {
                --   "stylelint",
                "prettier",
                "prettierd",
        },
        cuda = {
                "clang_format"
        },
        -- cue = {
        --   "cue_fmt",
        --   "cue_fmt"
        -- },
        -- d = {
        --   "dfmt"
        -- },
        -- dart = {
        --   "dart_format"
        -- },
        -- delphi = {
        --   "ptop"
        -- },
        django = {
                -- "djhtml",
                "djlint"
        },
        dockerfile = {
                "hadolint"
        },
        -- dosbatch = {
        --   "printenv"
        -- },
        -- elixir = {
        --   "credo",
        --   "mix",
        --   "surface"
        -- },
        elm = {
                "elm_format"
        },
        -- epuppet = {
        --   "puppet_lint",
        --   "puppet_lint"
        -- },
        -- erlang = {
        --   "erlfmt"
        -- },
        eruby = {
                "erb_lint",
        },
        -- fennel = {
        --   "fnlfmt"
        -- },
        -- fish = {
        --   "fish",
        --   "fish_indent"
        -- },
        -- fnl = {
        --   "fnlfmt"
        -- },
        -- fortran = {
        --   "fprettify"
        -- },
        -- gd = {
        --   "gdformat"
        -- },
        -- gdscript = {
        --   "gdlint",
        --   "gdformat"
        -- },
        -- gdscript3 = {
        --   "gdformat"
        -- },
        gitcommit = {
                "commitlint",
                "gitlint"
        },
        -- gitrebase = {
        --   "gitrebase"
        -- },
        -- glsl = {
        --   "glslc"
        -- },
        go = {
                --   "refactoring",
                "golangci_lint",
                "revive",
                --   "semgrep",
                "staticcheck",
                --   "gofmt",
                "gofumpt",
                "goimports",
                "goimports_reviser",
                "golines"
        },
        graphql = {
                "prettier",
                --   "prettier_d_slim",
                "prettierd"
        },
        -- groovy = {
        --   "npm_groovy_lint"
        -- },
        haml = {
                "haml_lint"
        },
        handlebars = {
                "prettier",
                --   "prettier_d_slim",
                "prettierd"
        },
        -- haskell = {
        --   "brittany",
        --   "fourmolu",
        --   "stylish_haskell"
        -- },
        -- hcl = {
        --   "packer"
        -- },
        html = {
                --   "tidy",
                "prettier",
                --   "prettier_d_slim",
                "prettierd",
                --   "rustywind",
                --   "tidy"
        },
        htmldjango = {
                "curlylint",
                "djlint",
                --   "djhtml",
        },
        java = {
        --   "semgrep",
        --   "astyle",
                "clang_format",
        --   "google_java_format",
        --   "npm_groovy_lint",
        --   "uncrustify"
        },
        javascript = {
                --   "eslint",
                "eslint_d",
                --   "refactoring",
                --   "eslint",
                --   "jshint",
                --   "standardjs",
                "xo",
                --   "deno_fmt",
                "dprint",
                --   "eslint",
                "prettier",
                --   "prettier_d_slim",
                --   "prettier_standard",
                "prettierd",
                "rome",
                --   "rustywind",
                --   "standardjs",
        },
        javascriptreact = {
                --   "eslint",
                "eslint_d",
                --   "eslint",
                --   "standardjs",
                "xo",
                --   "deno_fmt",
                "dprint",
                --   "eslint",
                "prettier",
                --   "prettier_d_slim",
                --   "prettier_standard",
                "prettierd",
                --   "rustywind",
                --   "standardjs",
        },
        ["jinja.html"] = {
                "curlylint",
                --   "djhtml",
                "djlint",
        },
        json = {
                "cfn-lint",
                "jsonlint",
                --   "spectral",
                --   "deno_fmt",
                "dprint",
                "fixjson",
                "jq",
                --   "json_tool",
                "prettier",
                --   "prettier_d_slim",
                "prettierd",
        },
        jsonc = {
                --   "deno_fmt",
                "prettier",
                --   "prettier_d_slim",
                "prettierd",
        },
        -- just = {
        --   "just",
        -- },
        kotlin = {
                "ktlint",
        },
        ksh = {
                "beautysh",
        },
        less = {
                "prettier",
                --   "prettier_d_slim",
                "prettierd",
                --   "stylelint",
        },
        lua = {
                --   "refactoring",
                "luacheck",
                "selene",
                --   "lua_format",
                "stylua",
        },
        -- make = {
        --   "checkmake",
        -- },
        markdown = {
                "alex",
                "markdownlint",
                --   "mdl",
                "proselint",
                "vale",
                "write_good",
                "cbfmt",
                --   "deno_fmt",
                "dprint",
                --   "markdown_toc",
                --   "mdformat",
                --   "ocdc",
                "prettier",
                --   "prettier_d_slim",
                "prettierd",
                --   "remark",
                --   "terrafmt",
                --   "dictionary",
        },
        -- matlab = {
        --   "mlint",
        -- },
        -- nginx = {
        --   "nginx_beautifier",
        -- },
        -- nim = {
        --   "nimpretty",
        -- },
        -- nix = {
        --   "statix",
        --   "deadnix",
        --   "statix",
        --   "alejandra",
        --   "nixfmt",
        --   "nixpkgs_fmt",
        -- },
        org = {
                "cbfmt",
        },
        -- pascal = {
        --   "ptop",
        -- },
        -- perl = {
        --   "perlimports",
        --   "perltidy",
        -- },
        -- pgsql = {
        --   "pg_format",
        -- },
        php = {
                --   "php",
                "phpcs",
                "phpmd",
                "phpstan",
                "psalm",
                "phpcbf",
                "phpcsfixer",
                "pint",
        },
        -- prisma = {
        --   "prismaFmt",
        -- },
        proto = {
                "buf",
                "protoc_gen_lint",
                "protolint",
        },
        -- ps1 = {
        --   "printenv",
        -- },
        -- pug = {
        --   "puglint",
        -- },
        -- puppet = {
        --   "puppet_lint",
        --   "puppet_lint",
        -- },
        python = {
                --   "refactoring",
                "flake8",
                "mypy",
                --   "pycodestyle",
                "pydocstyle",
                "pylama",
                "pylint",
                "pyproject_flake8",
                --   "semgrep",
                "vulture",
                "autopep8",
                "black",
                "blue",
                "isort",
                "reorder_python_imports",
                "ruff",
                "usort",
                "yapf",
        },
        -- qml = {
        --   "qmllint",
        --   "qmlformat",
        -- },
        -- r = {
        --   "format_r",
        --   "styler",
        -- },
        -- racket = {
        --   "raco_fmt",
        -- },
        -- rego = {
        --   "opacheck",
        -- },
        -- rescript = {
        --   "rescript",
        -- },
        -- rmd = {
        --   "format_r",
        --   "styler",
        -- },
        roslyn = {
                "dprint",
        },
        rst = {
                "rstcheck",
        },
        ruby = {
                "rubocop",
                --   "semgrep",
                --   "rufo",
                "standardrb",
        },
        rust = {
                "dprint",
                "rustfmt",
        },
        -- sass = {
        --   "stylelint",
        --   "stylelint",
        -- },
        -- scala = {
        --   "scalafmt",
        -- },
        scss = {
                --   "stylelint",
                "prettier",
                --   "prettier_d_slim",
                "prettierd",
                --   "stylelint",
        },
        sh = {
                "shellcheck",
                "beautysh",
                "shellharden",
                "shfmt",
                --   "printenv",
        },
        solidity = {
                "solhint",
        },
        -- spec = {
        --   "rpmspec",
        -- },
        sql = {
                --   "pg_format",
                "sql_formatter",
                "sqlfluff",
                --   "sqlformat",
        },
        -- stylus = {
        --   "stylint",
        -- },
        -- surface = {
        --   "surface",
        -- },
        -- svelte = {
        --   "rustywind",
        -- },
        -- swift = {
        --   "swiftformat",
        -- },
        systemverilog = {
                "verible_verilog_format",
        },
        -- teal = {
        --   "teal",
        -- },
        -- terraform = {
        --   "terraform_fmt",
        -- },
        tex = {
                --   "chktex",
                "proselint",
                "vale",
                --   "latexindent",
        },
        -- text = {
        --   "dictionary",
        -- },
        -- tf = {
        --   "terraform_fmt",
        -- },
        toml = {
                "dprint",
                "taplo",
        },
        twig = {
                "twigcs",
        },
        typescript = {
                --   "eslint",
                "eslint_d",
                --   "refactoring",
                --   "eslint",
                --   "semgrep",
                --   "tsc",
                "xo",
                --   "deno_fmt",
                "dprint",
                --   "eslint",
                "prettier",
                --   "prettier_d_slim",
                "prettierd",
                "rome",
                --   "rustywind",
        },
        typescriptreact = {
                --   "eslint",
                "eslint_d",
                --   "eslint",
                --   "semgrep",
                --   "tsc",
                "xo",
                --   "deno_fmt",
                "dprint",
                --   "eslint",
                "prettier",
                --   "prettier_d_slim",
                "prettierd",
                --   "rustywind",
        },
        verilog = {
                "verible_verilog_format",
        },
        vim = {
                "vint",
        },
        vue = {
                --   "eslint",
                "eslint_d",
                "prettier",
                --   "prettier_d_slim",
                "prettierd",
                --   "rustywind",
        },
        -- xml = {
        --   "tidy",
        --   "xmllint",
        -- },
        yaml = {
                "actionlint",
                "cfn-lint",
                --   "spectral",
                "yamllint",
                "prettier",
                --   "prettier_d_slim",
                "prettierd",
                "yamlfmt",
        },
        -- ["yaml.ansible"] = {
        --   "ansiblelint",
        -- },
        -- zig = {
        --   "zigfmt",
        -- },
        zsh = {
        --   "zsh",
                "beautysh",
        }
}
