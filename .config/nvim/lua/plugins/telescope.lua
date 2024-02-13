return {
  "nvim-telescope/telescope.nvim",
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-lua/plenary.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
		opts = {
			defaults = {
				file_ignore_patterns = { ".git/", "node_modules/", "target/" },
				initial_mode = "insert",
				hidden = true,
			},
			pickers = {
				find_files = {
					hidden = true,
				},
				live_grep = {
					hidden = true,
				},
				buffers = {
					sort_lastused = true,
					show_all_buffers = true,
					previewer = true,
					mappings = {
						i = {
							["<C-a>"] = "select_all",
							["<leader>bd"] = "delete_buffer",
						},
					},
				},
			},
		},
		keys = {
			{
				"<leader>?",
				require("telescope.builtin").oldfiles,
				desc = "[?] Find recently opened files",
			},
			{ "<leader><space>", require("telescope.builtin").buffers, desc = "[ ] Find existing buffers" },
			{
				"<leader>/",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = false,
					}))
				end,
				desc = "[/] Fuzzily search in current buffer",
			},
			{ "<leader>sg", require("telescope.builtin").live_grep, desc = "[S]earch by [G]rep" },
			{ "<leader>sd", require("telescope.builtin").diagnostics, desc = "[S]earch [D]iagnostics" },
			{ "<leader>sf", require("telescope.builtin").find_files, desc = "[S]earch [F]iles" },
			{ "<leader>sh", require("telescope.builtin").help_tags, desc = "[S]earch [H]elp" },
		},
	},
}
