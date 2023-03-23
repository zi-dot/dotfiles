local status, mason = pcall(require, "mason")
if not status then
	return
end

mason.setup({})

local status2, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status2 then
	return
end
local status3, nvim_lsp = pcall(require, "lspconfig")
if not status3 then
	return
end

-- Utility functions shared between progress reports for LSP and DAP

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

mason_lspconfig.setup_handlers({
	function(server_name)
		local opts = {}

		opts.on_attach = function(client, bufnr)
			local function buf_set_option(...)
				vim.api.nvim_buf_set_option(bufnr, ...)
			end

			buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

			opts = { noremap = true, silent = true }

			local nmap = function(keys, func, desc)
				if desc then
					desc = "LSP: " .. desc
				end

				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
			end

			nmap("gd", ":lua require'telescope.builtin'.lsp_definitions{}<CR>", "[G]o to [d]efinition")
			nmap("gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", "[G]o to [D]eclaration")
			nmap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "[G]o to [i]mplementation")
			nmap("K", "<Cmd>Lspsaga hover_doc<CR>", "Hover doc")
			nmap("gr", "<Cmd>:lua require'telescope.builtin'.lsp_references{}<CR>", "[G]o to [r]]eferences")

			nmap("<Leader>rn", "<Cmd>Lspsaga rename<CR>", "[R]e[n]ame")
			nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
			nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
			nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
			nmap("<leader>ca", "<Cmd>Lspsaga code_action<CR>", "[C]ode [a]ction")

			nmap("<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", "Next diagnostic")

			if client.name == "tsserver" then
				client.server_capabilities.document_formatting = false
			end
		end

		local node_root_dir = nvim_lsp.util.root_pattern("package.json", "node_modules")

		if server_name == "tsserver" then
			opts.root_dir = node_root_dir
			opts.completeFunctionCalls = true
		elseif server_name == "eslint" then
			opts.root_dir = node_root_dir
		elseif server_name == "denols" then
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
