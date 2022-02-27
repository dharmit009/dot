" General Settings ...
syntax on 
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
set emoji 
set omnifunc=syntaxcomplete#Complete
set omnifunc+=go#complete#Complete
set wildmenu
set wildmode=full

" VIM Tweaks ...
set icon 
set number
set relativenumber
set scrolloff=998
set showmode
set ttyfast
set wrap
set autoread              " reloads the file if anything gets changed.

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
set nohlsearch 

" SUPER IMPORTANT: ADDED FROM RWXROB
set viminfo='20,<1000,s1000

"Plugin Manager ...
" ONLY LOAD PLUGINS IF THE PLUGIN EXISTS ...
if filereadable(expand("~/.vim/autoload/plug.vim"))
  silent! if plug#begin()
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
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
  let g:gruvbox_italic=1
  set background=dark
  colorscheme gruvbox

  " Markdown Plugin Settings for (iamcco/markdown-preview.nvim) ...
  " let mkdp_auto_start = 1
  let mkdp_auto_close = 1
  let mkdp_auto_refresh = 0
  let g:mkdp_page_title = '${name}'
  let g:mkdp_filetypes = ['markdown']

  " Pandoc Plugin settings ...
  let g:pandoc#formatting#mode = 'h' 
  let g:pandoc#formatting#textwidth = 72
  let g:pandoc_preview_pdf_cmd = "evince"
  let g:limelight_conceal_ctermfg = 'gray'
  let g:limelight_conceal_ctermfg = 240

  endif
endif   " GO TO LINE 53 For more details or Check the comments before Plug begin

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
nnoremap <F5> :so%<CR>
nnoremap <F12> :MarkdownPreviewToggle<CR>

" Leader Key Remaps ...
nnoremap <leader>df :Goyo<CR>
nnoremap <leader>e  :Vexplore<CR>
nnoremap <leader>qq :q<CR>

" QuickRun keymaps ...
nnoremap <leader>py :!python % <CR>
nnoremap <leader>jv :!javac % && java %:r<CR>
nnoremap <leader>go :!go run %<CR>

" Starts Limelight whenever goyo is started ...
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" VIM COLOR SETTINGS ... 
" set relative number line color to darkyellow
highlight LineNR ctermfg=DarkYellow

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
au filetype go inoremap <buffer> . .<C-x><C-o>

autocmd BufWritePost *.md silent !toemo %
