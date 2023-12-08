local copilot = require "copilot"

copilot.setup {
  suggestion = { enabled = false },
  panel = { enabled = false },
  filetypes = {
    go = true,
    python = true,
    lua = true,
  },
}
