local changed_on_branch = function()
	local previewers = require("telescope.previewers")
	local pickers = require("telescope.pickers")
	local sorters = require("telescope.sorters")
	local finders = require("telescope.finders")
	pickers
		.new({}, {
			results_title = "Modified in current branch",
			finder = finders.new_oneshot_job({
				"git",
				"diff",
				"--name-only",
				"--diff-filter=ACMR",
			}, {}),
			sorter = sorters.get_fuzzy_file(),
			previewer = previewers.new_termopen_previewer({
				get_command = function(entry)
					return {
						"git",
						"diff",
						"--diff-filter=ACMR",
						"--",
						entry.value,
					}
				end,
			}),
		})
		:find()
end

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	event = "BufEnter",
	dependencies = {
		"nvim-telescope/telescope-fzf-native.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
		"nvim-telescope/telescope-frecency.nvim",
		"nvim-lua/plenary.nvim",
	},
	build = "make",
	config = function()
		local actions = require("telescope.actions")
		local open_with_trouble = require("trouble.sources.telescope").open

		require("telescope").setup({
			defaults = {
				file_ignore_patterns = { ".git/", "node_modules/", "target/", "dist/", ".next/" },
				initial_mode = "insert",
				sorting_strategy = "ascending",
				-- sorting_strategy = "descending",
				layout_config = {
					prompt_position = "top",
				},
				dynamic_preview_title = true,
				path_display = { filename_first = { reverse_directories = false } },

				mappings = {
					i = {
						["<c-t>"] = open_with_trouble,
						["<S-down>"] = actions.preview_scrolling_down,
						["<S-up>"] = actions.preview_scrolling_up,
					},
					n = {
						["<c-t>"] = open_with_trouble,
						["q"] = actions.close,
						["<C-p>"] = actions.move_selection_previous,
						["<C-n>"] = actions.move_selection_next,
						["<S-down>"] = actions.preview_scrolling_down,
						["<S-up>"] = actions.preview_scrolling_up,
					},
				},
			},
			pickers = {
				find_files = {
					i = {
						["<c-a>"] = "select_all",
					},
				},
				live_grep = {
					mappings = {
						i = {
							["<c-a>"] = "select_all",
						},
					},
				},
				buffers = {
					sort_lastused = true,
					show_all_buffers = true,
					previewer = true,
					mappings = {
						i = {
							["<c-a>"] = "select_all",
							["<leader>bd"] = "delete_buffer",
						},
					},
				},
			},

			extensions = {
				frecency = {
					matcher = "fuzzy",
					show_scores = true,
					show_filter_column = false,
					-- https://github.com/nvim-telescope/telescope-frecency.nvim/issues/270
					db_safe_mode = false,
				},
			},
		})

		require("telescope").load_extension("fzf")
		require("telescope").load_extension("live_grep_args")
		require("telescope").load_extension("frecency")
	end,
	keys = {
		{
			"<leader>?",
			function()
				require("telescope.builtin").oldfiles()
			end,
			desc = "Find recently opened files",
		},
		{
			"<leader><space>",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Find existing buffers",
		},
		{
			"<leader>fr",
			function()
				require("telescope").extensions.frecency.frecency()
			end,
			desc = "Search by Frecency",
		},
		{
			"<leader>/",
			function()
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end,
			desc = "Fuzzily search in current buffer",
		},
		{
			"<leader>sgc",
			function()
				local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
				live_grep_args_shortcuts.grep_word_under_cursor()
			end,
			desc = "Search by grep with word under cursor",
		},
		{
			"<leader>sg",
			function()
				require("telescope").extensions.live_grep_args.live_grep_args()
			end,
			desc = "Search by grep",
		},
		{
			"<leader>sd",
			function()
				require("telescope.builtin").diagnostics()
			end,
			desc = "Search diagnostics",
		},
		{
			"<leader>sf",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Search files",
		},
		{
			"<leader>gm",
			function()
				changed_on_branch()
			end,
			desc = "Git modified files",
		},
		{
			"<leader>sh",
			function()
				require("telescope.builtin").help_tags()
			end,
			desc = "Search [h]elp",
		},
	},
}
