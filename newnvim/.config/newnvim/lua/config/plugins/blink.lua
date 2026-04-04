require("blink.cmp").setup({
  appearance = {
    nerd_font_variant = "mono",
    use_nvim_cmp_as_default = true,
  },
  completion = {
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
  },
  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer", "codeium" },
    providers = {
      codeium = { name = 'Codeium', module = 'codeium.blink', async = true },
      lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink',
        score_offset = 100 },
    },
    per_filetype = {
      codecompanion = { "codecompanion" },
    },
  },
  cmdline = {
    keymap = { preset = 'inherit' },
    completion = { menu = { auto_show = true } },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
})
