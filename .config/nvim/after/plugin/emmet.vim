let g:user_emmet_mode='a'
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}

autocmd FileType html,css,javascript,jsx,tsx EmmetInstall
