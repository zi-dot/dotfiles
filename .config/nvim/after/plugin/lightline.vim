if !exists('g:loaded_lightline')
  finish
endif

let g:lightline = {
  \'component_function': {
  \ 'filename': 'LightLineFileName',
  \ },
  \ }

function! LightLineFileName()
  " is no name?
  if expand('%:~:.') ==# ''
    return '[No Name]'
  endif

  " has git dir in parent
  if finddir('.git/..', expand('%:p:h').';') ==# ''
    return expand('%:p')
  endif

  return expand('%:p')[strlen(finddir('.git/..', expand('%:p:h').';')):]
endfunction
