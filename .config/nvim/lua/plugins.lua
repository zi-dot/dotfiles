local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
	-- notify
	{
		"rcarriga/nvim-notify",
		config = function()
			require("pluginconfig/notify")
		end,
	},

	-- Hilights
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("pluginconfig/treesitter")
		end,
	},
	{
		"nvim-treesitter/playground",
	},
	"nvim-treesitter/nvim-treesitter-context",
	-- pre dependency for many plugins
	{ "nvim-lua/popup.nvim" },
	{ "nvim-lua/plenary.nvim" },

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("pluginconfig/telescope")
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		cond = vim.fn.executable("make") == 1,
	},
	{ "nvim-telescope/telescope-file-browser.nvim" },
	"olacin/telescope-gitmoji.nvim",
	-- lsp & navigator
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			"j-hui/fidget.nvim",
		},
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("pluginconfig/mason")
		end,
	},
	{ "lukas-reineke/cmp-under-comparator",        module = "cmp-under-comparator" },
	-- Auto Completion
	{
		"windwp/nvim-autopairs",
		lazy = true,
		event = "VimEnter",
		config = function()
			require("pluginconfig/nvim-autopairs")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "L3MON4D3/LuaSnip", lazy = true, event = "VimEnter" },
			"lspkind-nvim",
			"LuaSnip",
			"nvim-autopairs",
		},
		config = function()
			require("pluginconfig/nvim-cmp")
		end,
	},
	{
		"onsails/lspkind-nvim",
		event = "VimEnter",
		config = function()
			require("pluginconfig/lspkind-nvim")
		end,
	},
	{
		"folke/lsp-colors.nvim",
		config = function()
			require("pluginconfig/lsp-colors")
		end,
	},

	{ "hrsh7th/cmp-nvim-lsp-signature-help",  dependencies = { "nvim-cmp" } },
	{ "hrsh7th/cmp-nvim-lsp-document-symbol", dependencies = { "nvim-cmp" } },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer",                   dependencies = { "nvim-cmp" } },
	{ "hrsh7th/cmp-path",                     dependencies = { "nvim-cmp" } },
	{ "hrsh7th/cmp-omni",                     dependencies = { "nvim-cmp" } },
	{ "hrsh7th/cmp-nvim-lua",                 dependencies = { "nvim-cmp" } },
	{ "hrsh7th/cmp-cmdline",                  dependencies = { "nvim-cmp" } },
	{ "hrsh7th/cmp-emoji",                    dependencies = { "nvim-cmp" } },
	{ "hrsh7th/cmp-calc",                     dependencies = { "nvim-cmp" } },
	{ "f3fora/cmp-spell",                     dependencies = { "nvim-cmp" } },
	{ "yutkat/cmp-mocword",                   dependencies = { "nvim-cmp" } },
	{ "saadparwaiz1/cmp_luasnip",             dependencies = { "nvim-cmp" } },

	"github/copilot.vim",
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	-- treesitter
	-- { "ray-x/cmp-treesitter", dependencies = { "nvim-cmp" } },
	{ "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter" } },
	{ "RRethy/nvim-treesitter-textsubjects",         dependencies = { "nvim-treesitter" } },
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	{
		"glepnir/lspsaga.nvim",
		event = "BufRead",
		branch = "main",
		config = function()
			require("pluginconfig/lspsaga")
		end,
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("pluginconfig/null-ls")
		end,
	},

	{
		"rust-lang/rust.vim",
		config = function()
			vim.g.rustfmt_autosave = 1
		end,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("pluginconfig/neo-tree")
		end,
	},

	-- Hilights
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	-- Scroll bar
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup()
		end,
	},

	-- Cursor
	{
		"ggandor/lightspeed.nvim",
		config = function()
			require("pluginconfig/lightspeed")
		end,
	},

	-- Text Editting
	{ "machakann/vim-sandwich" },

	-- Indent
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("pluginconfig/indent-blankline")
		end,
	},

	-- Git
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("pluginconfig/gitsigns")
		end,
	},
	{ "tpope/vim-fugitive" },
	{
		"akinsho/git-conflict.nvim",
		config = function()
			require("git-conflict").setup()
		end,
	},

	-- JavaScript
	{
		"vuki656/package-info.nvim",
		dependencies = "MunifTanjim/nui.nvim",
		config = function()
			require("pluginconfig/package")
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = { { "nvim-treesitter/nvim-treesitter", lazy = true } },
		config = function()
			require("pluginconfig/nvim-ts-autotag")
		end,
	},

	-- Terminal
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("pluginconfig/toggleterm")
		end,
	},

	-- Activity
	{ "wakatime/vim-wakatime" },

	-- Diff
	{
		"AndrewRadev/linediff.vim",
		cmd = { "Linediff" },
	},

	{
		"romgrk/barbar.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("pluginconfig/barbar")
		end,
	},

	-- line
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("pluginconfig/catppuccin")
		end,
	},

	-- silicon (screenshot)
	{ "krivahtoo/silicon.nvim", build = "./install.sh" },
	"rhysd/committia.vim",

	-- Japanese input
	{ "vim-denops/denops.vim" },
	{
		"vim-skk/skkeleton",
		config = function()
			require("pluginconfig/skkeleton")
		end,
		dependencies = { "vim-denops/denops.vim" },
	},

	{
		"feline-nvim/feline.nvim",
		config = function()
			require("pluginconfig/feline")
		end,
	},
})
