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
				direction = "float",
				shell = "fish",
			})
		end,
	},
}
