local M = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
    "markdownlint",

    -- c/cpp stuff
    "clangd",
    "clang-format",
    "omnisharp",

    "gopls",
    "goimports", -- Automatically modify import table
    "revive", -- Gofmt
    "delve", -- Go debugger
    "gomodifytags",
    "impl",
    "gospel",

    "pyright",
    "pylint",

    "beautysh", -- Shell formatter
    "shellcheck",

  },
}

return M
