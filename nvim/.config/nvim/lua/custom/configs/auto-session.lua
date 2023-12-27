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
  session_lens = {
    -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
    buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
    load_on_setup = true,
    theme_conf = { border = true },
    previewer = false,
  },
}

require("telescope").load_extension("session-lens")

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
