-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable version
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after installation that may not be installed yet.
--  Please note that not all plugins that are installed are required to be explicitly listed below.
--
-- NOTE: This is where you merge your own plugins table.
--    Given the configuration below, you can add other plugins in this file.
--    For example:
--
--   local my_plugins = {
--     { "andweeb/presence.nvim" },
--     {
--       "ray-x/lsp_signature.nvim",
--       event = "BufRead",
--       config = function()
--         require("lsp_signature").setup()
--       end,
--     },
--   }
--
--   require("lazy").setup(my_plugins)
--
--   So, `my_plugins` will be merged with the plugins below.

local plugins = {
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' },
	},

	-- { "ellisonleao/gruvbox.nvim" },
	-- { 'folke/tokyonight.nvim' },
	{ 'rose-pine/neovim',        as = 'rose-pine' },

	{
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup {
				icons = false,
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	},

	{
		'nvim-treesitter/nvim-treesitter',
		build = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	},
	'nvim-treesitter/playground',
	"nvim-treesitter/nvim-treesitter-context",

	{
		'ThePrimeagen/harpoon',
		branch = 'harpoon2',
		dependencies = { 
			'nvim-lua/plenary.nvim',
		},
	},

	'mbbill/undotree',
	'tpope/vim-fugitive',
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		dependencies = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' }, -- Required

			{ 'williamboman/mason.nvim' }, -- Optional
			{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' }, -- Required
			{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
			{ 'hrsh7th/cmp-buffer' }, -- Optional
			{ 'hrsh7th/cmp-path' }, -- Optional
			{ 'hrsh7th/cmp-nvim-lua' }, -- Optional
			{ 'saadparwaiz1/cmp_luasnip' }, -- Optional

			-- Snippets
			{ 'L3MON4D3/LuaSnip' }, -- Required
			{ 'rafamadriz/friendly-snippets' }, -- Optional
		}
	},

	"folke/zen-mode.nvim",
	"github/copilot.vim",
	"eandrju/cellular-automaton.nvim",
	"laytan/cloak.nvim",

	{ "fatih/vim-go",            build = ':GoUpdateBinaries' },
	{ "akinsho/bufferline.nvim", version = '*',                  dependencies = 'nvim-tree/nvim-web-devicons' },
	"christoomey/vim-tmux-navigator",
	"tpope/vim-unimpaired",

	{
		'mikesmithgh/kitty-scrollback.nvim',
		enabled = false,
		cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
		event = { 'User KittyScrollbackLaunch' },
		-- tag = '*', -- latest stable version, may have breaking changes if major version changed
		-- tag = 'v5.0.0', -- pin specific tag
		config = function()
			require('kitty-scrollback').setup()
		end,
	},

	{
		'stevearc/oil.nvim',
		-- config is copied from: https://github.com/tjdevries/config.nvim/blob/e47e28da1da65f5aafbf8bd6431f628ad51d1f8f/lua/custom/plugins/oil.lua
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
	}
}

require("lazy").setup(plugins)
