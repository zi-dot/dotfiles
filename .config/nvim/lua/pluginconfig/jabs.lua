require("jabs").setup({
	position = "center",
	sort_mru = true,
	split_filename = true,
})
vim.keymap.set("n", "<leader>o", ":JABSOpen<CR>", { noremap = true })
