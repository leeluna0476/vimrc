set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'scrooloose/nerdtree'
call vundle#end()
filetype plugin indent on

let g:NERDTreeWinSize = 35
let g:NERDTreeHijackNetrw = 0
let g:NERDTreeQuitOnOpen = 1
let NERDTreeWinPos = "left"
let g:NERDTreeQuitOnOpen = 0
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

colorscheme retrobox
syntax on
set wildmenu
set showcmd
set hlsearch
set incsearch
set cindent
set expandtab
set ts=4
set sw=4
set tags +=./tags,tags;
set nocompatible
set backspace=3
set nu
set showcmd
filetype plugin on

nmap <Up>    <Nop>
nmap <Down>  <Nop>
nmap <Left>  <Nop>
nmap <Right> <Nop>
imap <Up>    <Nop>
imap <Down>  <Nop>
imap <Left>  <Nop>
imap <Right> <Nop>
nmap <CR> o<Esc>
nmap <C-h> :nohl<CR>
nmap T :tabnew 
nmap H gT
nmap L gt

autocmd Filetype * nmap <buffer> <silent> <C-f> :NERDTreeToggle<CR>

"shortcut for c,cpp
autocmd FileType c,cpp vmap <buffer> <silent> <C-l> :norm i//<CR>0
autocmd FileType c,cpp vmap <buffer> <silent> <C-k> :s/\/\///e<CR>:nohl<CR>
autocmd FileType c,cpp nmap <buffer> <silent> <C-l> 0:norm i//<CR>0
autocmd FileType c,cpp nmap <buffer> <silent> <C-k> V:s/\/\///e<CR>:nohl<CR>
autocmd FileType c,cpp nmap <buffer> <silent> gp [{kVj%y<C-o><C-o>

"apply templates for .cpp and .hpp files
autocmd BufNewFile test.cpp,main.cpp,test.c,main.c silent 0r ~/templates/main.cpp | silent! $delete
autocmd BufNewFile *.hpp silent 0r ~/templates/header.hpp | silent! $delete
autocmd BufNewFile *.h silent 0r ~/templates/header.h | silent! $delete
autocmd BufNewFile *.h,*.hpp call SubstituteHeader()

command! -nargs=1 Remote call OpenRemoteFile(<f-args>)

"A function that retrieves the filename and changes it to uppercase.
function! SubstituteHeader()
    let filename = expand('%:t:r')
    execute ':%s/HEADER/' . toupper(filename) . '/'
endfunction

"Reinterpret .tpp as .cpp to hightlight the syntax in the same way.
augroup tpp_files
    autocmd!
    autocmd BufNewFile,BufRead *.tpp set filetype=cpp
augroup END
