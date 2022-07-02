" General Settings ...
syntax enable
let mapleader=" "

" VIM IN-BUILT COMPLETION ...
" Chooses longest suggest by default & will even show up if there is
" only one suggestion...Keeps the function preview window on even after
" selecting so you could see the parameters
" set completeopt=longest

" Set Pop-Up menu height to 8
set pumheight=100

" Stuff not working properly as I Intend ...
set clipboard+=unnamedplus

" VIM Tweaks ...
set cursorcolumn
set path+=**
set autoread              " reloads the file if anything gets changed.
set cursorline
set emoji
set icon
set number
set relativenumber
set scrolloff=998
set ttyfast
set noruler
" set wildmenu
" set wildmode=full
set nowrap
set noshowmode
set signcolumn=yes
set hidden
set mousemodel=popup

" VIM Fold Methods ...
set foldmethod=manual
set nofoldenable

" VIM tab and space management ...
set expandtab

" set linebreak
set smartindent
set nosmarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set textwidth=72

" Swap and Backup Settings ...
set nobackup
set noswapfile
set nowritebackup
set undodir=~/.vim/undodir
set undofile

" Spell Settings ...
set encoding=utf-8
set spell
set spell spelllang=en_us
set spellfile="~/.vim/spell/en.utf-8.add"

" Highlighting settings ...
set incsearch

" SUPER IMPORTANT: ADDED FROM RWXROB
set viminfo='20,<1000,s1000

"Plugin Manager ...
" ONLY LOAD PLUGINS IF THE PLUGIN EXISTS ...
if filereadable(expand("~/.vim/autoload/plug.vim"))
  silent! if plug#begin()
    Plug 'dhruvasagar/vim-table-mode'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'frazrepo/vim-rainbow'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    Plug 'morhetz/gruvbox'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'rwxrob/vim-pandoc-syntax-simple'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'neoclide/coc-tabnine'
    " Plug 'vim-airline/vim-airline'
    " Plug 'mrk21/yaml-vim'
  call plug#end()

  " Plugin Settings ...

  " Gruvbox Plugin settings (morhetz/gruvbox) ...
  let g:gruvbox_italic='1'
  let g:gruvbox_bold='1'
  let g:gruvbox_underline='1'
  let g:gruvbox_undercurl='1'
  let g:gruvbox_contrast_dark="medium"
  let g:gruvbox_termcolors='256'
  " let g:gruvbox_improved_strings=1
  let g:gruvbox_improved_warnings='1'
  set background=dark
  colorscheme gruvbox

  " Markdown Plugin Settings for (iamcco/markdown-preview.nvim) ...
  " let mkdp_auto_start = 1
  let g:mkdp_filetypes = ['markdown']
  let g:mkdp_page_title = '${name}'
  let mkdp_auto_close = 1
  let mkdp_auto_refresh = 0

  " Pandoc Plugin settings ...
  let g:limelight_conceal_ctermfg = 'gray'
  let g:limelight_conceal_ctermfg = 240
  let g:pandoc#formatting#mode = 'h'
  let g:pandoc#formatting#textwidth = 72
  let g:pandoc_preview_pdf_cmd = "evince"

  " Airline
  " let g:airline#extensions#default#layout = [
  "     \ [ 'a', 'b', 'c' ],
  "     \ [ 'x', 'y' ]
  "     \ ]
  " let g:airline#extensions#tabline#enabled = 1
  " let g:airline#extensions#tabline#left_alt_sep = ''
  " let g:airline#extensions#tabline#left_sep = ''
  " let g:airline#extensions#tabline#show_buffers = 1
  " let g:airline_detect_spell=0
  " let g:airline_detect_spelllang=0
  " let g:airline_left_alt_sep = ''
  " let g:airline_left_sep = ''
  " let g:airline_powerline_fonts = 0
  " let g:airline_right_alt_sep = ''
  " let g:airline_right_sep = ''

  endif
endif   "66 For more details or Check the comments before Plug begin

" vim rainbow ...
let g:rainbow_active = 1

" Prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

" Keyboard Remaps ...
" mapping 'shift + y' to copy till end of line.
map Y y$

" Disabling arrows in normal mode ...
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" Disabling arrows in insert mode ...
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Function keys remaps ...
nnoremap <F1> :PlugUpgrade<CR>
nnoremap <F2> :PlugClean<CR>
nnoremap <F3> :PlugInstall<CR>
nnoremap <F4> :PlugUpdate<CR>

