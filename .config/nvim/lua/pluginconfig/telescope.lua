vim.api.nvim_set_keymap("n", "<Leader>g", "<Cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>f", "<Cmd>Telescope find_files<CR>", { noremap = true, silent = true })

local telescope = require("telescope")

telescope.setup({
	defaults = {
		file_ignore_patterns = { ".git/", "node_modules/", "target/" },
		initial_mode = "normal",
		hidden = true,
	},
	pickers = {
		find_files = {
			hidden = true,
		},
	},
	extensions = {
		file_browser = {},
	},
})

require("telescope").load_extension("file_browser")
