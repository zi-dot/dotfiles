return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
		},
		keys = {
			{
				"<leader>ph",
				function()
					require("gitsigns").preview_hunk()
				end,
				desc = "Preview Hunk",
			},
		},
	},
}
