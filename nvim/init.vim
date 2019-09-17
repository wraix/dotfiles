function! Init()
  :PlugInstall
  colorscheme solarized8
endfunction

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
              \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd!
  autocmd VimEnter * call Init()
endif

if has('nvim')
  call plug#begin('~/.config/nvim/plugged')
else
  call plug#begin('~/.vim/bundle')
endif
  " Git for vim, :G... to use
  Plug 'tpope/vim-fugitive'
  " Quick surrounding with eg. ys<motion> (remember with 'you surround')
  Plug 'tpope/vim-surround'
  " Enables repeat for some plugins
  Plug 'tpope/vim-repeat'
  " Comments
  Plug 'scrooloose/nerdcommenter'
  " Better status bar
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " Color scheme
  Plug 'lifepillar/vim-solarized8'
  " Better PHP colors
  Plug 'StanAngeloff/php.vim', {'for': 'php'}
  " Show colors in css
  Plug 'ap/vim-css-color'
  " install fzf for quick find and open files
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  " Vim plugin for fzf
  Plug 'junegunn/fzf.vim'
  " Async linter
  Plug 'w0rp/ale'
  " Directory explorer
  Plug 'scrooloose/nerdtree'
  " Easier buffer handling <leader>b
  Plug 'jeetsukumaran/vim-buffergator'
  Plug 'moll/vim-bbye'
  " Show git changes in gutter
  Plug 'airblade/vim-gitgutter'
  " Faster moving in files <leader><leader>w|b
  Plug 'easymotion/vim-easymotion'
  " Better clipboard handling
  Plug 'svermeulen/vim-easyclip'
  " Enables filecontrols directly within vim; :Move, :Delete, :Rename, etc.
  Plug 'tpope/vim-eunuch'
  " Split one-liners into blocks and other way around; gS (split) and gJ (join)
  Plug 'andrewradev/splitjoin.vim'
  " Align with ga
  Plug 'junegunn/vim-easy-align'
  " More targets to make actions on; eg. inq (in quotes), seperators (special
  " chars), inb (in blocks (, [, {, etc.)
  Plug 'wellle/targets.vim'
call plug#end()

"--------------------------
"|      Initialize        |
"--------------------------

let mapleader = ","

silent !mkdir -p $HOME/.nvim/{swapfiles,backups}
" Make an undo directory if it does not exist
if !isdirectory($HOME . "/.config/nvim/undo")
  call mkdir($HOME . "/.config/nvim/undo", "p")
endif

"--------------------------
"|      Color scheme      |
"--------------------------

syntax enable
set background=dark
if has('termguicolors')
  set termguicolors
endif

try
  let g:solarized_visibility="nowmal"
  let g:solarized_diffmode="normal"
  let g:solarized_termtrans=0
  let g:solarized_statusline="normal"
  let g:solarized_italics=1
  let g:solarized_old_cursor_style=0
  let g:solarized_use16=0
  let g:solarized_extra_hi_groups=1
  colorscheme solarized8
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry

let g:airline#extensions#tabline#enabled=1
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1

filetype indent on    " Use filetype indentation
filetype plugin indent on " Allow plugins to use filetype indentation



"--------------------------
"|        Settings        |
"--------------------------

set directory=$HOME/.nvim/swapfiles//
set backupdir=$HOME/.nvim/backups
set undodir=~/.config/nvim/undo " Set the undo directory
set undofile                    " Turn on persistent undo
set undoreload=10000
set backspace=indent,eol,start  " Make backspace behave in a sane manner.
set number
set number relativenumber
set visualbell
set showmatch
set hidden
set noshowmode
set clipboard=unnamed
set nocompatible
set shiftwidth=2
set smartindent
set autoindent        " Use autoindentation
set smarttab
set softtabstop=2
set expandtab         " Use spaces instead of tabs
set list
set listchars=tab:>-,trail:*,extends:>,precedes:<
set fileencoding=utf-8
set lazyredraw
set showmatch         " Show matching braces
set showcmd           " display incomplete commands
set ignorecase        " Ignore case on searches
set smartcase         " Use case sensitive search if there is a capital letter in the search
set undolevels=1000   " Set the number of undos that are remembered
set splitbelow        " Make horizontal splits below instead of above
set splitright        " Make vertical splits on the right
set scrolloff=3       " Start scrolling when the cursor is 3 lines away from the bottom of the window
set cursorline        " Highlight the current line
set autoread          " Automatically reload the file when it is changed from an outside program

" enter visual mode when selecting text and dont copy line numbers
" set mouse+=a

"--------------------------
"|    Plugin settings     |
"--------------------------
command! -bang FLines call fzf#vim#grep(
     \ 'grep -vnITr --color=always --exclude-dir=".svn" --exclude-dir=".git" --exclude=tags --exclude=*\.pyc --exclude=*\.exe --exclude=*\.dll --exclude=*\.zip --exclude=*\.gz "^$"',
     \ 0,
     \ {'options': '--reverse --prompt "FLines> "'})

" autocmd BufWritePre * %s/\s\+$//e

let g:fzf_action = {
  \ 'ctrl-m': 'e',
  \ 'ctrl-t': 'tabedit',
  \ 'ctrl-h': 'botright split',
  \ 'ctrl-v': 'vertical botright split' }

" let g:NERDTreeDirArrowExpandable = '+'
" let g:NERDTreeDirArrowCollapsible = '-'

" disable linting while typing
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_open_list = 1
let g:ale_keep_list_window_open=0
let g:ale_set_quickfix=0
let g:ale_list_window_size = 5
let g:ale_php_phpcbf_standard='PSR2'
let g:ale_php_phpcs_standard='phpcs.xml.dist'
let g:ale_php_phpmd_ruleset='phpmd.xml'
let g:ale_fix_on_save = 1
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }

"--------------------------
"|        Mappings        |
"--------------------------

command! WQ wq
command! Wq wq
command! W w
command! Q q
tnoremap <Esc> <C-\><C-n>
map <C-l> :NERDTreeToggle<CR>
map <C-M-l> :NERDTreeFind<CR>

nnoremap <C-p> :FZF<CR>
nnoremap <C-M-p> :FLines<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-M> :bnext<CR>
nnoremap <C-N> :bprev<CR>
nnoremap <leader>x :bdelete<CR>
nnoremap * :keepjumps normal! mi*`i<CR>
vnoremap // y/<C-R>"<CR>

" nnoremap <up> <C-w>k
" nnoremap <down> <C-w>j
" nnoremap <left> <C-w>h
" nnoremap <right> <C-w>l

" Remap ctrl-c to esc
inoremap <C-c> <Esc>
nnoremap <C-c> <Esc>

" Remap j and k to operate on visual lines
nnoremap j gj
nnoremap k gk
