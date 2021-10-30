if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin(g:plug_home)

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'cohama/lexima.vim'

if has("nvim")
  Plug 'prabirshrestha/vim-lsp'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'kristijanhusak/defx-git'
  Plug 'kristijanhusak/defx-icons'
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'neovim/nvim-lspconfig'
  Plug 'glepnir/lspsaga.nvim'
  Plug 'folke/lsp-colors.nvim'
  Plug 'nvim-lua/completion-nvim'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'itchyny/lightline.vim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'typescriptreact', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html', 'php', 'pug'] }
  Plug 'alvan/vim-closetag'
  Plug 'jwalton512/vim-blade'
  Plug 'kabouzeid/nvim-lspinstall'
  Plug 'mattn/emmet-vim', { 'for': ['javascript', 'jsx', 'html', 'css'] }
  Plug 'Galooshi/vim-import-js'
endif

Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }

call plug#end()
