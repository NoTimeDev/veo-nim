return {
    "vyfor/cord.nvim",
    config = function ()
        require("cord").setup({
            auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
            client_id           = "793271441293967371",  
       })
    end
}
