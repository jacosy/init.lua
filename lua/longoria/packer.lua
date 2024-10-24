-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- use { "ellisonleao/gruvbox.nvim" }
    -- use 'folke/tokyonight.nvim'
    use({ 'rose-pine/neovim', as = 'rose-pine' })

    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    })

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use('nvim-treesitter/playground')
    use("nvim-treesitter/nvim-treesitter-context")
    use('ThePrimeagen/harpoon')
    use("ThePrimeagen/refactoring.nvim")
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required

            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },         -- Required
            { 'hrsh7th/cmp-nvim-lsp' },     -- Required
            { 'hrsh7th/cmp-buffer' },       -- Optional
            { 'hrsh7th/cmp-path' },         -- Optional
            { 'hrsh7th/cmp-nvim-lua' },     -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' },             -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    }

    use("folke/zen-mode.nvim")
    use("github/copilot.vim")
    use("eandrju/cellular-automaton.nvim")
    use("laytan/cloak.nvim")

    use("fatih/vim-go", { run = ':GoUpdateBinaries' })
    use("akinsho/bufferline.nvim", { tag = '*', requires = 'nvim-tree/nvim-web-devicons' })
    use("christoomey/vim-tmux-navigator")
    use("tpope/vim-unimpaired")

    use({
        "olimorris/codecompanion.nvim",
        config = function()
            require("codecompanion").setup({
                adapters = {
                    copilot = function()
                        return require("codecompanion.adapters").extend("copilot", {
                            env = {
                                api_key = "GITHUB_TOKEN"
                            },
                        })
                    end,
                },
                strategies = {
                    chat = {
                        adapter = "copilot",
                    },
                    inline = {
                        adapter = "copilot",
                    },
                    agent = {
                        adapter = "copilot",
                    },
                },
            })
        end,
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "hrsh7th/nvim-cmp",              -- Optional: For using slash commands and variables in the chat buffer
            "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
            "stevearc/dressing.nvim"         -- Optional: Improves `vim.ui.select`
        }
    })

    use({
        'mikesmithgh/kitty-scrollback.nvim',
        disable = false,
        opt = true,
        cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
        event = { 'User KittyScrollbackLaunch' },
        -- tag = '*', -- latest stable version, may have breaking changes if major version changed
        -- tag = 'v5.0.0', -- pin specific tag
        config = function()
            require('kitty-scrollback').setup()
        end,
    })

    use({
        'stevearc/oil.nvim',
        config = function()
            CustomOilBar = function()
                local path = vim.fn.expand "%"
                path = path:gsub("oil://", "")

                return "  " .. vim.fn.fnamemodify(path, ":.")
            end

            require("oil").setup {
                columns = { "icon" },
                keymaps = {
                    ["<C-h>"] = false,
                    ["<C-l>"] = false,
                    ["<C-k>"] = false,
                    ["<C-j>"] = false,
                    ["<C-p>"] = false,
                    ["<M-h>"] = "actions.select_split",
                },
                win_options = {
                    winbar = "%{v:lua.CustomOilBar()}",
                },
                view_options = {
                    show_hidden = true,
                },
            }

            -- Open parent directory in current window
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

            -- Open parent directory in floating window
            vim.keymap.set("n", "<space>-", require("oil").toggle_float)
        end,
    })
end)
