local RetTable = {}

function RetTable.HighLight(FilePath)
	local CurentDir = vim.fn.system("cd")

	local PythonRunCmd = "python ZedLexer.py " .. FilePath

	vim.cmd("cd C:\\Users\\Dev\\AppData\\Local\\nvim\\lua\\Zed")
	vim.fn.system("cd C:\\Users\\Dev\\AppData\\Local\\nvim\\lua\\Zed")

	print(vim.fn.system("cd"))

	local Info = vim.fn.system("python ZedLexer.py " .. FilePath)

	vim.cmd("highlight ZedNumber guifg=#FAB387")
    vim.cmd("highlight ZedString guifg=#A6E3A1")
    vim.cmd("highlight ZedLet guifg=#F38BA8")
    vim.cmd("highlight ZedType guifg=#89DCEB")
    vim.cmd("highlight ZedVar guifg=#74C7EC")

	local bufnr = vim.api.nvim_get_current_buf()
	local ns_id = vim.api.nvim_create_namespace("MyHighlightNamespace")

	local file = io.open("ZedLight.txt", "r")
	if not file then
		print("could not find file")
	end
	local chunk = {}
	for line in file:lines() do
		table.insert(chunk, line)
		if #chunk == 4 then
			vim.api.nvim_buf_add_highlight(bufnr, ns_id, chunk[4], tonumber(chunk[1]), tonumber(chunk[2]), tonumber(chunk[3])) -- Line 1 is index 0 in Lua
			chunk = {}
		end
	end

	vim.cmd("cd " .. CurentDir)
	vim.fn.system("cd " .. CurentDir)

	print(Info)
	file:close()
end

function RetTable.CheckIfFile(filename)
	local File = io.open(filename)
	if File then
		File:close()
		return true
	else
		return false
	end
end

return RetTable