nnoremap <F5>  :so $HOME/.vimrc<CR>
nnoremap <F6> :set nospell <CR>
nnoremap <F10> :set relativenumber! number! showmode! showcmd! hidden! signcolumn=no<CR>
nnoremap <F12> :MarkdownPreviewToggle<CR>

" Leader Key Remaps ...
nnoremap <leader>df :Goyo <CR>
nnoremap <leader>e  :Vexplore<CR>
nnoremap <leader>qq :q<CR>

" QuickRun keymaps ...
nnoremap <leader>rpy :!python % <CR>
nnoremap <leader>rja :!javac % && java %:r<CR>
nnoremap <leader>rgo :!go run %<CR>
nnoremap <leader>rsh :!bash %<CR>

" Presentation Settings ...
" nnoremap <F10> :set relativenumber! number! showmode! showcmd! hidden! signcolumn=no<CR>

" Sliding effect using buffers ...

" ascii art font ...
nmap <leader>d :.!toilet -w 300 <CR>
nmap <leader>D :.!toilet -w 300 -f small<CR>

" ascii box border ...
nmap <leader>1 :.!toilet -w 300 -f term -F border<CR>

" .vpm --> vim presentation mode ...
" autocmd BufNewFile,BufRead *.vpm call SetVimPresentationMode()
" function SetVimPresentationMode()
"     nnoremap <Left> :silent bp<CR> :redraw!<CR>
"     nnoremap <Right> :silent bn<CR> :redraw!<CR>
" endfunction

" VIM FUNCTIONS ...
" Orielly Conf hlsearch blinking function ...
" Damian's config.
" shows a 0.1 second blink while doing search for next
function! HLNext (blinktime)
	let [bufnum, lnum, col, off] = getpos('.')
	let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
	let target_pat = '\c\%#'.@/
	let ring = matchadd('ErrorMsg', target_pat, 101)
	redraw
	exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
	call matchdelete(ring)
	redraw
endfunction

" Calling the above function with remap.
nnoremap <silent> n n:call HLNext(0.075)<cr>
nnoremap <silent> N N:call HLNext(0.075)<cr>

" Omnifunc Completion ...
" This is an autocommand to invoke CTRL-X & CTRL-O for omnifunc
" completion whenever '.' is pressed in a go file.
"" Set Up omni complete for each file type
"if has("autocmd") && exists("+omnifunc")
"autocmd Filetype *
"    \	if &omnifunc == "" |
"    \   setlocal omnifunc+=go#complete#Complete   |
"    \   setlocal omnifunc+=py#complete#Complete   |
"    \   setlocal omnifunc+=syntaxcomplete#Complete|
"    \	endif
"endif
"
" Autocommands
" autocmd filetype ** inoremap <buffer> * *<C-x><C-o>
autocmd filetype go inoremap <buffer> . .<C-x><C-o>
autocmd filetype py inoremap <buffer> . .<C-x><C-o>
autocmd BufWritePost *.md silent !toemo %

" Starts Limelight whenever goyo is started ...
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Autocommand to trim white spaces ...
" This is the function to remove extra spaces ...
fun! TrimWhiteSpace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" Creating auto group named as damns which will call the function all my
" user defined functions and remove legacy functions which are running
" in bg.
augroup DAMNS
    autocmd!
    autocmd BufWritePre * :call TrimWhiteSpace()
augroup end

" VIM COLOR SETTINGS ...
" set relative number line color to darkyellow
highlight LineNRAbove ctermfg=DarkMagenta cterm=bold
highlight LineNRBelow ctermfg=DarkBlue cterm=bold
highlight LineNR ctermfg=DarkYellow cterm=bold
highlight ColorColumn ctermbg=DarkMagenta
highlight Search ctermfg=DarkGreen ctermbg=Black
highlight link pythonFunction GruvboxDarkRedBold

" Highlighting with matches ...
" Show the content in red whenever I exceed 72 characters.
highlight OverLength ctermbg=DarkRed ctermfg=white guibg=#FFD9D9
match OverLength /\%>72v.\+/
highlight ExtraWhitespace ctermbg=DarkRed guibg=DarkBlue
highlight ExtraWhitespace ctermbg=DarkGreen guibg=DarkBlue
match ExtraWhitespace /\s\+$/

hi Normal guibg=NONE ctermbg=NONE

" Use a line cursor within insert mode and a block cursor everywhere else.
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).

let &t_SI = "\e[5 q"
let &t_SR = "\e[3 q"
let &t_EI = "\e[1 q"

" testing go completion
let g:completor_filetype_map = {}
let g:completor_filetype_map.go = {'ft': 'lsp', 'cmd': 'gopls -remote=auto'}"
