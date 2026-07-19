vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4


vim.wo.number = true
vim.o.wrap = false
vim.o.updatetime = 1000
vim.cmd(":set nohlsearch")
vim.cmd(":set binary noeol")
vim.o.autoindent = true
vim.o.cindent = true
vim.o.smartindent = true

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("Plug")

vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = "#6a788f", bg = nil, bold = true })
vim.api.nvim_set_hl(0, "NeoTreeGitUnstaged", { fg = "#6a788f", bg = nil, bold = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "haskell",
  callback = function()
    local o = vim.opt_local
    o.expandtab = true
    o.shiftwidth = 2
    o.tabstop = 2
  end,
})
