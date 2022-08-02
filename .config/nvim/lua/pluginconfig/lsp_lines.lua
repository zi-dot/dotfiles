require("lsp_lines").setup()
vim.diagnostic.config({ virtual_lines = true })
vim.keymap.set("", "<Leader>l", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
