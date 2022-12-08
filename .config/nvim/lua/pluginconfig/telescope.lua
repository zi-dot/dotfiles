local telescope = require("telescope")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local fb_actions = require("telescope").extensions.file_browser.actions
local gitmoji = require("telescope").extensions.gitmoji.gitmoji

local telescope_custom_actions = {}

function telescope_custom_actions._multiopen(prompt_bufnr, open_cmd)
	local picker = action_state.get_current_picker(prompt_bufnr)
	local selected_entry = action_state.get_selected_entry()
	local num_selections = #picker:get_multi_selection()
	if not num_selections or num_selections <= 1 then
		actions.add_selection(prompt_bufnr)
	end
	actions.send_selected_to_qflist(prompt_bufnr)
	vim.cmd("cfdo " .. open_cmd)
end

function telescope_custom_actions.multi_selection_open_vsplit(prompt_bufnr)
	telescope_custom_actions._multiopen(prompt_bufnr, "vsplit")
end

function telescope_custom_actions.multi_selection_open_split(prompt_bufnr)
	telescope_custom_actions._multiopen(prompt_bufnr, "split")
end

function telescope_custom_actions.multi_selection_open_tab(prompt_bufnr)
	telescope_custom_actions._multiopen(prompt_bufnr, "tabe")
end

function telescope_custom_actions.multi_selection_open(prompt_bufnr)
	telescope_custom_actions._multiopen(prompt_bufnr, "edit")
end

telescope.setup({
	defaults = {
		file_ignore_patterns = { ".git/", "node_modules/", "target/" },
		initial_mode = "insert",
		hidden = true,
	},
	pickers = {
		find_files = {
			hidden = true,
			mappings = {
				i = {
					["<CR>"] = telescope_custom_actions.multi_selection_open,
				},
				n = {
					["<CR>"] = telescope_custom_actions.multi_selection_open,
				},
			},
		},
		live_grep = {
			hidden = true,
			mappings = {
				i = {
					["<CR>"] = telescope_custom_actions.multi_selection_open,
				},
				n = {
					["<CR>"] = telescope_custom_actions.multi_selection_open,
				},
			},
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
vim.keymap.set("n", "<Leader>l", "<Cmd>Telescope find_files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>h", "<Cmd>Telescope help_tags<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>e", "<Cmd>Telescope gitmoji<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-e>", function()
-- 	telescope.extensions.file_browser.file_browser({
-- 		path = "%:p:h",
-- 		cwd = telescope_buffer_dir(),
-- 		respect_gitignore = false,
-- 		hidden = true,
-- 		grouped = true,
-- 		previewer = false,
-- 		initial_mode = "normal",
-- 		layout_config = { height = 40 },
-- 	})
-- end)
