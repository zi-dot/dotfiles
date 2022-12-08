vim.cmd.colorscheme("catppuccin")

require("catppuccin").setup({
	flavour = "latte", -- latte, frappe, macchiato, mocha
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		telescope = true,
		treesitter = true,
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
})
