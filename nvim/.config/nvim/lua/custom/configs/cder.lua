require("telescope").load_extension('cder')
require("telescope").setup({
  extensions = {
    cder = {
      previewer_command = "exa -a -T --level=3 --git --git-ignore" ..
        " --long --no-permissions --no-user --color=always --icons" ..
        " --no-filesize --ignore-glob=.git",
      pager_command = "bat --pager=never --style=plain --color=always",
      entry_maker = function(line)
        return {
          value = line,
          display = function(entry)
            return ' ' .. line:gsub(os.getenv('HOME') .. '/', ''),
              { { { 1, 3 }, 'Directory' } }
          end,
          ordinal = line,
        }
      end,
    },
  },
})


