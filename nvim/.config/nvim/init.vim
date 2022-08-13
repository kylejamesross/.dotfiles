let mapleader=" "

set number

set relativenumber

set signcolumn=number

set noswapfile
set nobackup

set nohlsearch

set ignorecase

set history=1000

set ruler

set showcmd

set wildmenu

set scrolloff=8

set incsearch

set expandtab

set shiftwidth=2
set tabstop=2
set softtabstop=2

set hidden

set ai
set smartindent

set bg=dark
set updatetime=250
set encoding=UTF-8
set clipboard+=unnamedplus


if exists('g:vscode')
    " vscode neovim
    call plug#begin()
    Plug 'asvetliakov/vim-easymotion', { 'as': 'vsc-easymotion' }
    call plug#end()

    :nnoremap :%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>
else
    " ordinary neovim
    call plug#begin()
    Plug 'easymotion/vim-easymotion'
    Plug 'Mofiqul/dracula.nvim'
    call plug#end()

    :nnoremap <Leader>s :%s/<C-r><C-w>//g<Left><Left>
endif

colorscheme dracula   
let g:EasyMotion_smartcase = 1

" map s to global search
nmap s <Plug>(easymotion-s)
nnoremap <leader>x :!chmod +x %<CR>
vnoremap <leader>p "_dP
vnoremap <leader>y "+y
nnoremap <leader>y "+y
vnoremap <leader>w "+p
nnoremap <leader>w "+p
nnoremap <leader>Y gg"+yG
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

