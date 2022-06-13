local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
local nullls = require("null-ls")
local formatting = nullls.builtins.formatting
local diagnostics = nullls.builtins.diagnostics

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		timeout_ms = 10000,
		filter = function(client)
			return client.name ~= "tsserver"
		end,
		bufnr = bufnr,
	})
end

local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
			once = false,
		})
	end
end

nullls.setup({
	sources = {
		formatting.prettier.with({
			condition = function()
				return vim.fn.executable("prettier") > 0
			end,
		}),
		formatting.stylelint.with({
			condition = function()
				return vim.fn.executable("stylelint") > 0
			end,
		}),
		formatting.stylua,
		nullls.builtins.completion.spell,
		nullls.builtins.code_actions.eslint,
	},
	on_attach = on_attach,
})
