vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "[dev]", "<Nop>", { silent = true })

vim.keymap.set("", "<Tab>", "<Nop>") -- special case
vim.keymap.set("n", "<C-s>", "<Nop>")

vim.keymap.set("v", "p", '"_dP', { silent = true })

vim.keymap.set("n", "+", "<C-a>", { silent = true })
vim.keymap.set("n", "-", "<C-x>", { silent = true })

vim.keymap.set("n", "k", 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
vim.keymap.set("n", "j", 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })

vim.keymap.set("t", "jj", "<C-\\><C-n>", { silent = true })

vim.keymap.set("n", "s", "<Nop>", { silent = true })

vim.keymap.set("n", "ss", ":split<Return>", { silent = true, remap = true })
vim.keymap.set("n", "sv", ":vsplit<Return>", { silent = true, remap = true })

vim.keymap.set({ "n" }, "sh", "<C-w>h", { silent = true })
vim.keymap.set({ "n" }, "sk", "<C-w>k", { silent = true })
vim.keymap.set({ "n" }, "sj", "<C-w>j", { silent = true })
vim.keymap.set({ "n" }, "sl", "<C-w>l", { silent = true })

vim.keymap.set({ "n" }, "<D-v>", "p", { silent = true, remap = true })
vim.keymap.set({ "i" }, "<D-v>", "<C-o>p", { silent = true, remap = true })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

vim.keymap.set("n", "<leader>cp", ":let @* = expand('%:p')<CR>", { silent = true })

vim.keymap.set("n", "<leader>deleteswap", ":!rm ~/.local/state/nvim/swap/*", { silent = true })

vim.keymap.set("n", "]q", ":cnext<CR>", { silent = true })
vim.keymap.set("n", "[q", ":cprev<CR>", { silent = true })

vim.keymap.set("n", "cp", ":cprev<CR>", { silent = true })
vim.keymap.set("n", "cn", ":cnext<CR>", { silent = true })

vim.keymap.set({ "n" }, "n", "nzz", { noremap = true, silent = true })
vim.keymap.set({ "n" }, "N", "Nzz", { noremap = true, silent = true })
vim.keymap.set({ "n" }, "*", "*zz", { noremap = true, silent = true })
