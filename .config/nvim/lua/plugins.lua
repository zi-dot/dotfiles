vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function()
	use({ "wbthomason/packer.nvim", opt = true })
	-- Hilights
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("/pluginconfig/treesitter")
		end,
	})

	-- pre dependency for many plugins
	use({ "nvim-lua/popup.nvim" })
	use({ "nvim-lua/plenary.nvim" })

	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("/pluginconfig/telescope")
		end,
	})
	use({ "nvim-telescope/telescope-file-browser.nvim" })
	use("olacin/telescope-gitmoji.nvim")

	-- lsp & navigator
	use({
		"williamboman/mason-lspconfig.nvim",
	})
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("/pluginconfig/lspconfig")
		end,
	})
	use({
		"williamboman/mason.nvim",
		config = function()
			require("/pluginconfig/mason")
		end,
	})
	use({ "lukas-reineke/cmp-under-comparator", module = "cmp-under-comparator" })
	-- Auto Completion
	use({
		"windwp/nvim-autopairs",
		opt = true,
		event = "VimEnter",
		config = function()
			require("/pluginconfig/nvim-autopairs")
		end,
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
		end,
	})

	use({ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-omni", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-emoji", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-calc", after = "nvim-cmp" })
	use({ "f3fora/cmp-spell", after = "nvim-cmp" })
	use({ "yutkat/cmp-mocword", after = "nvim-cmp" })
	use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })

	use("github/copilot.vim")

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	-- treesitter
	use({ "ray-x/cmp-treesitter", after = "nvim-cmp" })
	use({ "nvim-treesitter/nvim-treesitter-textobjects", after = { "nvim-treesitter" } })
	use({ "RRethy/nvim-treesitter-textsubjects", after = { "nvim-treesitter" } })

	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			require("/pluginconfig/lspsaga")
		end,
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("/pluginconfig/null-ls")
		end,
	})

	use({ "rust-lang/rustfmt" })
	use({
		"rust-lang/rust.vim",
		config = function()
			vim.g.rustfmt_autosave = 1
		end,
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
			require("/pluginconfig/neo-tree")
		end,
	})

	-- buffer
	--use({ "akinsho/bufferline.nvim", tag = "*", requires = "kyazdani42/nvim-web-devicons" })

	-- Hilights
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	-- Scroll bar
	use({
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup()
		end,
	})

	-- Cursor
	use({
		"ggandor/lightspeed.nvim",
		config = function()
			require("/pluginconfig/lightspeed")
		end,
	})

	-- Text Editting
	use({ "machakann/vim-sandwich" })

	-- Indent
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("./pluginconfig/indent-blankline")
		end,
	})

	-- Git
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("/pluginconfig/gitsigns")
		end,
	})
	use({ "tpope/vim-fugitive" })
	use({
		"akinsho/git-conflict.nvim",
		config = function()
			require("git-conflict").setup()
		end,
	})

	-- JavaScript
	use({
		"vuki656/package-info.nvim",
		requires = "MunifTanjim/nui.nvim",
		config = function()
			require("/pluginconfig/package")
		end,
	})
	use({
		"windwp/nvim-ts-autotag",
		requires = { { "nvim-treesitter/nvim-treesitter", opt = true } },
		after = { "nvim-treesitter" },
		config = function()
			require("/pluginconfig/nvim-ts-autotag")
		end,
	})

	-- Terminal
	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("/pluginconfig/toggleterm")
		end,
	})

	-- Activity
	use({ "wakatime/vim-wakatime" })

	-- Diff
	use({
		"AndrewRadev/linediff.vim",
		cmd = { "Linediff" },
	})

	use({
		"romgrk/barbar.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("/pluginconfig/barbar")
		end,
	})

	-- notify
	-- use({ "rcarriga/nvim-notify" })

	-- line
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			require("/pluginconfig/catppuccin")
		end,
	})
	-- use({
	--   "folke/tokyonight.nvim",
	--   config = function()
	--     require("/pluginconfig/tokyonight")
	--   end,
	-- })

	-- use({
	-- 	"nvim-lualine/lualine.nvim",
	-- 	config = function()
	-- 		require("/pluginconfig/lualine")
	-- 	end,
	-- })
	-- use({
	-- 	"folke/which-key.nvim",
	-- 	config = function()
	-- 		require("which-key").setup({
	-- 			-- your configuration comes here
	-- 			-- or leave it empty to use the default settings
	-- 			-- refer to the configuration section below
	-- 		})
	-- 	end,
	-- })
	--
	-- silicon (screenshot)
	-- use("segeljakt/vim-silicon")
	use("rhysd/committia.vim")
	use({
		"matbme/JABS.nvim",
		config = function()
			require("/pluginconfig/jabs")
		end,
	})

	-- Japanese input
	use({ "vim-denops/denops.vim" })
	use({
		"vim-skk/skkeleton",
		config = function()
			require("/pluginconfig/skkeleton")
		end,
		requires = { "vim-denops/denops.vim" },
	})
end)
