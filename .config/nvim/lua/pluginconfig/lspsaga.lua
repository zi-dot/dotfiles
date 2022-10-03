local status, saga = pcall(require, "lspsaga")
if not status then
	return
end

saga.init_lsp_saga({
	server_filetype_map = {
		typescript = "typescript",
	},
})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
-- vim.keymap.set("n", "gr", "<Cmd>Lspsaga lsp_finder<CR>", opts)
vim.keymap.set("n", "gr", "<Cmd>:lua require'telescope.builtin'.lsp_references{}<CR>", opts)
vim.keymap.set("i", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", opts)
-- vim.keymap.set("n", "gd", "<Cmd>Lspsaga peek_definition<CR>", opts)
vim.keymap.set("n", "gd", ":lua require'telescope.builtin'.lsp_definitions{}<CR>", opts)
vim.keymap.set("n", "<Leader>rn", "<Cmd>Lspsaga rename<CR>", opts)
