-- vim.loader = false
if vim.loader then
	vim.loader.enable()
end

vim.o.number = true
vim.o.ignorecase = true
vim.o.clipboard = "unnamedplus"
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.showcmd = true

vim.o.cmdheight = 1
vim.o.laststatus = 3

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

require("maps")

require("config.lazy")({
	debug = false,
	defaults = {
		lazy = true,
	},
	performance = {
		cache = {
			enabled = true,
		},
	},
})

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

vim.cmd([[colorscheme ayu]])
-- vim.cmdhttps://docs.google.com/document/d/1Co63hMjSN3p6YGEI8kb_8tofx0fVWt0gJmBfrxy_chQ/edit.colorscheme("catppuccin")
vim.o.relativenumber = false

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
})

vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#ced6cf", bg = "NONE", bold = true })
