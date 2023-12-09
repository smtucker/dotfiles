---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

M.telescope = {
  n ={
    ["<C-t>"] = {"<cmd> Telescope cder <CR>", "Telescope Change Directory"},
    ["<leader>fk"] = {"<cmd> Telescope keymaps <CR>", "Telescope keymaps"},
  },
}

M.diffview = {
  n = {
    ["<leader>gd"] = {"<cmd> DiffviewOpen <CR>", "Diffview Open"},
    ["<leader>gc"] = {"<cmd> DiffviewClose <CR>", "Diffview Close"},
    ["<leader>gh"] = {"<cmd> DiffviewFileHistory <CR>", "Diffview File History"},
    ["<leader>gb"] = {"<cmd> DiffviewToggleFiles <CR>", "Diffview Toggle Files"},
    ["<leader>gr"] = {"<cmd> DiffviewRefresh <CR>", "Diffview Refresh"},
  },
}
-- more keybinds!

return M
