return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"wadackel/vim-dogrun",
		lazy = true,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		config = function()
			require("kanagawa").setup({
				transparent = false,
				theme = "wave", -- wave, dragon, lotus
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = true,
		config = function()
			require("rose-pine").setup({
				variant = "main", -- main, moon, dawn
			})
		end,
	},
	-- 切り替え方法:
	-- catppuccin: :colorscheme catppuccin
	-- dogrun: :colorscheme dogrun
	-- kanagawa: :colorscheme kanagawa
	-- rose-pine: :colorscheme rose-pine
}
