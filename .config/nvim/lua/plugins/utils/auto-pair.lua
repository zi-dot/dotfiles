return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	{
		"echasnovski/mini.surround",
		event = "VeryLazy",
		version = false,
		config = function()
			require("mini.surround").setup({
				mappings = {
					highlight = "<Nop>",
					update_n_lines = "<Nop>",
				},
			})
		end,
	},
}
