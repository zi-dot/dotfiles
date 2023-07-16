return {
	{
		"akinsho/toggleterm.nvim",
		opts = {
			open_mapping = [[<c-z>]],
			hide_numbers = true, -- hide the number column in toggleterm buffers
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
			start_in_insert = false,
			insert_mappings = true, -- whether or not the open mapping applies in insert mode
			persist_size = false,
			direction = "float",
			close_on_exit = false, -- close the terminal window when the process exits
			shell = vim.o.shell, -- change the default shell
			float_opts = {
				border = "curved",
				width = math.floor(vim.o.columns * 0.9),
				height = math.floor(vim.o.lines * 0.9),
				winblend = 3,
				highlights = { border = "ColorColumn", background = "ColorColumn" },
			},
		},
	},
}
