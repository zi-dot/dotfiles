local saga = require 'lspsaga'

saga.init_lsp_saga {
    error_sign = '',
    warn_sign = '',
    hint_sign = '',
    infor_sign = '',
    border_style = "round",
}


local opt = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opt)
vim.api.nvim_set_keymap('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opt)
vim.api.nvim_set_keymap('n', 'gr', '<Cmd>Lspsaga rename<CR>', opt)
vim.api.nvim_set_keymap('n', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opt)
