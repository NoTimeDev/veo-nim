return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",

        config = function()
            require('nvim-treesitter.parsers').get_parser_configs().zed = {
            install_info = {
                url = "/home/devvy/Projects/tree-sitter-zed",
                files = { "src/parser.c" },
                generate_requires_npm = true,
                requires_generate_from_grammar = true,
            },
            filetype = "zed",
            }
            vim.treesitter.language.register('zed', 'zed')  -- the someft filetype will use the python parser and queries.
            local config = require("nvim-treesitter.configs")
            config.setup({
                ensure_installed = {
                    "lua",
                    "python",
                    "cpp",
                    "asm",
                    "c",
                    "json",
                    "rust",
                    "typescript",
                    "javascript"
                },
                highlight = { enable = true,

                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },
            })
        end
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            require("mason-tool-installer").setup({
                'black',
                'debugpy',
                'flake8',
                'isort',
                'ruff',
                'mypy',
                'pylint'
            })
        end
    },
    {
        'nvim-treesitter/playground' 
    }
}
