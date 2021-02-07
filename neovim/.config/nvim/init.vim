"
" Anandu B Ajith <mail@anandu.net> (https://anandu.net)
"
"

let mapleader = ","				        " Setup leader key
set number
syntax enable
set hidden
set hlsearch
set incsearch
set ignorecase
set cursorline
set backspace=indent,eol,start confirm
set ttyfast 				            " for speedup
set lazyredraw
set noshowcmd
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=50                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set shiftwidth=4 autoindent smartindent tabstop=4 softtabstop=4 expandtab

set splitbelow					" Default locations for splits
set splitright
source $HOME/.config/nvim/plugins.vim

" KeyBindings

" Run commands
autocmd filetype cpp nnoremap <C-r> :w <bar> te g++ -std=c++14 % -o %:r.out && ./%:r.out<CR> <ESC> :startinsert <CR>
autocmd filetype c nnoremap <C-r> :w <bar> te gcc -lm -pthread % -o %:r.out && ./%:r.out<CR> <ESC> :startinsert <CR>
autocmd filetype python nnoremap <C-r> :w <bar> split <bar> resize 8 <bar> te python %<CR> <ESC> :startinsert <CR>
autocmd filetype asm nnoremap <C-r> :w <bar> te make Q_NO=%:r && ./%:r.out<CR> <ESC> :startinsert <CR>
autocmd filetype markdown nnoremap <C-r> :MarkdownPreview<CR>

" Make editing config easier
nnoremap <leader>ec :tabnew $MYVIMRC<CR>
nmap <leader><space> :nohlsearch<cr>
" MisTypes
command! Q :q
command! W :w
cmap w!! w !sudo tee %

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" Autosouce the config file on update
augroup ANANDU 
  autocmd!
   autocmd BufWritePre * :call TrimWhitespace()
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END
