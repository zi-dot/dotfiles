local status, mason = pcall(require, "mason")
if not status then
	return
end
local status2, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status2 then
	return
end
local status3, nvim_lsp = pcall(require, "lspconfig")
if not status3 then
	return
end

local protocol = require("vim.lsp.protocol")
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

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

mason.setup({})

mason_lspconfig.setup_handlers({
	function(server_name)
		local opts = {}

		opts.on_attach = function(client, bufnr)
			local function buf_set_keymap(...)
				vim.api.nvim_buf_set_keymap(bufnr, ...)
			end

			local function buf_set_option(...)
				vim.api.nvim_buf_set_option(bufnr, ...)
			end

			buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

			local opts = { noremap = true, silent = true }

			buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
			buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
			if client.name == "tsserver" then
				client.server_capabilities.document_formatting = false
			end
		end

		local node_root_dir = nvim_lsp.util.root_pattern("package.json")
		local is_node_repo = node_root_dir(vim.api.nvim_buf_get_name(0)) ~= nil

		if server_name == "tsserver" then
			if is_node_repo then
				return
			end

			opts.root_dir = node_root_dir
		elseif server_name == "eslint" then
			if not is_node_repo then
				return
			end

			opts.root_dir = node_root_dir
		elseif server_name == "denols" then
			if is_node_repo then
				return
			end

			opts.root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc", "deps.ts", "import_map.json")
			opts.init_options = {
				lint = true,
				unstable = true,
				suggest = {
					imports = {
						hosts = {
							["https://deno.land"] = true,
							["https://cdn.nest.land"] = true,
							["https://crux.land"] = true,
						},
					},
				},
			}
		end

		opts.capabilities = capabilities

		nvim_lsp[server_name].setup(opts)
	end,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	update_in_insert = false,
	virtual_text = { spacing = 4, prefix = "●" },
	severity_sort = true,
})

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
	},
	update_in_insert = true,
	float = {
		source = "always", -- Or "if_many"
	},
})
