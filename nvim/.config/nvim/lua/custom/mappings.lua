---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<C-t>"] = {"<cmd> Telescope cder <CR>", "Telescope Change Directory"},
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

-- more keybinds!

return M
