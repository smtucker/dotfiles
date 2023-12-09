
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
    opts = require "custom.configs.mason"
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "custom.configs.treesitter",
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = require "custom.configs.nvimtree",
  },
  {
    "hrsh7th/nvim-cmp",
    opts = require "custom.configs.nvimcmp"
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = require "custom.configs.telescope"
  },
  -- Install a plugin
  { "folke/neodev.nvim", opts = {} },
  {
    "mfussenegger/nvim-dap",
  },
  {
    "leoluz/nvim-dap-go",
  },
  {
    "rcarriga/nvim-dap-ui"
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
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
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },
  {
    "yorickpeterse/nvim-pqf",
    ft = "qf",
    init = function()
      require("pqf").setup()
    end
  },
  {
    "zane-/cder.nvim",
    config = function()
      require "custom.configs.cder"
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
    event = "InsertEnter",
    config = function()
      require "custom.configs.copilot"
    end,
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
