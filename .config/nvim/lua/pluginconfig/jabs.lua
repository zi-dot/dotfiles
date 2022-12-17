require("jabs").setup({
  sort_mru = true,
})
vim.keymap.set("n", "<leader>o", ":JABSOpen<CR>", { noremap = true })
