vim.pack.add({
	"https://github.com/okuuva/auto-save.nvim",
	"https://github.com/slugbyte/lackluster.nvim",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/akinsho/bufferline.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/RaafatTurki/hex.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/nvim-neo-tree/neo-tree.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim", 
	"https://github.com/romus204/tree-sitter-manager.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/hrsh7th/cmp-cmdline",
	"https://github.com/j-hui/fidget.nvim",
	"https://github.com/folke/neodev.nvim",
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/saadparwaiz1/cmp_luasnip",
	"https://github.com/rafamadriz/friendly-snippets"
})
local path = vim.fn.stdpath("config") .. "/lua"
for _, file in ipairs(vim.fn.readdir(path)) do
	if file:match("%.lua$") and file ~= "Plug.lua" then
		local module = file:gsub("%.lua$", "")
		require(module)
	end
end
