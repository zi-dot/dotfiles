return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		picker = { enabled = true },
		git = { enabled = true },
		notifier = { enabled = true },
		terminal = { enabled = true },
		scratch = { enabled = true },
		bufdelete = { enabled = true },
		rename = { enabled = true },
		gitbrowse = { enabled = true },
		lazygit = { enabled = true },
		toggle = { enabled = true },
		words = { enabled = true },
		win = { enabled = true },
		debug = { enabled = true },
		explorer = { enabled = true },
		zen = {
			enabled = true,
		},
		scroll = { enabled = false },
	},
	keys = {
		-- Buffers and Files
		{
			"<leader><space>",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Find existing buffers",
		},
		{
			"<leader>sf",
			function()
				Snacks.picker.files()
			end,
			desc = "Search files",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Search by Frecency",
		},
		-- Search
		{
			"<leader>/",
			function()
				Snacks.picker.lines()
			end,
			desc = "Fuzzily search in current buffer",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Search by grep",
		},
		{
			"<leader>sgc",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Search by grep with word under cursor",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Search diagnostics",
		},
		-- Git
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git status",
		},
		{
			"<leader>gm",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git modified files",
		},
		-- Help
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "Search [h]elp",
		},
		-- Zen
		{
			"<leader>zz",
			function()
				Snacks.zen()
			end,
		},
	},
}
