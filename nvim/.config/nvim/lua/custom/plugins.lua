local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "tpope/vim-fugitive",
    cmd = "Git"
  },
  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
  },
  {
    "rhysd/committia.vim",
  },
  {
    "zane-/cder.nvim",
    config = function()
      require("telescope").load_extension('cder')
      require("telescope").setup({
        extensions = {
          cder = {
            previewer_command = "exa -a -T --level=3 --git --git-ignore" ..
              " --long --no-permissions --no-user --color=always --icons" ..
              " --no-filesize --ignore-glob=.git",
            pager_command = "bat --pager=never --style=plain --color=always",
            entry_maker = function(line)
              return {
                value = line,
                display = function(entry)
                  return ' ' .. line:gsub(os.getenv('HOME') .. '/', ''),
                    { { { 1, 3 }, 'Directory' } }
                end,
                ordinal = line,
              }
            end,
          },
        },
      })
    end
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    lazy = false,
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
    opts = overrides.copilot,
  },

  {
    "zbirenbaum/copilot-cmp",
    lazy = false,
    config = function ()
      require("copilot_cmp").setup()
    end
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
