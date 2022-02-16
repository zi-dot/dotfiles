if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin(g:plug_home)

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'cohama/lexima.vim'

if has("nvim")
  Plug 'machakann/vim-sandwich'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/remote', 'do': ':UpdateRemotePlugins' }
  Plug 'ryanoasis/vim-devicons'
  Plug 'romgrk/barbar.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'hoob3rt/lualine.nvim'
  Plug 'kristijanhusak/defx-git'
  Plug 'kristijanhusak/defx-icons'
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'itchyny/lightline.vim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'typescriptreact', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html', 'php', 'pug'] }
  Plug 'alvan/vim-closetag'
  Plug 'mattn/emmet-vim', { 'for': ['javascript', 'jsx', 'html', 'css'] }
  Plug 'Galooshi/vim-import-js'
  Plug 'github/copilot.vim'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'onsails/lspkind-nvim'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'https://github.com/skanehira/jumpcursor.vim'
endif

Plug 'groenewege/vim-less', { 'for': 'less' }

call plug#end()
