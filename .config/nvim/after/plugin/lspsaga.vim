if !exists('g:loaded_lspsaga') | finish | endif

lua << EOF
local saga = require 'lspsaga'

saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = "round",
}

EOF

"nnoremap <silent> <C-j> :Lspsaga diagnostic_jump_next<CR>
"nnoremap <silent> <C-k> :Lspsaga hover_doc<CR>
"nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent> gh :Lspsaga lsp_finder<CR>
"nnoremap <silent> gp :Lspsaga preview_definition<CR>
"nnoremap <silent> <space>ca :Lspsaga code_action<CR>
