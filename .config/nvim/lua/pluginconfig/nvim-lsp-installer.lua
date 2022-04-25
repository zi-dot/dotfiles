local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
end


local server_configs = {
	["sumneko_lua"] = {
		settings = {
			Lua = {
				workspace = {
					-- Make the server aware of Neovim runtime files
					-- library = vim.api.nvim_get_runtime_file("", true),
					preloadFileSize = 500,
					-- very slow
					-- library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = { enable = false },
			},
		},
	},
}

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = { capabilities = capabilities, on_attach = on_attach }
	if server_configs[server.name] then
        print('hello world')
		opts = vim.tbl_deep_extend("force", opts, server_configs[server.name])
	end
	server:setup(opts)
	vim.cmd([[ do User LspAttachBuffers ]])
end)
