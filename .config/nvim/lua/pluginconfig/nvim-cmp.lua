vim.g.completeopt = "menu,menuone,noselect"

local cmp = require("cmp")
local luasnip = require("luasnip")
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    formatting = {
        format = require("lspkind").cmp_format({
            with_text = true,
            menu = {
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                cmp_tabnine = "[TabNine]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[LaTeX]",
                path = "[Path]",
                omni = "[Omni]",
                spell = "[Spell]",
                emoji = "[Emoji]",
                calc = "[Calc]",
                treesitter = "[TS]",
                dictionary = "[Dictionary]",
                mocword = "[mocword]",
            },
        }),
    },
    mapping = {
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<Up>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            else
                vim.api.nvim_feedkeys(t("<Up>"), "n", true)
            end
        end, { "i" }),
        ["<Down>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
                vim.api.nvim_feedkeys(t("<Down>"), "n", true)
            end
        end, { "i" }),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end),

        ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<C-Down>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<C-Up>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-q>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
        { name = "copilot", priority = 90 }, -- For luasnip users.
        { name = "nvim_lsp", priority = 100 },
        { name = "cmp_tabnine", priority = 30 },
        { name = "luasnip", priority = 20 }, -- For luasnip users.
        { name = "path", priority = 100 },
        { name = "emoji", insert = true, priority = 60 },
        { name = "nvim_lua", priority = 50 },
        { name = "nvim_lsp_signature_help", priority = 80 },
    }, {
        { name = "buffer", priority = 50 },
        { name = "omni", priority = 40 },
        { name = "spell", priority = 40 },
        { name = "calc", priority = 50 },
        { name = "treesitter", priority = 30 },
        { name = "dictionary", keyword_length = 2, priority = 10 },
    }),
})

cmp.setup.cmdline(":", {
    mapping = {
        ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { "c" }),

        ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "c" }),
        ["<C-y>"] = {
            c = cmp.mapping.confirm({ select = false }),
        },
        ["<C-q>"] = {
            c = cmp.mapping.abort(),
        },
    },
    sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

vim.cmd("autocmd FileType guihua lua require('cmp').setup.buffer { enabled = false }")
vim.cmd("autocmd FileType guihua_rust lua require('cmp').setup.buffer { enabled = false }")
