vim.pack.add({"https://github.com/RedsXDD/neopywal.nvim"})
require("neopywal").setup({

})
vim.cmd("colorscheme neopywal")

-- vim.pack.add({"https://github.com/maxmx03/fluoromachine.nvim"})
-- require("fluoromachine").setup({
--   theme = "retrowave",
--   transparent = true,
--   glow = false,
--   -- highlights = {
--   -- },
-- })
-- vim.cmd("colorscheme fluoromachine")

-- vim.pack.add({"https://github.com/scottmckendry/cyberdream.nvim"})
-- require("cyberdream").setup({
--   glow = true,
--   transparent = true,
-- })
-- vim.cmd("colorscheme cyberdream")

-- vim.pack.add({"https://github.com/folke/tokyonight.nvim"})
-- require("tokyonight").setup({
-- 	style = "night",
-- 	transparent = true,
-- })
-- vim.cmd("colorscheme tokyonight")

-- vim.pack.add({"https://github.com/navarasu/onedark.nvim"})
-- require('onedark').setup {
--     -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
--     style = 'darker', 
--     transparent = true,  -- Enable this for a transparent background
--     term_colors = true, -- Change terminal color as per the selected theme style
--     -- Optional: also make specific UI elements transparent
--     code_style = {
--         comments = 'italic',
--         keywords = 'none',
--         functions = 'none',
--         strings = 'none',
--         variables = 'none'
--     },
--     lualine = {
--         transparent = true, -- lualine center bar transparency
--     },
-- }
-- require('onedark').load()
