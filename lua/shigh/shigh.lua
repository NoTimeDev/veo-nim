local M = {}
local job = nil  -- handle to the running process

local function highlight_from_output()
    local bufnr = vim.api.nvim_get_current_buf()
    local ns_id = vim.api.nvim_create_namespace("SHighLight")
    vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

    local file = io.open("/home/devvy/.config/nvim/lua/shigh/Shigh.txt", "r")
    if not file then return end

    local chunk = {}
    for line in file:lines() do
        table.insert(chunk, line)
        if #chunk == 4 then
            vim.api.nvim_buf_add_highlight(bufnr, ns_id, chunk[4], tonumber(chunk[1]), tonumber(chunk[2]), tonumber(chunk[3]))
            chunk = {}
        end
    end
    file:close()
end

function M.writetemp()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local file = io.open("/home/devvy/.config/nvim/lua/shigh/Shightemp.txt", "w")
    for _, line in ipairs(lines) do
        file:write(line .. "\n")
    end
    file:close()
end

function M.start_High()
    M.writetemp()

    -- cancel previous job if still running
    if job then
        job:kill("sigterm")
        job = nil
    end

    job = vim.system({
        "pypy3",
        "/home/devvy/.config/nvim/lua/shigh/Shigh.py",
        "/home/devvy/.config/nvim/lua/shigh/Shightemp.txt"
    }, {
        stdout = false,
        stderr = false,
    }, function()
        vim.schedule(function()
            highlight_from_output()
        end)
    end)
end

return M

