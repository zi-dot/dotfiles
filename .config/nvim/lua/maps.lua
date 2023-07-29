vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "[dev]", "<Nop>", { silent = true })

vim.keymap.set("", "<Tab>", "<Nop>") -- special case
vim.keymap.set("n", "<C-s>", "<Nop>")

-- Delete or paste without yank
vim.keymap.set({ "n", "v" }, "<Leader>d", '"_d', { silent = true })
vim.keymap.set("v", "<Leader>p", '"_dP', { silent = true })

vim.keymap.set("n", "+", "<C-a>", { silent = true })
vim.keymap.set("n", "-", "<C-x>", { silent = true })

vim.keymap.set("n", "dw", 'vb"_d', { silent = true })

vim.keymap.set("i", "jj", "<ESC>", { silent = true })

vim.keymap.set("n", "k", 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
vim.keymap.set("n", "j", 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })

vim.keymap.set("n", "<Leader>t", ":vsplit term://fish <CR>", { silent = true })
vim.keymap.set("t", "jj", "<C-\\><C-n>", { silent = true })

vim.keymap.set("n", "<Leader>v", ":edit ~/.config/nvim/init.lua<CR>", { silent = true })

vim.keymap.set("n", "ss", ":split<Return>", { silent = true, remap = true })
vim.keymap.set("n", "sv", ":vsplit<Return>", { silent = true, remap = true })

vim.keymap.set("", "s", "<Nop>", { silent = true, remap = true })
vim.keymap.set("", ";", "<Nop>", { silent = true, remap = true })

vim.keymap.set("", "sh", "<C-w>h", { silent = true })
vim.keymap.set("", "sk", "<C-w>k", { silent = true })
vim.keymap.set("", "sj", "<C-w>j", { silent = true })
vim.keymap.set("", "sl", "<C-w>l", { silent = true })

vim.keymap.set({ "n" }, "<D-v>", "p", { silent = true, remap = true })
vim.keymap.set({ "i" }, "<D-v>", "<C-o>p", { silent = true, remap = true })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

vim.keymap.set("n", "<leader>cp", ":let @* = expand('%:p')<CR>", { silent = true })
