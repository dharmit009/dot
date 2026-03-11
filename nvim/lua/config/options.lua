-- Vim Globals ...
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- Vim Options ...
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.breakindent = true
vim.o.wrap = false
vim.o.pumheight = 10
vim.o.pumblend = 15
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes:2"
vim.o.numberwidth = 3
vim.o.undofile = true
vim.o.updatetime = 250
-- vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.inccommand = "split"
vim.o.scrolloff = 999
vim.o.confirm = true
vim.o.autochdir = false
vim.o.ruler = true
vim.o.tabstop = 2
vim.o.shiftwidth = 4
vim.o.encoding = "utf-8"
vim.o.completeopt = "menu,menuone,noselect"

-- Clipboard Synching
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)
