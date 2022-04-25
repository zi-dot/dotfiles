require 'navigator'.setup({
    lsp_installer = true,
    lsp_signature_help = true,
    icons = {
        code_action_icon = "",
        -- code lens
        code_lens_action_icon = '👓',
        -- Diagnostics
        diagnostic_head = '🧨',
        diagnostic_err = ' ',
        diagnostic_warn = ' ',
        diagnostic_info = [[👩]],
        diagnostic_hint = [[💁]],

        diagnostic_head_severity_1 = '❌',
        diagnostic_head_severity_2 = '🔸',
        diagnostic_head_severity_3 = '💬',
        diagnostic_virtual_text = '',
        diagnostic_file = '🚑',
        -- Values
        value_changed = '📝',
        value_definition = '🐶🍡', -- it is easier to see than 🦕
        -- Treesitter
        match_kinds = {
            var = ' ', -- "👹", -- Vampaire
            method = 'ƒ ', --  "🍔", -- mac
            ['function'] = ' ', -- "🤣", -- Fun
            parameter = '  ', -- Pi
            associated = '🤝',
            namespace = '🚀',
            type = ' ',
            field = '🏈',
        },
    },
    lsp = {
        format_on_save = false,
    }
})
