require("codecompanion").setup({
  interactions = {
    chat = {
      adapter = "gemini",
      model = "gemini-2.5-pro",
    },
    inline = {
      adapter = "gemini",
      model = "gemini-2.5-pro",
    },
  },
  -- display = {
  --   diff = {
  --     enabled = true,
  --     -- provider = "mini_diff",
  --   },
  -- },
  acp = {
    gemini_cli = function()
      return require("codecompanion.acp").extend("gemini-cli", {
        commands = {
          flash = {
            "gemini",
            "--experimental-acp",
            "-m",
            "gemini-2.5-flash",
          },
          pro = {
            "gemini",
            "--experimental-acp",
            "-m",
            "gemini-2.5-pro",
          },
        },
        defaults = {
          -- auth_method = "gemini-api-key", -- "oauth-personal" | "gemini-api-key" | "vertex-ai"
          -- auth_method = "oauth-personal",
          auth_method = "oauth-personal",
        },
      })
    end,
  }
})
