" vim: fdm=marker

" Options - Appearance {{{
" ----------------------------------------------------------------------------

" Theme
set background=dark
let base16colorspace=256
let g:gruvbox_italic=1
colorscheme gruvbox 
let g:gruvbox_contrast_dark="soft"

" Syntax
syntax on

set cursorline             " Highlights current line
set colorcolumn=80         " Show right column in a highlighted colour.
set history=10000          " Number of commands and search patterns to remember.
set number                 " Precede each line with its line number.
set showcmd                " Show command on last line of screen.
set showmatch              " Show matching brackets.
set title                  " Set window title to 'filename [+=-] (path) - NVIM'.

"}}}
" Options - Indents and Tabs {{{
" -----------------------------------------------------------------------------

" Default indent and tab options.
set expandtab              " Replace tabs with spaces in Insert mode.
set shiftwidth=4           " Spaces for each (auto)indent.
set smarttab               " Insert and delete sw blanks in the front of a line.
set softtabstop=4          " Spaces for tabs when inserting <Tab> or <BS>.
set tabstop=4              " Spaces that a <Tab> in file counts for.

" Indent and tab options for specific file types.
autocmd FileType js,jsx,json,less,ruby,sass,scss,sql,vim,zsh setlocal shiftwidth=2 softtabstop=2 tabstop=2

"}}}
" Options - Searching {{{
" -----------------------------------------------------------------------------

set hlsearch               " Highlight search pattern results.
set ignorecase             " Ignore case of normal letters in a pattern.
set incsearch              " Highlight search pattern as it is typed.
set smartcase              " Override ignorecase if pattern contains upper case.

"}}}
" Options - Python {{{
" -----------------------------------------------------------------------------

let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

"}}}
" Mappings - General {{{
" -----------------------------------------------------------------------------

" Define <Leader> key.
let mapleader = ','

" Exit insert mode.
inoremap jj <esc>

" scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Switch colon with semi-colon.
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" copy and paste
set clipboard=unnamed
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa
vnoremap yy "+y

" Stop the highlighting for the current search results.
nnoremap <Space> :nohlsearch<CR>

" Navigate split windows.
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" Write current file as superuser.
cnoremap w!! w !sudo tee > /dev/null %


"}}}
" Plugins Install {{{
" ----------------------------------------------------------------------------

call plug#begin('~/.config/nvim/plugged')
Plug 'Shougo/deoplete.nvim'             " Asynchronous auto completion.
Plug 'morhetz/gruvbox'                  " Color scheme gruvbox
Plug 'sjl/gundo.vim'                    " Fancy Undo Screen
Plug 'junegunn/vim-easy-align'	    	  " Text alignment by characters.
Plug 'tpope/vim-surround'           	  " Quoting/parenthesizing made simple.
Plug 'scrooloose/nerdtree'	            " File Manager
Plug 'vim-airline/vim-airline'          " Pretty Statusline
Plug 'vim-airline/vim-airline-themes'   " Themes for Airline status bar
Plug 'scrooloose/syntastic'             " Syntax linter
Plug 'tpope/vim-surround'               " Surround code w/ parenthesis
Plug 'easymotion/vim-easymotion'        " navigate documents reallllly fast!
Plug 'benekastah/neomake'               " Asynchronous syntax checking with make.
Plug 'tpope/vim-commentary'             " Commenting made simple.
call plug#end()

"}}}
" Plugin Settings - easy-align {{{
" -----------------------------------------------------------------------------

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"}}}
" Plugin Settings - airline {{{
" -----------------------------------------------------------------------------

let g:airline_left_sep = ''        " Remove arrow symbols.
let g:airline_left_alt_sep = ''    " Remove arrow symbols.
let g:airline_right_sep = ''       " Remove arrow symbols.
let g:airline_right_alt_sep = ''   " Remove arrow symbols.
let g:airline_theme = 'gruvbox'    " Use current theme.
set laststatus=2

"}}}
" Plugin Settings - nerdtree {{{
" -----------------------------------------------------------------------------

nnoremap <Leader>f :NERDTreeToggle<Enter>
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

"}}}
" Plugin Settings - syntastic {{{

set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"}}}
" Plugin Settings - deoplete {{{
" -----------------------------------------------------------------------------

if exists('plugs') && has_key(plugs, 'deoplete.nvim')
  let g:deoplete#enable_at_startup = 1 " Enable deoplete on startup.
  let g:deoplete#enable_smart_case = 1 " Enable smart case.

  " Tab completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

  " On backspace, delete previous completion and regenerate popup.
  inoremap <expr><C-H> deoplete#mappings#smart_close_popup()."\<C-H>"
 " inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-H>"
endif

"}}}
" Plugin Settings - neomake {{{
" -----------------------------------------------------------------------------

" Use custom configuration file with ESLint:
" https://github.com/w0ng/dotfiles/blob/master/.eslintrc
let g:neomake_javascript_eslint_maker = {
      \ 'args': ['-c', '~/.eslintrc', '-f', 'compact'],
      \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
      \ '%W%f: line %l\, col %c\, Warning - %m'
      \ }

" Use PSR2 standard with PHP CodeSniffer.
let g:neomake_php_phpcs_args_standard = 'PSR2'

" Use custom rule set with PHP Mess Detector:
" https://github.com/w0ng/dotfiles/blob/master/.phpmd.xml
let g:neomake_php_phpmd_maker = {
      \ 'args': ['%:p', 'text', '~/.phpmd.xml'],
      \ 'errorformat': '%E%f:%l%\s%m'
      \ }

if exists('plugs') && has_key(plugs, 'neomake')
  if has('nvim')
    " Execute syntax checkers on file save.
    autocmd! BufWritePost * Neomake
  endif
endif

"}}}
" Plugin Settings - Gundo Undo {{{
" -----------------------------------------------------------------------------

nnoremap <leader>u :GundoToggle<CR>  " toggle gundo
"}}}
