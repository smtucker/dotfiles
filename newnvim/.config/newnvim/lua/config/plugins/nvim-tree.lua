require('nvim-tree').setup()

vim.g.nvim_tree_quit_on_open = 0

local map = vim.keymap.set
map("n", "<leader>e", "<cmd> NvimTreeFocus <cr>", { desc = "Focus NvimTree", remap = true, silent = true })
map("n", "<C-n>", "<cmd> NvimTreeClose <cr>", { desc = "Focus NvimTree", remap = true, silent = true })

