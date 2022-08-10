local telescope = require("telescope")
local fb_actions = require("telescope").extensions.file_browser.actions

telescope.setup({
	defaults = {
		file_ignore_patterns = { ".git/", "node_modules/", "target/" },
		initial_mode = "insert",
		hidden = true,
	},
	pickers = {
		find_files = {
			hidden = true,
		},
	},
	extensions = {
		file_browser = {
			theme = "dropdown",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				["n"] = {
					-- your custom normal mode mappings
					["l"] = fb_actions.open,
					["a"] = fb_actions.create,
					["y"] = fb_actions.copy,
					["r"] = fb_actions.rename,
					["m"] = fb_actions.move,
					["h"] = fb_actions.goto_parent_dir,
					["/"] = function()
						vim.cmd("startinsert")
					end,
				},
			},
		},
	},
})

require("telescope").load_extension("file_browser")

local function telescope_buffer_dir()
	return vim.fn.expand("%:p:h")
end

vim.keymap.set("n", "<Leader>g", "<Cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>f", "<Cmd>Telescope find_files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>h", "<Cmd>Telescope help_tags<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-e>", function()
	telescope.extensions.file_browser.file_browser({
		path = "%:p:h",
		cwd = telescope_buffer_dir(),
		respect_gitignore = false,
		hidden = true,
		grouped = true,
		previewer = false,
		initial_mode = "normal",
		layout_config = { height = 40 },
	})
end)
