$PIP_PACKAGES = @(
  "ruff",
  "cpplint"
)

$NPM_PACKAGES = @(
  "prettier",
  "eslint",
  "markdownlint",
  "commitizen"
)

pip intsall $PIP_PACKAGES
npm install @NPM_PACKAGES -g
