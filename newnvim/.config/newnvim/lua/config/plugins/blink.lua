require("blink.cmp").setup({
  appearance = {
    nerd_font_variant = "mono",
    use_nvim_cmp_as_default = true,
  },
  keymap = {
    ['<CR>'] = { 'accept', 'fallback' },
  },
  completion = {
    list = {
      selection = { preselect = false, auto_insert = true },
    },
    ghost_text = {
      enabled = false,
    },
    menu = {
      auto_show = true,
      border = "rounded",
      -- winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
      -- winblend = 15,
    },
    documentation = {
      auto_show = true,
      window = {
        border = "rounded",
        -- winblend = 15
      },
    },
    accept = { auto_brackets = { enabled = true } },
  },
  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer", "codeium" },
    providers = {
      codeium = { name = "Codeium", module = "codeium.blink", async = true },
      lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
    },
    per_filetype = {
      codecompanion = { "codecompanion" },
    },
  },
  cmdline = {
    keymap = { preset = "inherit" },
    completion = {
      menu = { auto_show = true },
      list = {
        selection = { preselect = false, auto_insert = true },
      },
      ghost_text = {
        enabled = false,
      },
    },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
})
