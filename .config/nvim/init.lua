vim.loader.enable()

vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.o.number = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.clipboard = "unnamedplus"
vim.o.showmatch = true
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.completeopt = "menuone,noselect"
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.showcmd = true

vim.o.cmdheight = 1
vim.o.laststatus = 3

vim.o.shiftwidth = 2
vim.o.tabstop = 2

vim.o.updatetime = 300

vim.o.expandtab = true

vim.o.confirm = true
vim.o.backup = false
vim.o.hidden = true
vim.o.autoread = true
vim.o.incsearch = true
vim.o.hlsearch = true

vim.o.termguicolors = true

vim.g.mapleader = " "
vim.o.visualbell = true

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

vim.o.relativenumber = false

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
})

vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#ced6cf", bg = "NONE", bold = true })
