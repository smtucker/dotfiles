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
					require("custom.configs.null-ls")
				end,
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},

	-- override plugin configs
	{
		"NvChad/nvterm",
		opts = {
      terminals = {
        type_opts = {
          float = {
            row = .2,
            col = .15,
            width = 0.7,
            height = 0.6,
          },
        },
      },
		},
	},

	{
		"williamboman/mason.nvim",
		opts = require("custom.configs.mason"),
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = require("custom.configs.treesitter"),
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = require("custom.configs.nvimtree"),
	},
	{
		"hrsh7th/nvim-cmp",
		opts = require("custom.configs.nvimcmp"),
    event = {
      "InsertEnter",
      "CmdlineEnter",
    },
		dependencies = {
			"hrsh7th/cmp-cmdline",
		},
		init = function()
			require("custom.configs.cmpcmdline")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		opts = require("custom.configs.telescope"),
	},

	-- General
  {
    dir = "~/code/autodircmds/",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      log_level = "debug",
      dirs = {
        {
          "~/notes",
          preopen = "!sync-notes down %",
          postwrite = "!sync-notes up %",
        },
      },
    },
    lazy = false,
    -- config = function()
    --   require("autodircmds").setup()
    -- end,
  },
	{
		"matbme/JABS.nvim",
		cmd = "JABSOpen",
		config = function()
			require("jabs").setup()
		end,
	},
	{
		"folke/neodev.nvim",
		opts = {
			library = {
				plugins = { "nvim-dap-ui" },
				types = true,
			},
		},
	}, -- Loads vim API into lua lsp
	{
		"ggandor/leap.nvim",
		init = function()
			require("leap").add_default_mappings()
		end,
	},
	{
		"abecodes/tabout.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("tabout").setup({
				tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
				backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
				act_as_tab = true, -- shift content if tab out is not possible
				act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
				default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
				default_shift_tab = "<C-d>", -- reverse shift default action,
				enable_backwards = true, -- well ...
				completion = true, -- if the tabkey is used in a completion pum
				tabouts = {
					{ open = "'", close = "'" },
					{ open = '"', close = '"' },
					{ open = "`", close = "`" },
					{ open = "(", close = ")" },
					{ open = "[", close = "]" },
					{ open = "{", close = "}" },
				},
				ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
				exclude = {}, -- tabout will ignore these filetypes
			})
		end,
		ft = { "go", "python", "lua", "rust", "c", "cpp" },
	},
	{
		"nvim-neorg/neorg",
		dir = "~/code/neorg/",
		build = ":Neorg sync-parsers",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = "norg",
		cmd = "Neorg",
		config = function()
			require("custom.configs.neorg")
		end,
	},
	-- Debugging
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("custom.configs.dap")
			require("dapui").setup()
		end,
	},
	{
		"leoluz/nvim-dap-go",
		ft = "go",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dap-go").setup()
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dap-python").setup()
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"folke/trouble.nvim",
			"folke/neodev.nvim",
		},
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "TroubleToggle",
		opts = {
			mode = "document_diagnostics",
		},
	},

	-- Git integration
	{
		"tpope/vim-fugitive",
		cmd = "Git",
	},
	{
		"sindrets/diffview.nvim",
		cmd = "DiffviewOpen",
	},
	{
		"rhysd/committia.vim",
		ft = "gitcommit",
	},

	-- Spruce up the quickfix list
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
	},
	{
		"yorickpeterse/nvim-pqf",
		ft = "qf",
		init = function()
			require("pqf").setup()
		end,
	},

	-- Enables :Telescope cder, which changes working directory
	{
		"zane-/cder.nvim",
		config = function()
			require("custom.configs.cder")
		end,
	},

	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},

	-- Copilot stuff
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("custom.configs.copilot")
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		lazy = false,
		config = function()
			require("copilot_cmp").setup()
		end,
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
