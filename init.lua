vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.wo.number = true
vim.o.wrap = false
vim.o.updatetime = 1000

local ZedImport = require("Zed.Zed")

-- auto-save-made by a dumbass!
vim.api.nvim_create_autocmd("CursorHold", {
	pattern = "*",
	callback = function()
		local File = vim.fn.expand("%:p")
		print("CFile: ", File)
		if ZedImport.CheckIfFile(File) then
			vim.cmd("w!")
		end
	end,
})

--zed
vim.g.python3_host_prog = "C:\\Users\\Dev\\AppData\\Local\\Programs\\Python\\Python313\\python.exe"
vim.api.nvim_create_autocmd("CursorHold", {
	pattern = "*.z",
	callback = function()
		print("Called!")
		ZedImport.HighLight(vim.fn.expand("%:p"))
	end,
})
-----------------------------------------------------------
require(".config.lazy")
