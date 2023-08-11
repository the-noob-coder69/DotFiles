local config = function(s)
     return require('config.' .. s)
end

return {
    {
        'numToStr/Comment.nvim',
        event = 'VeryLazy',
        config = true,
    },
    {
        'cshuaimin/ssr.nvim',
        event = 'UIEnter',
        config = function()
            require('ssr').setup {
                border = "rounded",
                min_width = 50,
                min_height = 5,
                max_width = 120,
                max_height = 25,
                --[[ keymaps = {
                    close = "q",
                    next_match = "n",
                    prev_match = "N",
                    replace_confirm = "<cr>",
                    replace_all = "<leader><cr>",
                }, ]]
            }
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter'
        },
    },
--[[
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        config = function()
            config('lsp-zero')
        end,
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    },
]]
    {
        'neovim/nvim-lspconfig',
        event = 'BufEnter',
        config = function()
            config('nvim-lspconfig')
        end,
        dependencies = {
            {
                'folke/neodev.nvim',
                config = true,
            },
        },
    },
    --[[ {
        'williamboman/mason.nvim',
        config = true,
    },
    {
        'williamboman/mason-lspconfig.nvim',
    }, ]]
    {
        'hrsh7th/nvim-cmp',
        -- load cmp on InsertEnter
        event = 'InsertEnter',
        -- these dependencies will only be loaded when cmp loads
        -- dependencies are always lazy-loaded unless specified otherwise
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            -- 'hrsh7th/cmp-nvim-lsp-signature-help',
        },
        config = function()
            config('nvim-cmp')
        end,
    },
    {
        'L3MON4D3/LuaSnip',
        event = 'VeryLazy',
        -- follow latest release.
        version = '1.*',
        -- install jsregexp (optional!).
        build = 'make install_jsregexp',
        dependencies = {
            'rafamadriz/friendly-snippets',
        }
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            config('autopairs')
        end
    },
    {
        'onsails/diaglist.nvim',
        event = 'BufEnter'
    },
    {
        'nvim-treesitter/nvim-treesitter',
        ft = { 'bash', 'c', 'cpp', 'comment', 'diff', 'git_rebase', 'gitconfig', 'java', 'json', 'lua', 'nix', 'python', 'regex' },
        build = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
        config = function ()
            config('treesitter')
        end
    }
}
