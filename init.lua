vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4 

vim.wo.number = true
vim.o.wrap = false
vim.o.updatetime = 1000
vim.cmd(":set nohlsearch")
vim.cmd(":set binary noeol")


-- Usage: call once (e.g. after colorscheme loads):
--local ogf = io.open("/home/devvy/Projects/tree-sitter-zura/queries/highlights.scm", "r")
--local content = ogf:read("*a")
--ogf:close() 

--local outf = io.open("/home/devvy/.config/nvim/queries/zura/highlights.scm", "w")
--outf:write(content)
--outf:close()
-----------------------------------------------------------
require(".config.lazy")
vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = "#6a788f", bg = nil, bold = true })
vim.api.nvim_set_hl(0, "NeoTreeGitUnstaged", { fg = "#6a788f", bg = nil, bold = true })
