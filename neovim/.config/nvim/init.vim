"
" Anandu B Ajith
"

" 
" General Settings
" ----------------
let mapleader = ","				" Setup leader key
set number
set relativenumber					
set fillchars+=vert:\ 				" Get cleaner split separators
set clipboard=unnamedplus
highlight LineNr ctermfg=Blue
" Searching
set hlsearch
set incsearch
set ignorecase					
set shiftwidth=2 autoindent smartindent tabstop=2 softtabstop=2 expandtab  
set cursorline
set backspace=indent,eol,start confirm

"faster scrolling
set ttyfast
set lazyredraw
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

let g:airline_theme='dracula'
let g:airline_powerline_fonts = 1

highlight Pmenu ctermbg=blue guibg=gray

" 
" Mappings
" --------
" I don't want to mistype
command! Q :q
command! W :w

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
autocmd filetype python nnoremap <C-r> :w <bar> te python %<CR> <ESC> :startinsert <CR>
autocmd filetype asm nnoremap <C-r> :w <bar> te make Q_NO=%:r && ./%:r.out<CR> <ESC> :startinsert <CR>
autocmd filetype markdown nnoremap <C-r> :MarkdownPreview<CR>

" Putting coc config separate
source $HOME/.config/nvim/coc.vim
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
