vim.o.number = true
vim.o.ignorecase = true
vim.o.lazyredraw = true
vim.o.clipboard = "unnamedplus"
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.showcmd = true

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.cmdheight = 1
vim.o.laststatus = 2

vim.o.shiftwidth = 2
vim.o.tabstop = 2

vim.o.updatetime = 100

vim.o.expandtab = true

vim.o.confirm = true
vim.o.backup = false
vim.o.hidden = true
vim.o.autoread = true

vim.o.termguicolors = true

vim.g.mapleader = " "

vim.o.cursorline = true

local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | PackerCompile",
	group = packer_group,
	pattern = "plugins.lua",
})

require("plugins")

vim.g.catppuccin_flavour = "mocha"
vim.cmd("colorscheme catppuccin")

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "m", "[dev]", { silent = true, remap = true })
vim.keymap.set({ "n", "v" }, "[dev]", "<Nop>", { silent = true })

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

vim.keymap.set("n", "ss", ":split<Return><C-w>w", { silent = true, remap = true })
vim.keymap.set("n", "sv", ":vsplit<Return><C-w>w", { silent = true, remap = true })

vim.keymap.set("", "s", "<Nop>", { silent = true, remap = true })
vim.keymap.set("", ";", "<Nop>", { silent = true, remap = true })

vim.keymap.set("", "sh", "<C-w>h", { silent = true })
vim.keymap.set("", "sk", "<C-w>k", { silent = true })
vim.keymap.set("", "sj", "<C-w>j", { silent = true })
vim.keymap.set("", "sl", "<C-w>l", { silent = true })

--vim.keymap.set("", "<Leader>l", "<C-w><")
--vim.keymap.set("", "<Leader>h", "<C-w>>")
--vim.keymap.set("", "<Leader>j", "<C-w>-")
--vim.keymap.set("", "<Leader>k", "<C-w>+")
