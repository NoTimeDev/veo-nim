return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>nt", ":Neotree <CR>", {})
            require('neo-tree').setup({
            filesystem={
                follow_current_file = true,
                use_libuv_file_watcher = true,
                hijack_netrw_behaviour = "open_current",
                commands = {
                    delete = function(state)
	                    local inputs = require "neo-tree.ui.inputs"
	                    local path = state.tree:get_node().path
	                    local msg = "yuh sure yuh wah delete " .. path .. "?"
	                    inputs.confirm(msg, function(confirmed)
		                    if not confirmed then return end

		                    vim.fn.system { "trash", vim.fn.fnameescape(path) }
		                    require("neo-tree.sources.manager").refresh(state.name)
	                    end)
                    end,
                }
            }
        })
    end,
}
