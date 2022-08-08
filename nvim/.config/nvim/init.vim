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
set mouse=a
set clipboard+=unnamedplus


if exists('g:vscode')
    " vscode neovim
    call plug#begin()
    Plug 'asvetliakov/vim-easymotion', { 'as': 'vsc-easymotion' }
    call plug#end()

    :nnoremap <Leader>s :%s/<C-r><C-w>//g<Left><Left>
else
    " ordinary neovim
    call plug#begin()
    Plug 'easymotion/vim-easymotion'
    Plug 'Mofiqul/dracula.nvim'
    call plug#end()

    :nnoremap <Leader>s :%s/<C-r><C-w>//g<Left><Left>
endif

let g:EasyMotion_smartcase = 1
colorscheme dracula   

" map s to global search
nmap s <Plug>(easymotion-s)

" move selections up or down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>== 
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
noremap <A-k> :m '<-2<CR>gv=gv
