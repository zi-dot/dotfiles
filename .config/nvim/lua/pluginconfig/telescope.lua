local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local config = require("telescope.config")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local previewers = require("telescope.previewers")
local utils = require("telescope.utils")
local conf = require("telescope.config").values
local telescope_builtin = require("telescope.builtin")
local Path = require("plenary.path")

require("telescope").setup({
	extensions = {
		media_files = {
			filetypes = { "png", "webp", "jpg", "jpeg" }, -- filetypes whitelist
			find_cmd = "rg", -- find command
		},
		arecibo = {
			["selected_engine"] = "google",
			["url_open_command"] = "xdg-open",
			["show_http_headers"] = false,
			["show_domain_icons"] = false,
		},
		frecency = { ignore_patterns = { "*.git/*", "*/tmp/*", "*/node_modules/*" }, db_safe_mode = false },
		project = {
			base_dirs = (function()
				local dirs = {}
				local function file_exists(fname)
					local stat = vim.loop.fs_stat(vim.fn.expand(fname))
					return (stat and stat.type) or false
				end
				if file_exists("~/.ghq") then
					dirs[#dirs + 1] = { "~/.ghq", max_depth = 5 }
				end
				if file_exists("~/Workspace") then
					dirs[#dirs + 1] = { "~/Workspace", max_depth = 3 }
				end
				if #dirs == 0 then
					return nil
				end
				return dirs
			end)(),
		},
	},
})

vim.api.nvim_set_keymap("n", "[fuzzy-finder]", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "[fuzzy-finder]", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", ";", "[fuzzy-finder]", {})
vim.api.nvim_set_keymap("v", ";", "[fuzzy-finder]", {})

vim.api.nvim_set_keymap("n", "[fuzzy-finder]g", "<Cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[fuzzy-finder]b", "<Cmd>Telescope buffers<CR>", { noremap = true, silent = true })
