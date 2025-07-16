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
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"clangd",
                    "ruff",
                    "black",
		            "rust_analyzer",
                    "denols"
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
			local on_attach = function(client, bufnr)
				-- Create your keybindings here...
			end
            local configs = require("lspconfig.configs")
			
            if not configs.zura_ls then
                configs.zura_ls = {
                    default_config = {
                        cmd = { "zura", "-lsp" },
                        filetypes = { "zura" }, 
                        root_dir = {".zura"} 
                    },
                }
            end

            lspconfig.zura_ls.setup({})
  

            -- lua
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			-- c++
			lspconfig.clangd.setup({
				capabilities = capabilities,
                on_attach = on_attach
			})
            -- rust 
            lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
                on_attach = on_attach,
                filetypes = {'rust'},
                cargo = {
                    allFeatures  = true,
                }
            })
            -- asm 
            
            --typescript
            lspconfig.denols.setup({
                capabilities = capabilities,
                on_attach = on_attach
            })
			--python
			lspconfig.pyright.setup({
				setting = {
                    python = {
                        pythonpath = "C:/Users/Dev/AppData/Local/Programs/Python/Python313/python.exe",
                        analysis = {
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            extraPaths = {"./src", "./lib"} 
                        }
                    }
                }, 
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
