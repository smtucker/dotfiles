-- Language Servers configured in this file (must be installed manually):
-- html
-- cssls
-- ts_ls (TypeScript)
-- pyright (Python)
-- protols (Protocol Buffers)
-- bashls (Bash)
-- denols (Deno)
-- gopls (Go)
-- lua_ls (Lua)
-- clangd (C/C++)
-- gdscript (Godot Engine)

local function on_attach(client, bufnr)
  -- Filter out nvimtree buffers
  if vim.api.nvim_buf_get_option(bufnr, "buftype") == "acmd" then
    return
  end
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
end

local servers = { "html", "cssls", "ts_ls", "pyright", "protols", "bashls", "denols"}
for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    on_attach = on_attach,
  })
  vim.lsp.enable(server)
end

vim.lsp.config('gopls', {
  on_attach = on_attach,
  cmd = { "gopls", "--remote=auto" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})
vim.lsp.enable('gopls')

vim.lsp.config('lua_ls', {
  on_attach = on_attach,
  on_init = function(client)
    if not client.workspace_folders or client.workspace_folders == 0 then
      return true
    end
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
      client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            checkThirdParty = "Apply",
            library = vim.api.nvim_get_runtime_file("", true),
          },
        },
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end,
})
vim.lsp.enable('lua_ls')

vim.lsp.config('clangd', {
  filetypes = { "c", "cpp" },
  on_attach = on_attach,
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
})
vim.lsp.enable('clangd')

vim.lsp.config('gdscript', {
  on_attach = on_attach,
  name = "godot",
  filetypes = { "gd", "gdscript" },
})
vim.lsp.enable('gdscript')
