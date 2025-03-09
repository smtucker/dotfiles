---@module 'render-markdown'
---@type render.md.UserConfig
local opts = {
  heading = {
    enabled = false,
    render_modes = true,
    backgrounds = {
      "highlight_1",
      "highlight_2",
      "highlight_3",
      "highlight_4",
      "highlight_5",
      "highlight_6",
    },
  },
  bullet = {
    highlight = "highlight_4",
  },
  indent = {
    enabled = true,
  },
  checkbox = {
    custom = {
      important = { raw = "[!]", rendered = "󰄱 󰓎 ", highlight = "DiagnosticWarn" },
      delegated = { raw = "[~]", rendered = "󰄱 ~ ", highlight = "DiagnosticInfo" },
      delayed = { raw = "[>]", rendered = "󰄱 > ", highlight = "DiagnosticHint" },
    },
  },
}

return opts
