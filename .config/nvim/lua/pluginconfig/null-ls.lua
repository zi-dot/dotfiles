-- local nullls = require("null-ls")
-- local formatting = nullls.builtins.formatting
--
-- nullls.setup({
-- 	sources = {
-- 		formatting.prettier,
-- 		formatting.stylelint,
-- 		formatting.eslint_d,
-- 		formatting.stylua,
-- 		nullls.builtins.completion.spell,
-- 	},
-- })
local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

local augroup_format = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.eslint_d.with({
			diagnostics_format = "[eslint] #{m}\n(#{c})",
		}),
		null_ls.builtins.diagnostics.fish,
		null_ls.builtins.formatting.eslint_d,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.stylelint,
		null_ls.builtins.formatting.prettier,
		debug = false,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ buffer = bufnr, group = augroup_format })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup_format,
				buffer = 0,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { noremap = true, silent = true })
