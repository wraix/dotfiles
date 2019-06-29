function Init()
  :PlugInstall
  colorscheme solarized8_flat
endfunction

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
              \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd!
  autocmd VimEnter * call Init()
endif

call plug#begin('~/.config/nvim/plugged')
  Plug 'tpope/vim-fugitive'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'lifepillar/vim-solarized8'
  Plug 'StanAngeloff/php.vim', {'for': 'php'}
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'w0rp/ale'
  Plug 'scrooloose/nerdtree'
  Plug 'jeetsukumaran/vim-buffergator'
call plug#end()

set number
set number relativenumber
set visualbell
set showmatch
set hidden

set shiftwidth=2
set smartindent
set smarttab
set softtabstop=2
set expandtab
set list
set listchars=tab:>-,trail:*,extends:>,precedes:<

" enter visual mode when selecting text and dont copy line numbers
" set mouse+=a

set fileencoding=utf-8
set lazyredraw

silent !mkdir -p $HOME/.nvim/swapfiles/
silent !mkdir -p $HOME/.nvim/backups/
set directory=$HOME/.nvim/swapfiles//
set backupdir=$HOME/.nvim/backups

set nocompatible
filetype off

let g:airline#extensions#tabline#enabled=1
let g:airline_theme='solarized_flood'
let g:airline_theme='onedark'

let g:fzf_action = {
  \ 'ctrl-m': 'e',
  \ 'ctrl-t': 'tabedit',
  \ 'ctrl-h': 'botright split',
  \ 'ctrl-v': 'vertical botright split' }


filetype plugin indent on    " required

try
  colorscheme solarized8_flat
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry


nnoremap <C-p> :FZF<CR>
nnoremap <C-s> :w<CR>
tnoremap <Esc> <C-\><C-n>
map <C-l> :NERDTreeToggle<CR>
map <C-M-l> :NERDTreeFind<CR>

nnoremap <C-M> :bnext<CR>
nnoremap <C-N> :bprev<CR>
nnoremap <C-X> :bdelete<CR>

vnoremap // y/<C-R>"<CR>

command! -bang FLines call fzf#vim#grep(
     \ 'grep -vnITr --color=always --exclude-dir=".svn" --exclude-dir=".git" --exclude=tags --exclude=*\.pyc --exclude=*\.exe --exclude=*\.dll --exclude=*\.zip --exclude=*\.gz "^$"',
     \ 0,
     \ {'options': '--reverse --prompt "FLines> "'})

" autocmd BufWritePre * %s/\s\+$//e

" Remap for destroying trailing whitespace cleanly
:nnoremap <Leader>w :let _save_pos=getpos(".") <Bar>
  \ :let _s=@/ <Bar>
  \ :%s/\s\+$//e <Bar>
  \ :let @/=_s <Bar>
  \ :nohl <Bar>
  \ :call setpos('.', _save_pos)<Bar>
  \ :unlet _s<Bar>
  \ :unlet _save_pos<CR>

let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

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
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'php': ['phpcbf', 'php_cs_fixer', 'remove_trailing_lines', 'trim_whitespace'],
  \}
let g:ale_fix_on_save = 1
