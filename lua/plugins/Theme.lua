-- In your lazy.nvim plugin setup file (e.g., lua/plugins/colorscheme.lua):
return {
	"catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            transparent_background = true, -- Enable transparency
            integrations = {
                neotree = true, -- Enable Neo-tree integration
                telescope = true,
                cmp = true,
                lsp_saga = true,
            	bufferline = true
			},
        }) 
		vim.cmd.colorscheme "catppuccin"
    end,
    custom_highlights = function(colors)
        return {
            type = { fg = colors.green },
        }
    end


}

