return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		event = "BufEnter",
		config = function()
			require("toggleterm").setup({
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					end
				end,
				open_mapping = { [[<c-t>]] },
				float_opts = {
					border = "rounded",
				},
				highlights = {
					FloatBorder = {
						link = "FloatBorder",
					},
				},
				direction = "horizontal",
				shell = "fish",
			})
		end,
		keys = {
			{ "<C-t>v", ":ToggleTerm direction=vertical<CR>", { noremap = true, silent = true } },
			{ "<C-t>h", ":ToggleTerm direction=horizontal<CR>", { noremap = true, silent = true } },
			{ "<C-t>f", ":ToggleTerm direction=float<CR>", { noremap = true, silent = true } },
		},
	},
}
