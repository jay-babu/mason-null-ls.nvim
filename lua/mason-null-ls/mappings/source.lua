local _ = require('mason-core.functional')

local M = {}

---Maps null_ls source name to its corresponding package name.
M.null_ls_to_package = {
	['actionlint'] = 'actionlint',
	['jq'] = 'jq',
	['alex'] = 'alex',
	['buf'] = 'buf',
	['buildifier'] = 'buildifier',
	['cfn-lint'] = 'cfn-lint',
	['cpplint'] = 'cpplint',
	['cspell'] = 'cspell',
	['curlylint'] = 'curlylint',
	['djlint'] = 'djlint',
	['editorconfig_checker'] = 'editorconfig-checker',
	['erb_lint'] = 'erb-lint',
	['eslint_d'] = 'eslint_d',
	['flake8'] = 'flake8',
	['gitlint'] = 'gitlint',
	['golangci_lint'] = 'golangci-lint',
	['hadolint'] = 'hadolint',
	['haml_lint'] = 'haml-lint',
	['ktlint'] = 'ktlint',
	['luacheck'] = 'luacheck',
	['markdownlint'] = 'markdownlint',
	['misspell'] = 'misspell',
	['mypy'] = 'mypy',
	['proselint'] = 'proselint',
	['psalm'] = 'psalm',
	['pylint'] = 'pylint',
	['revive'] = 'revive',
	['rubocop'] = 'rubocop',
	['selene'] = 'selene',
	['shellcheck'] = 'shellcheck',
	['shfmt'] = 'shfmt',
	['solhint'] = 'solhint',
	['sqlfluff'] = 'sqlfluff',
	['standardrb'] = 'standardrb',
	['staticcheck'] = 'staticcheck',
	['stylua'] = 'stylua',
	['textlint'] = 'textlint',
	['vale'] = 'vale',
	['vint'] = 'vint',
	['vulture'] = 'vulture',
	['write_good'] = 'write-good',
	['xo'] = 'xo',
	['yamllint'] = 'yamllint',
}

M.package_to_null_ls = _.invert(M.null_ls_to_package)

return M
