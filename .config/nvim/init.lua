vim.o.number = true
vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.lazyredraw = true
vim.o.clipboard = "unnamedplus"
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.showcmd = true

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
require("maps")

vim.api.nvim_create_augroup("reload_vim", {})
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | PackerCompile",
	group = "reload_vim",
	pattern = { "*.lua", "*.vim" },
})

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
