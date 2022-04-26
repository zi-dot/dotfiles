vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use({ 'wbthomason/packer.nvim', opt = true })
    -- Hilights
    use({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('/pluginconfig/treesitter')
        end
    })

    -- pre dependency for many plugins
    use({ "nvim-lua/popup.nvim" })
    use({ 'nvim-lua/plenary.nvim' })

    -- telescope
    use({
        'nvim-telescope/telescope.nvim',
        config = function()
            require('/pluginconfig/telescope')
        end
    })

    -- lsp & navigator
    use({ 'neovim/nvim-lspconfig' })
    use({
        'williamboman/nvim-lsp-installer',
        config = function()
            require("/pluginconfig/nvim-lsp-installer")
        end
    })
    -- Auto Completion
    use({
        'windwp/nvim-autopairs', opt = true, event = "VimEnter",
        config = function()
            require('/pluginconfig/nvim-autopairs')
        end
    })
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            { "L3MON4D3/LuaSnip", opt = true, event = "VimEnter" },
        },
        after = { "lspkind-nvim", "LuaSnip", "nvim-autopairs" },
        config = function()
            require("/pluginconfig/nvim-cmp")
        end,
    })
    use({
        "onsails/lspkind-nvim",
        event = "VimEnter",
        config = function()
            require("/pluginconfig/lspkind-nvim")
        end,
    })
    use({
        "folke/lsp-colors.nvim",
        config = function()
            require("/pluginconfig/lsp-colors")
        end
    })


    use({ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-omni", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })
    use({ "zbirenbaum/copilot-cmp", after = { "nvim-cmp", "copilot.lua" } })
    use({ "hrsh7th/cmp-emoji", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-calc", after = "nvim-cmp" })
    use({ "f3fora/cmp-spell", after = "nvim-cmp" })
    use({ "yutkat/cmp-mocword", after = "nvim-cmp" })
    use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })
    use({ "ray-x/cmp-treesitter", after = "nvim-cmp" })

    use({ "github/copilot.vim", cmd = { "Copilot" } })
    use({
        "zbirenbaum/copilot.lua",
        after = "copilot.vim",
    })

    use {
        'tami5/lspsaga.nvim',
        config = function()
            require('/pluginconfig/lspsaga')
        end
    }

    use({
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            require('/pluginconfig/null-ls')
        end
    })

    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require('/pluginconfig/neo-tree')
        end
    })
end)
