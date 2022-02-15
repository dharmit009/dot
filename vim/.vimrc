" General Settings ...
syntax on 
let mapleader = " "

" VIM Tweaks ...
set clipboard=unnamedplus
set icon 
set noshowmode
set nowrap
set number
set relativenumber
set ttyfast

" VIM tab and space management ...
set linebreak 
set nosmartindent
set nosmarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set textwidth=62

" Spell Settings ...
set spell spelllang=en_us
set spellfile="~/.vim/spell/en.utf-8.add"

" Highlighting settings ...
set incsearch 
set nohlsearch 
set nospell

"Plugin Manager ...
call plug#begin('~/.local/share/vim/plugins')
	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
	Plug 'junegunn/goyo.vim'
	Plug 'junegunn/limelight.vim'
	Plug 'junegunn/vim-emoji'
	Plug 'morhetz/gruvbox'
	Plug 'rwxrob/vim-pandoc-syntax-simple'
	Plug 'vim-pandoc/vim-pandoc'
call plug#end()

" Plugin Settings ...
" Gruvbox Plugin settings (morhetz/gruvbox) ...
let g:gruvbox_italic=1
set background=dark
colorscheme gruvbox

" Vim Emoji Plugin Settings for (junegunn/vim-emoji) ...
set completefunc=emoji#complete

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

" Disabling arrow keys within vim to improve my workflow ...
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

" Keyboard Remaps ...
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

" Starts Limelight whenever goyo is started ...
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
