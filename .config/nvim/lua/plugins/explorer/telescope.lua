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
	tag = "0.1.6",
	event = "BufEnter",
	dependencies = {
		"nvim-telescope/telescope-fzf-native.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
		"nvim-telescope/telescope-frecency.nvim",
		"nvim-lua/plenary.nvim",
		build = "make",
		config = function()
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("live_grep_args")
			require("telescope").load_extension("frecency")
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
						["<c-a>"] = "select_all",
						["<leader>bd"] = "delete_buffer",
					},
				},
			},
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("telescope.builtin").oldfiles()
			end,
			desc = "[?] find recently opened files",
		},
		{
			"<leader><space>",
			function()
				require("telescope").extensions.frecency.frecency()
			end,
			desc = "[ ] find existing buffers",
		},
		{
			"<leader>/",
			function()
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end,
			desc = "[/] fuzzily search in current buffer",
		},
		{
			"<leader>sg",
			function()
				require("telescope").extensions.live_grep_args.live_grep_args()
			end,
			desc = "[s]earch by [g]rep",
		},
		{
			"<leader>sd",
			function()
				require("telescope.builtin").diagnostics()
			end,
			desc = "[s]earch [d]iagnostics",
		},
		{
			"<leader>sf",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "[s]earch [f]iles",
		},
		{
			"<leader>gm",
			function()
				changed_on_branch()
			end,
			desc = "[g]it [m]odified files",
		},
		{
			"<leader>sh",
			function()
				require("telescope.builtin").help_tags()
			end,
			desc = "[s]earch [h]elp",
		},
	},
}
