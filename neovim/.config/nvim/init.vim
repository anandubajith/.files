"
" Anandu B Ajith <mail@anandu.net> (https://anandu.net)
"


" --- Basic setup
let mapleader = ","                     " setup leader key
set number
syntax enable
set hidden
set hlsearch
set incsearch
set ignorecase
set backspace=indent,eol,start confirm
set clipboard=unnamedplus               " by default use system clipboard
set ttyfast
set lazyredraw
set noshowcmd
set noshowmode                          " hide --INSERT-- text
set nobackup
set updatetime=50                       " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set shiftwidth=4 autoindent smartindent tabstop=4 softtabstop=4 expandtab

set signcolumn=yes
set splitbelow					        " Default locations for splits
set splitright

" --- Plugin setup
call plug#begin('~/.vim/plugged')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'joshdick/onedark.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'maxmellon/vim-jsx-pretty'
    Plug 'mechatroner/rainbow_csv'

    "Plug 'gruvbox-community/gruvbox'

    " JavaScript recommended plugins
    Plug 'pangloss/vim-javascript'
    Plug 'leafgarland/typescript-vim'
    Plug 'peitalin/vim-jsx-typescript'
    Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
    Plug 'jparise/vim-graphql'
    Plug 'ryanoasis/vim-devicons'
call plug#end()

colorscheme onedark

if (has("autocmd") && !has("gui_running"))
    augroup colorset
        autocmd!
        let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
        autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
    augroup END
endif
hi Comment cterm=italic
let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
let g:onedark_termcolors=256
if (has("termguicolors"))
     set termguicolors
     hi LineNr ctermbg=NONE guibg=NONE
endif

let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-tsserver', 'coc-yaml', 'coc-emmet']
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" --- KeyBindigns
nnoremap <silent><leader>1 :source % \| :PlugInstall<CR>
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
nmap <leader><space> :nohlsearch<cr>

nnoremap <C-p> :GFiles<Cr>
nnoremap <C-f> :Rg <Cr>
nnoremap <silent><leader>l :Buffers<CR>

" Remap keys for applying codeAction to the current line.
nmap <leader>do  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> K :call CocAction('doHover')<CR>

command! Q :q
command! W :w
cmap w!! w !sudo tee %


" --- AutoCommands
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup ANANDU
  autocmd!
   autocmd BufWritePre * :call TrimWhitespace()
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END
