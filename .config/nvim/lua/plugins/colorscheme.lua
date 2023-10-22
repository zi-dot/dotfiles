return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = function()
			return {
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				dim_inactive = {
					enabled = true,
					shade = "dark",
					percentage = 0.15,
				},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					telescope = true,
					treesitter = true,
					notify = true,
					barbar = true,
					mason = true,
				},
			}
		end,
		config = function()
			vim.cmd("colorscheme catppuccin")
		end,
	},
	{
		"projekt0n/caret.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
	},
}
