local IS_SETUP = false

local function setup()
  require("obsidian").setup({
    legacy_commands = false,
    ui = { enable = false },
    workspaces = {
      {
        name = "general",
        path = "~/notes",
      },
    },
    daily_notes = {
      folder = "journal",
      -- template = "daily.md",
    },
    completion = {
      nvim_cmp = false,
      blink = true,
    },
    templates = {
      subdir = "templates",
    },
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,

    -- Optional, alternatively you can customize the frontmatter data.
    ---@return table
    frontmatter_func = function(note)
      -- Add the title of the note as an alias.
      -- if note.title then
      --   note:add_alias(note.title)
      -- end

      local out = { id = note.id, title = note.title, aliases = note.aliases,
        tags = note.tags }

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,
  })
end

setup()

local map = vim.keymap.set

map("n", "<leader>fN", "<cmd> Obsidian search <CR>", { desc = "ObsidianSearch" })
map("n", "<leader>oc", "<cmd> Obsidian ToggleCheckbox <CR>", { desc = "ObsidianToggleCheckbox" })
map("n", "<leader>ob", "<cmd> Obsidian backlinks <CR>", { desc = "ObsidianBacklinks" })
map("n", "<leader>oo", ":Obsidian open ", { desc = "ObsidianOpen", silent = false })
map({"n","v"}, "<leader>ol", "<cmd> Obsidian link <CR>", { desc = "ObsidianLink" })
map("n", "<leader>on", ":Obsidian new ", { desc = "ObsidianNew", silent = false })
map("n", "<leader>ot", "<cmd> Obsidian tags <cr>", { desc = "ObsidianTags" })
map({"n", "v"}, "<leader>ox", ":Obsidian extract_note ", { desc = "ObsidianExtractNote", silent = false })
