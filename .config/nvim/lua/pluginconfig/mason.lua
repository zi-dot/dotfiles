--local capabilities = require("cmp-nvim-lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
--local lspconfig = require("lspconfig")
print("Loading Mason...")
local mason = require("mason")
mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

local nvim_lsp = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

local servers = {
	"bashls",
	"cssls",
	"html",
	"rust_analyzer",
	"sumneko_lua",
	"tailwindcss",
	"tsserver",
}

local has_formatter = { "html", "rust_analyzer", "sumneko_lua", "tsserver", "denols", "stylelint_lsp" }
-- for _, name in pairs(servers) do
-- 	local found, server = require("mason").get_server(name)
-- 	if found and not server:is_installed() then
-- 		print("Installing " .. name)
-- 		server:install()
-- 	end
-- end

vim.api.nvim_create_autocmd("BufWritePre", {
	command = "lua vim.lsp.buf.formatting_sync(nil, 1000)",
	pattern = "*.cpp,*.css,*.scss,*.go,*.h,*.html,*.js,*.json,*.jsx,*.lua,*.md,*.py,*.rs,*.ts,*.tsx,*.yaml",
})

local setup_server = {
	sumneko_lua = function(opts)
		opts.settings = { Lua = { diagnostics = { globals = { "vim" } } } }
	end,
}

local protocol = require("vim.lsp.protocol")

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	-- buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>Lspsaga preview_definition<CR>", opts)
	--buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	--buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	--
	buf_set_keymap("n", "<leader>k", "<Cmd>Lspsaga signature_help<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	--buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<Cmd>Lspsaga rename<CR>", opts)

	--buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
	buf_set_keymap("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", opts)
	--buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts)

	buf_set_keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
	buf_set_keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	buf_set_keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
	--buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	--buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	--
	buf_set_keymap("n", "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	-- buf_set_keymap("n", "<S-C-j>", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	local should_format = true
	for _, value in pairs(has_formatter) do
		if client.name == value then
			should_format = false
		end
	end
	if not should_format then
		client.resolved_capabilities.document_formatting = false
	end

	-- if client.server_capabilities.document_formatting then
	-- 	vim.api.nvim_command([[augroup Format]])
	-- 	vim.api.nvim_command([[autocmd! * <buffer>]])
	-- 	vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]])
	-- 	vim.api.nvim_command([[augroup END]])
	-- end

	--protocol.SymbolKind = { }
	protocol.CompletionItemKind = {
		"", -- Text
		"", -- Method
		"", -- Function
		"", -- Constructor
		"", -- Field
		"", -- Variable
		"", -- Class
		"ﰮ", -- Interface
		"", -- Module
		"", -- Property
		"", -- Unit
		"", -- Value
		"", -- Enum
		"", -- Keyword
		"﬌", -- Snippet
		"", -- Color
		"", -- File
		"", -- Reference
		"", -- Folder
		"", -- EnumMember
		"", -- Constant
		"", -- Struct
		"", -- Event
		"ﬦ", -- Operator
		"", -- TypeParameter
	}
end

mason_lspconfig.setup_handlers({
	function(server_name)
		local opts = {}
		opts.on_attach = on_attach
		if setup_server[server_name] then
			setup_server[server_name](opts)
		end
		nvim_lsp[server_name].setup(opts)
	end,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- mason.on_server_ready(function(server)
-- 	local opts = { on_attach = on_attach }
-- 	--    if server_configs[server.name] then
-- 	--        opts = vim.tbl_deep_extend("force", opts, server_configs[server.name])
-- 	--    end
--
-- 	server:setup(opts)
-- 	vim.cmd([[ do User LspAttachBuffers ]])
-- end)
