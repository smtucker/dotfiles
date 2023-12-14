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

M.dap = {
  n = {
    ["<leader>dc"] = {"<cmd> lua require('dap').continue()<CR>", "DAP Continue"},
    ["<leader>dx"] = {"<cmd> lua require('dap').terminate()<CR>", "DAP Terminate"},
    ["<leader>dr"] = {"<cmd> lua require('dap').repl.open()<CR>", "DAP REPL"},
    ["<leader>db"] = {"<cmd> lua require('dap').toggle_breakpoint()<CR>", "DAP Toggle Breakpoint"},
    ["<leader>dl"] = {"<cmd> lua require('dap').list_breakpoints()<CR>", "DAP List Break Points"},
    ["<leader>ds"] = {"<cmd> lua require('dap').step_over()<CR>", "DAP Step Over"},
    ["<leader>di"] = {"<cmd> lua require('dap').step_into()<CR>", "DAP Step Into"},
    ["<leader>do"] = {"<cmd> lua require('dap').step_out()<CR>", "DAP Step Out"},
    ["<leader>du"] = {"<cmd> lua require('dapui').toggle()<CR>", "DAP Toggle UI"},
    ["<leader>dp"] = {"<cmd> lua require('dapui').float_element()<CR>", "DAP Float Element"},
  },
}

-- more keybinds!

return M
