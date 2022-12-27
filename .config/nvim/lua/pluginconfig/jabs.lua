require("jabs").setup({
  position = "center",
  width = 100,
  height = 40,
  border = "rounded",
  sort_mru = true,
  use_devicons = true,
})
vim.keymap.set("n", "<leader>o", ":JABSOpen<CR>", { noremap = true })
