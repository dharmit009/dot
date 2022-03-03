" General Settings ...
syntax enable
let mapleader = " "

" VIM IN-BUILT COMPLETION ...
" Chooses longest suggest by default & will even show up if there is
" only one suggestion...Keeps the function preview window on even after
" selecting so you could see the parameters
set completeopt=longest,menuone,preview

" Set Pop-Up menu height to 8
set pumheight=8

" Stuff not working properly as I Intend ...
set clipboard=unnamedplus

" VIM Tweaks ...
" set cursorcolumn
set autoread              " reloads the file if anything gets changed.
set cursorline
set emoji
set icon
set number
set omnifunc+=go#complete#Complete
set omnifunc=syntaxcomplete#Complete
set path+=**
set relativenumber
set scrolloff=998
set ttyfast
set wildmenu
set wildmode=full
set wrap
set noshowmode

" VIM Fold Methods ...
set foldmethod=manual
set nofoldenable

" VIM tab and space management ...
set expandtab

" set linebreak
set nosmartindent
set nosmarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set textwidth=72

" Swap and Backup Settings ...
set nobackup
set noswapfile
set nowritebackup

" Spell Settings ...
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
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'iamcco/markdown-preview.nvim', {'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    Plug 'morhetz/gruvbox'
    Plug 'rwxrob/vim-pandoc-syntax-simple'
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'dhruvasagar/vim-table-mode'
    Plug 'tpope/vim-surround'
  call plug#end()

  " Plugin Settings ...
  " Gruvbox Plugin settings (morhetz/gruvbox) ...
  colorscheme gruvbox
  let g:gruvbox_italic=1
  set background=dark

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

  endif
endif   "66 For more details or Check the comments before Plug begin

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

" Function key remaps ...
nnoremap <F1> :PlugInstall<CR>
nnoremap <F2> :PlugUpdate<CR>
nnoremap <F3> :PlugUpgrade<CR>
nnoremap <F5> :so $HOME/.vimrc<CR>
nnoremap <F12> :MarkdownPreviewToggle<CR>

" Leader Key Remaps ...
nnoremap <leader>df :Goyo <CR>
nnoremap <leader>e  :Vexplore<CR>
nnoremap <leader>qq :q<CR>

" QuickRun keymaps ...
nnoremap <leader>rpy :!python % <CR>
nnoremap <leader>rja :!javac % && java %:r<CR>
nnoremap <leader>rgo :!go run %<CR>

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

" Autocommands
autocmd filetype * inoremap <buffer> * *<C-x><C-o>
autocmd filetype go inoremap <buffer> . .<C-x><C-o>
autocmd BufWritePost *.md silent !toemo %

" Starts Limelight whenever goyo is started ...
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Omnifunc Completion ...
" This is an autocommand to invoke CTRL-X & CTRL-O for omnifunc
" completion whenever '.' is pressed in a go file.
" Set Up omni complete for each file type
if has("autocmd") && exists("+omnifunc")
autocmd Filetype *
    \	if &omnifunc == "" |
    \		setlocal omnifunc=syntaxcomplete#Complete |
    \	endif
endif

" VIM COLOR SETTINGS ...
" set relative number line color to darkyellow
highlight LineNRAbove ctermfg=DarkGreen cterm=bold
highlight LineNRBelow ctermfg=DarkBlue cterm=bold
highlight LineNR ctermfg=DarkYellow
highlight ColorColumn ctermbg=DarkMagenta
highlight Search ctermfg=DarkGreen ctermbg=Black

" Highlighting with matches ...
" Show the content in red whenever I exceed 72 characters.
highlight OverLength ctermbg=DarkRed ctermfg=white guibg=#FFD9D9
match OverLength /\%>72v.\+/
highlight ExtraWhitespace ctermbg=DarkRed guibg=DarkBlue
match ExtraWhitespace /\s\+$/

