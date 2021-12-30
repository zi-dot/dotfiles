nnoremap [bb] <Nop>
xnoremap [bb] <Nop>
nmap <leader>b [bb]
xmap <leader>b [bb]

" Move to previous/next
nnoremap <silent>    [bb], :BufferPrevious<CR>
nnoremap <silent>    [bb]. :BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    [bb]< :BufferMovePrevious<CR>
nnoremap <silent>    [bb]> :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    [bb]1 :BufferGoto 1<CR>
nnoremap <silent>    [bb]2 :BufferGoto 2<CR>
nnoremap <silent>    [bb]3 :BufferGoto 3<CR>
nnoremap <silent>    [bb]4 :BufferGoto 4<CR>
nnoremap <silent>    [bb]5 :BufferGoto 5<CR>
nnoremap <silent>    [bb]6 :BufferGoto 6<CR>
nnoremap <silent>    [bb]7 :BufferGoto 7<CR>
nnoremap <silent>    [bb]8 :BufferGoto 8<CR>
nnoremap <silent>    [bb]9 :BufferLast<CR>
" Close buffer
nnoremap <silent>    [bb]c :BufferClose<CR>
" Wipeout buffer
"                          :BufferWipeout<CR>
" Close commands
"                          :BufferCloseAllButCurrent<CR>
"                          :BufferCloseAllButPinned<CR>
"                          :BufferCloseBuffersLeft<CR>
"                          :BufferCloseBuffersRight<CR>
" Magic buffer-picking mode
nnoremap <silent> [bb]p    :BufferPick<CR>
" Sort automatically by...
nnoremap <silent> [bb]bb :BufferOrderByBufferNumber<CR>
nnoremap <silent> [bb]bd :BufferOrderByDirectory<CR>
nnoremap <silent> [bb]bl :BufferOrderByLanguage<CR>
nnoremap <silent> [bb]bw :BufferOrderByWindowNumber<CR>

" Other:
" :BarbarEnable - enables barbar (enabled by default)
" :BarbarDisable - very bad command, should never be used
