return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				keymaps = {
					normal = "sr",
					normal_cur = "srr",
					normal_line = "sR",
					normal_line_cur = "sRR",
					visual = "sr",
				},
			})
		end,
	},
}
