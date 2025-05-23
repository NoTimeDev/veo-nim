vim.opt.tabstop = 4 
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.wo.number = true
vim.o.wrap = false
vim.o.updatetime = 1000

local input_file = io.open("/home/devvy/Projects/tree-sitter-zed/queries/highlights.scm", "r")

local content = input_file:read("*all")
input_file:close()

-- Open 'lol.txt' in write mode (this will overwrite the file if it exists)
local output_file = io.open("/home/devvy/.config/nvim/queries/zed/highlights.scm", "w")

-- Write the content to 'lol.txt'
output_file:write(content)
output_file:close()

vim.filetype.add({
  extension = {
    zed = "zed",
    z = "zed",
  }
})
--vim.filetype.add({
  --  extension = {
    --    Z = "zlang"
    --}
--})

vim.cmd(":set hlsearch!")
-- auto-save-made by a dumbass!
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    pattern = "*",
    callback = function()

        local File = vim.fn.expand("%:p")
        --print("CFile: ", File)
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname ~= "" and vim.fn.filereadable(bufname) == 1 then
            if vim.fn.expand("%:e") ~= "json" then
                vim.cmd("w!")
            end
        end
    end,
})

--zed
--"TextChangedI", "TextChanged", "CursorHold", "CursorHoldI"-vim.g.python3_host_prog = "C:\\Users\\Dev\\AppData\\Local\\Programs\\Python\\Python313\\python.exe"
vim.api.nvim_create_user_command('Ctlin', function()
    local cwd = vim.fn.getcwd()
    os.execute("ln -sf .clangd.linux " .. cwd .. "/.clangd")
    vim.cmd("LspRestart")
end, {})

vim.api.nvim_create_user_command('Ctwin', function()
    local cwd = vim.fn.getcwd()
    os.execute("ln -sf .clangd.windows " .. cwd .. "/.clangd")
    vim.cmd("LspRestart")
end, {})
----------------------------------------------------------
require(".config.lazy")
