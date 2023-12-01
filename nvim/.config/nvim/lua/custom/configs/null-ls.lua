local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with {
    filetypes = { "html", "markdown", "css", "yaml" },
    extra = { "toml" },
  }, -- so prettier works only on these filetypes

  -- Code actions
  b.code_actions.gomodifytags, -- Modify go struc tags
  b.code_actions.impl, -- Go interface implentation stubs

  -- Linters
  b.diagnostics.gospel,
  b.diagnostics.markdownlint,
  b.diagnostics.pylint,
  b.diagnostics.revive,
  b.diagnostics.shellcheck,

  -- Formatters
  b.formatting.gofmt,
  b.formatting.goimports,
  b.formatting.stylua,
  b.formatting.clang_format,
  b.formatting.beautysh,
}

null_ls.setup {
  debug = true,
  sources = sources,
}

