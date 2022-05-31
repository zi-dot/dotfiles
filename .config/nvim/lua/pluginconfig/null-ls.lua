local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local nullls = require("null-ls")
local formatting = nullls.builtins.formatting
local diagnostics = nullls.builtins.diagnostics

nullls.setup({
    sources = {
        formatting.prettier,
        formatting.stylua,
        nullls.builtins.completion.spell,
    },
    on_attach = function(client, bufnr)
        -- client.resolved_capabilities.document_formatting = false
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.formatting_sync()
                end,
            })
        end
    end,
})
