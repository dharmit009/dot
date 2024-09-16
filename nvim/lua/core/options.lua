local o = vim.opt

-- Autocomplete Settings ...
o.completeopt = {"menu", "menuone", "noinsert"}
o.wildmenu = true
o.wildmode = "full"

-- option settings ...
o.autoread = true
o.icon = true
o.ttyfast = true
o.showmode = false
o.number = true
o.relativenumber = true
o.paste = false
o.incsearch = false
o.magic = true
o.ignorecase = true
o.smartcase = true
o.tagstack = true -- enables :tag command
o.showfulltag = true
o.scrolloff = 999
o.wrap = false
o.breakindent=true
o.list=true
o.numberwidth = 5
o.conceallevel = 2
o.background="dark"
o.syntax="on"
o.cursorcolumn=true
o.cursorline=true
o.cursorlineopt="both"
o.colorcolumn="72"
o.spell=true
o.spelllang="en"
o.spellsuggest="best"
o.equalalways=true -- makes all windows the same size when adding or removing.
o.eadirection="both" -- make both horizontal and vertical direction equal.
o.tabpagemax=6
o.mousefocus=false
o.errorbells=false
o.belloff="all"
o.helplang="en"
o.clipboard="unnamedplus"
o.undofile=true
o.textwidth=80

-- Autocomplete Section [IMPORTANT] --
o.complete   = ".,w,b,u,t"
o.completeopt="menu,preview"
o.pumheight = 8 -- Popup height
o.pumwidth  = 40 -- Popup width

-- Brackets Settings ... [Annoying] ...
o.showmatch = true
o.matchtime = 2 -- tenth of a second to show a match for brackets
o.matchpairs="(:),{:},[:],<:>"

-- tab and space management 
o.expandtab = true
o.linebreak = true --linebreak and breakat work together
o.smartindent = true
o.smarttab = true

o.shiftwidth = 4
o.softtabstop=4
o.tabstop = 4
o.vartabstop = "0"
o.varsofttabstop = "0"

o.shiftround=true
o.autoindent = false
o.copyindent = true
o.foldenable = false
o.swapfile = false
o.exrc = true
o.emoji = true
o.signcolumn="auto"
o.list = true
o.listchars = {tab='» ', trail='·'}
o.ruler = false

-- Backup Management ...
o.backup = false
o.writebackup = false


---- WORK ON LATER SECTION ----
-- o.brk='/\ /\	!@*-+;:,./?'
-- o.sbr='←'
-- o.fillchars=
-- o.listchars="tab:\\»,space: "
-- o.tabline=""
-- o.showtabline=2
-- o.rulerformat=""
-- o.completefunc = ""
-- o.breakat="72"
