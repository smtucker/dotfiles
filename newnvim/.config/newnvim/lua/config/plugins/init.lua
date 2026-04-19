vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",

  -- 'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',

  --- LSP ---
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvimtools/none-ls-extras.nvim',
  'https://github.com/nvimtools/none-ls.nvim',
  'https://github.com/folke/lazydev.nvim',

  --- UI ---
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/folke/which-key.nvim',
	"https://github.com/folke/noice.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/rcarriga/nvim-notify",
  "https://github.com/kevinhwang91/nvim-bqf",
  "https://github.com/yorickpeterse/nvim-pqf",
	"https://github.com/sindrets/diffview.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/romgrk/barbar.nvim',
  'https://github.com/nvim-tree/nvim-tree.lua',

  {
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("^1"),
	},

  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/hiphish/rainbow-delimiters.nvim",
  "https://github.com/gbprod/yanky.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/obsidian-nvim/obsidian.nvim",
  "https://github.com/seblj/roslyn.nvim",

  --- AI ---
  "https://github.com/Exafunction/windsurf.nvim",
  "https://github.com/olimorris/codecompanion.nvim",

  "https://codeberg.org/andyg/leap.nvim",
})

require('config.plugins.whichkey')

require("leap").add_default_mappings()
require('codeium').setup({
  enable_cmp_source = false,
})
require('lazydev').setup()
require('nvim-autopairs').setup()
require('rainbow-delimiters.setup').setup()
-- require('lualine').setup()
require('notify').setup()
require('config.plugins.noice')
require('config.plugins.lualine')
-- require('config.plugins.lualine')
require('config.plugins.nvim-tree')
require('config.plugins.barbar')
require('config.plugins.treesitter')
require('config.plugins.blink')
require('config.plugins.diffview')
require('config.plugins.yanky')
require('config.plugins.snacks')
require('config.plugins.null-ls')
require('config.plugins.render-markdown')

--- Plugins that get Lazy loaded
require('config.plugins.grugfar') -- Lazy in file
require('config.plugins.obsidian') -- Lazy lazy in file

vim.api.nvim_create_autocmd('BufReadPre', { once = true, callback = function()
  require('config.plugins.gitsigns')
end })

vim.schedule(function()
    require("pqf").setup()
    require("bqf").setup()
    require('config.plugins.codecompanion')
  end
)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cs",
  callback = function()
    require("roslyn").setup()
  end,
})
