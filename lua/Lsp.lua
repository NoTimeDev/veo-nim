local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config('rust_analyzer', {
	capabilities = capabilities,
	filetypes = {"rust"},
	root_dir = u,
	settings = {
		['rust-analyzer'] = {
			cargo = {
				allFeatures = true
			}
		},
	},
})

vim.lsp.config('pyright', {
	filetypes = {"python"},
	capabilities = 	capabilities
})

vim.lsp.config("kotlin-lsp", {
	capabilities = capabilities,
})

vim.lsp.config("clangd", {
	capabilities = capabilities,
})
vim.lsp.config('lua_ls', {
  ---@type lspconfig.settings.lua_ls
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        preloadFileSize = 10000,
        library = {
          vim.env.VIMRUNTIME,
        }
      },
    },
  },
})


vim.lsp.enable('pyright')
vim.lsp.enable('kotlin-lsp')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('clangd')
vim.lsp.enable('lua_ls')


local open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "rounded" -- Set border to rounded
	return open_floating_preview(contents, syntax, opts, ...)
end

