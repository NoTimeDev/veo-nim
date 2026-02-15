return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		require("lualine").setup()
		require("nvim-web-devicons").setup({
			color_icons = false,   -- disable colored icons so they inherit your theme
			default = true,  
		})
	end,
}
