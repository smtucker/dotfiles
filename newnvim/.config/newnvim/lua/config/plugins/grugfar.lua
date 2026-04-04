local setup_grug_far = function()
  vim.pack.add({'https://github.com/MagicDuck/grug-far.nvim'})
  require("grug-far").setup({
    headerMaxWidth = 80,
  })
end

vim.keymap.set({ "n", "v", "x" }, "<leader>sr",
  function()
    setup_grug_far()
    local grug = require("grug-far")
    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
    grug.open({
      transient = true,
      prefills = {
        filesFilter = ext and ext ~= "" and "*." .. ext or nil,
      },
    })
  end,
  { desc = "Search and Replace" }
)
