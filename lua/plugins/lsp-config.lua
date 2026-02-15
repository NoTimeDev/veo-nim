return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = {},
	},

	{
		"folke/neodev.nvim",
		opts = {}
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"clangd",
					"gopls", 
					"jdtls"
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local util = require "lspconfig/util"
			local on_attach = function(client, bufnr)
				-- Create your keybindings here...
			end
			local configs = require("lspconfig.configs")
			
			lspconfig.gopls.setup({
				capabilities = capabilities,
                on_attach = on_attach,
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
						gofumpt = true,
					},
				},
			})

			lspconfig.jdtls.setup({
				on_attach = on_attach, 
				capabilities = capabilities
			})
            -- lua
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			  settings = {
			    Lua = {
			      diagnostics = {
			        globals = { "vim" },
			      },
			      hint = {
			        enable = true,
			      },
			      workspace = {
			        library = {
			          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
			          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
			          [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
			        },
			        maxPreload = 100000,
			        preloadFileSize = 10000,
			      },
			    },
			  },
			})

			-- c++
			lspconfig.clangd.setup({
				capabilities = capabilities,
                on_attach = on_attach
			})
            -- rust 
           -- asm
			--python
			 
			lspconfig.rust_analyzer.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = {"rust"},
				root_dir = util.root_pattern("Cargo.toml"),
				settings = {
					['rust-analyzer'] = {
						cargo = {
							allFeatures = true 
						}
					}
				}
			})
			lspconfig.pyright.setup({
				root_dir = function(fname)
				return lspconfig.util.root_pattern('pyrightconfig.json', 'pyproject.toml', '.git')(fname)
           or vim.fn.getcwd()
				end,
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "python" },
			})

			local open_floating_preview = vim.lsp.util.open_floating_preview
			function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
				opts = opts or {}
				opts.border = opts.border or "rounded" -- Set border to rounded
				return open_floating_preview(contents, syntax, opts, ...)
			end

			--all
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>df", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
