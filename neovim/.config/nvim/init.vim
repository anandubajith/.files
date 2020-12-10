"
" Anandu B Ajith <mail@anandu.net> (https://anandu.net)
"
autocmd BufNewFile,BufRead *.sage set syntax=python
" 
" General Settings
" ---------------- Trying jj to esc thing
inoremap jj <esc>
let mapleader = ","				" Setup leader key
set number
set relativenumber					
set fillchars+=vert:\ 				" Get cleaner split separators
set clipboard=unnamedplus
highlight LineNr ctermfg=Blue " Searching
set hlsearch
set incsearch
set ignorecase					
set shiftwidth=2 autoindent smartindent tabstop=2 softtabstop=2 expandtab  
set cursorline
set backspace=indent,eol,start confirm

"faster scrolling
set ttyfast
set lazyredraw
set mouse=a
nmap <leader><space> :nohlsearch<cr>

" Split Management
nmap <C-H> <C-W><C-H>				" Make it easier , remove redundant Ctrl+W
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>
set splitbelow					" Default locations for splits
set splitright
" Tab management
nnoremap <C-t>     :tabnew<CR>
inoremap <C-t>     <Esc>:tabnew<CR>
nnoremap Q <nop>
" I don't want to mistype
command! Q :q
command! W :w
"
" Plugins
" -------
call plug#begin('~/.vim/plugged')
Plug 'mhinz/vim-startify' 			    " Startup screen
Plug 'preservim/nerdtree'			    " we need a fileBrowser
Plug 'Xuyuanp/nerdtree-git-plugin'		" For git indicators in NerdTree
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary' 			" Easier commenting
"Plug 'morhetz/gruvbox'
Plug 'junegunn/goyo.vim'
"Plug 'gosukiwi/vim-atom-dark'
Plug 'junegunn/fzf.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ThePrimeagen/vim-be-good'
Plug 'posva/vim-vue'                    " Vue 
Plug 'leafgarland/typescript-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'happycoder97/expos-vim-plugins'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
call plug#end()


xnoremap <C-\> gc

" I think these are required for prettier config
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
colorscheme dracula 
set background=dark termguicolors cursorline
highlight CursorLine guibg=#44475a ctermbg=234
hi! Normal ctermbg=NONE guibg=NONE 
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE 

" Plugin specific configs 

" vim-airline
let g:airline_theme='dracula'
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1           " enable airline tabline                                                           
let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline                                            
let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)      
let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab                                                    
let g:airline#extensions#tabline#show_tab_count = 0    " dont show tab numbers on the tab  
let g:airline#extensions#tabline#show_buffers = 0      " dont show buffers in the tabline                                                 
let g:airline#extensions#tabline#tab_min_count = 2     " minimum of 2 tabs needed to display the tabline                                  
let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline               
let g:airline#extensions#tabline#show_tab_nr = 0       " disable tab numbers                                                              
let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird ornage arrow on the tabline
highlight Pmenu ctermbg=blue guibg=gray
set noshowmode
set noruler
set noshowcmd

" FZF
nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> <C-o> :Buffers<CR>
nnoremap <C-f> :Rg! 

nnoremap <leader>ec :tabnew $MYVIMRC<CR>	" Make editing the config easier
" Commenting
"nnoremap <C-\> gc

" Startify
let g:startify_lists = [ { 'type': 'dir', 'header': ['   MRU '. getcwd()] }]

" Run commands 
autocmd filetype cpp nnoremap <C-r> :w <bar> te g++ -std=c++14 % -o %:r.out && ./%:r.out<CR> <ESC> :startinsert <CR>
autocmd filetype c nnoremap <C-r> :w <bar> te gcc -lm -pthread % -o %:r.out && ./%:r.out<CR> <ESC> :startinsert <CR>
autocmd filetype python nnoremap <C-r> :w <bar> split <bar> resize 8 <bar> te python %<CR> <ESC> :startinsert <CR>
autocmd filetype asm nnoremap <C-r> :w <bar> te make Q_NO=%:r && ./%:r.out<CR> <ESC> :startinsert <CR>
autocmd filetype markdown nnoremap <C-r> :MarkdownPreview<CR>

" Putting coc config separate
source $HOME/.config/nvim/coc.vim
set cmdheight=1
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" 
" AutoCommands
" ------------

" Autosouce the config file on update
augroup autosourcing
  autocmd!
  autocmd BufWritePost init.vim source %
augroup END
" NOTES
" " then register name, and you can paste through registers
" Ctrl+6 to toggle between edit points
" zz to center the current line
