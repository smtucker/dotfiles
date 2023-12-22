local M = {
	neorg_return = function()
		local tree_open = require("nvim-tree.view").is_visible()
		if tree_open then
			require("nvim-tree.api").tree.close()
		end
		vim.cmd("Neorg return")
		if tree_open then
			require("nvim-tree.api").tree.open()
		end
	end,
}

return M
