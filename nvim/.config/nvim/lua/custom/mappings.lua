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

-- more keybinds!

return M
