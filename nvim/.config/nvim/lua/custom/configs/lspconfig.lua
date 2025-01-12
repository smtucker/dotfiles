local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "ts_ls", "clangd", "gopls", "basedpyright" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- 
-- lspconfig.pyright.setup {
--   settings = {
--     python = {
--       analysis = {
--         autoSearchPaths = true,
--         diagnosticMode = "workspace",
--         useLibraryCodeForTypes = true
--       },
--     },
--   },
-- }

lspconfig["lua_ls"].setup {
  on_attach = on_attach,
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
      client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = "Apply",
            -- library = {
            -- vim.env.VIMRUNTIME,
            -- vim.expand("$HOME/.config/nvim/lua/core"),
            -- "${3rd}/luv/library"
            -- "${3rd}/busted/library",
            -- }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            library = vim.api.nvim_get_runtime_file("", true),
          },
        },
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
}

local cmp_nvim_lsp = require "cmp_nvim_lsp"
lspconfig["clangd"].setup {
  on_attach = on_attach,
  capabilities = cmp_nvim_lsp.default_capabilities(),
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
}

-- lspconfig.omnisharp.setup {
--   capabilities = capabilities,
--   cmd = { "dotnet", vim.fn.stdpath "data" .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
--   enable_import_completion = true,
--   organize_imports_on_format = true,
--   enable_roslyn_analyzers = true,
--   root_dir = function ()
--     return vim.loop.cwd() -- current working directory
--   end,
-- }

lspconfig["gdscript"].setup {
    	name = "godot",
    	cmd = vim.lsp.rpc.connect("127.0.0.1", "6005"),
}
