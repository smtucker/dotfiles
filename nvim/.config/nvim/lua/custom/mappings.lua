---@type MappingsTable
local M = {}

M.disabled = {
  
  n = {
    ["<leader>D"] = "",
    ["<leader>td"] = "", -- Gitsigns toggle delete
    ["<leader>rh"] = "", -- Gitsigns reset hunk
    ["<leader>ph"] = "", -- Gitsigns preview hunk
    ["<leader>h"] = "", -- Horizontal term
    ["<leader>v"] = "", -- Vertical term
    ["<leader>cm"] = "", -- Git commits telescope
    ["<leader>gt"] = "", -- Git status diff telescope
    ["<leader>pt"] = "", -- Pick hidden term
    ["<leader>th"] = "", -- Pich theme
    ["<leader>ma"] = "", -- Telescope marks
    ["<leader>n"] = "", -- Toggle line numbers (Why ever turn that off?)
  }
}

M.neorg = {
  n = {
    ["<leader>njt"] = {"<cmd> Neorg journal today <Cr>", "Today's journal"},
    ["<leader>njy"] = {"<cmd> Neorg journal yesterday <Cr>", "Yesterday's journal"},
    ["<leader>njT"] = {"<cmd> Neorg journal yesterday <Cr>", "Tomorrow's journal"},
    ["<leader>ni"] = {"<cmd> Neorg index <CR>", "Neorg index"},
    ["<leader>nr"] = {require("custom.functions").neorg_return, "Neorg return"},
    ["<leader>nc"] = {"<cmd> Neorg toggle-concealer <CR>", "Neorg toggle concealer"},
    ["[h"] = {"<cmd> Neorg keybind norg core.integrations.treesitter.previous.heading <CR>", "Next norg heading"},
    ["]h"] = {"<cmd> Neorg keybind norg core.integrations.treesitter.next.heading <CR>", "Previous norg heading"},
  }
}

M.obsidian = {
  n = {
    ["<leader>fo"] = {"<cmd> ObsidianSearch <CR>", "ObsidianSearch"},
    ["<leader>oc"] = {"<cmd> ObsidianToggleCheckbox <CR>", "ObsidianToggleCheckbox"},
    ["<leader>ob"] = {"<cmd> ObsidianBacklinks <CR>", "ObsidianBacklinks"},
    ["<leader>oo"] = {":ObsidianOpen ", "ObsidianOpen", silent = false},
    ["<leader>ol"] = {"<cmd> ObsidianLink <CR>", "ObsidianLink"},
    ["<leader>on"] = {":ObsidianNew ", "ObsidianNew", silent = false},
    ["<leader>ot"] = {"<cmd> ObsidianTags <cr>", "ObsidianTags"},
    ["<leader>ox"] = {":ObsidianExtractNote ", "ObsidianExtractNote", silent = false},
  }
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>lF"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },

    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "Diagnostic setloclist",
    },

    ["<leader>lq"] = {"<cmd> TroubleToggle <CR>", "TroubleToggle"},
    ["<leader>B"] = {"<cmd> JABSOpen <CR>", "Switch buffers"},
    ["<leader>lf"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    },
    ["<leader>vt"] = { function() require("base46").toggle_transparency() end, "Toggle Transparency" },
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

local ipopts = { noremap = true, silent = true }

M.iconpicker = {
  n = {
    ["<leader>ii"] = {"<cmd> IconPickerNormal <CR>", "IconPickerNormal", opts = ipopts},
    ["<leader>iy"] = {"<cmd> IconPickerYank <CR>", "IconPickerYank", opts = ipopts},
  },
  i = {
    ["<C-i>"] = {"<cmd> IconPickerNormal <CR>", "IconPickerNormal", opts = ipopts},
  }
}

M.telescope = {
  n ={
    ["<C-t>"] = {"<cmd> Telescope cder <CR>", "Telescope Change Directory"},
    ["<leader>gc"] = {"<cmd> Telescope git_bcommits <CR>", "Telescope BCommits"},
    ["<leader>gC"] = {"<cmd> Telescope git_commits <CR>", "Telescope Commits"},
    ["<leader>gb"] = {"<cmd> Telescope git_branches <CR>", "Telescope Branches"},
    ["<leader>fk"] = {"<cmd> Telescope keymaps <CR>", "Telescope keymaps"},
    ["<leader>ft"] = {"<cmd> Telescope <CR>", "Telescope builtins"},
    ["<leader>fm"] = {"<cmd> Telescope marks <CR>", "Telescope marks"},
    ["<leader>fT"] = {"<cmd> Telescope themes <CR>", "Telescope Themes"},
    ["<leader>fs"] = {"<cmd> Telescope session-lens <CR>", "Session select"},
    ["<leader>fn"] = {"<cmd> Telescope find_files search_dirs=~/notes <CR>", "Telescope notes"},
  },
}

M.diffview = {
  n = {
    ["<leader>gd"] = {
      function()
        if next(require('diffview.lib').views) == nil then
          vim.cmd('DiffviewOpen')
        else
          vim.cmd('DiffviewClose')
        end
      end, "Diffview"},
    ["<leader>gh"] = {"<cmd> DiffviewFileHistory <CR>", "Diffview File Hisory"},
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

M.gitsigns = {
  n = {
    ["<leader>gr"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },
    ["<leader>gp"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },
    ["<leader>gs"] = {
      function()
      require("gitsigns").stage_hunk()
      end,
      "Stage hunk",
    },
    ["<leader>gu"] = {
      function()
      require("gitsigns").undo_stage_hunk()
      end,
      "Undo stage hunk",
    },
    ["<leader>gt"] = {
      function()
      require("gitsigns").toggle_current_line_blame()
      end,
      "Toggle current line blame",
    },
    ["<leader>gl"] = {
      function()
      require("gitsigns").blame_line()
      end,
      "Blame line",
    },
    ["<leader>gq"] = {
      function()
      require("gitsigns").setqflist()
      end,
      "Hunks to quickfix",
    },
  },
}

M.lspconfig = {
  n = {
    ["<leader>lD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },

    ["<leader>ld"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "LSP definition",
    },

    ["<leader>lH"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },

    ["<leader>li"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "LSP implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },

    ["<leader>lt"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "LSP definition type",
    },

    ["<leader>lR"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "LSP rename",
    },

    ["<leader>la"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },

    ["<leader>lr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "LSP references",
    },

  },
  v = {
    ["<leader>cl"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },
  },
}
-- more keybinds!

return M
