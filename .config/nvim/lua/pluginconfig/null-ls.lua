local nullls = require "null-ls"
nullls.setup {
    sources = {
        nullls.builtins.formatting.stylua,
        nullls.builtins.diagnostics.eslint,
        nullls.builtins.completion.spell,
        nullls.builtins.formatting.prettier,
    },
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
        end
    end,
}
