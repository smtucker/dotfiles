local M = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- shell
    "bash-language-server",

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
    -- "omnisharp",
    "roslyn",

    -- Protobuf
    "protols",

    -- "gopls",
    "goimports", -- Automatically modify import table
    "revive", -- Gofmt
    "delve", -- Go debugger
    "gomodifytags",
    "impl",
    "gospel",

    "basedpyright",
    -- "pyright",
    "pylint",

    "beautysh", -- Shell formatter
    "shellcheck",

  },
}

return M
