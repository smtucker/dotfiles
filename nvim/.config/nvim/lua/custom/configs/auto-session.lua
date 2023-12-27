local api = require("nvim-tree.api")

local function close_nvim_tree()
  api.tree.close()
end

local function open_nvim_tree()
	api.tree.open()
end

require("auto-session").setup {
  log_level = "error",
  pre_save_cmds = {close_nvim_tree},
  post_save_cmds = {open_nvim_tree},
  post_open_cmds = {open_nvim_tree},
  post_restore_cmds = {open_nvim_tree},
  cwd_change_handling = {
    restore_upcoming_session = true, -- <-- THE DOCS LIE!! This is necessary!!
  },
}

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
