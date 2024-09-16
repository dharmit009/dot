-- Make sure to setup `mapleader` and `maplocalleader` before
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local set = vim.keymap.set
local map = vim.api.nvim_set_keymap

-- Restoring visual block mode ... [windows issues]
vim.cmd('nnoremap <A-v> <C-v>')

-- Custom keymaps ...
set('i', '<A-l>', '<ESC>lli', {desc = 'Quick one character right move using alt and motion'})
set('i', '<A-h>', '<ESC>i', {desc = 'Qset("q", "<c-v>")set("q", "<c-v>")uick one character left move using alt and motion'})

-- Normal mode ...
set('n', '<ESC>', '<cmd>nohlsearch<CR>', {desc = 'Remove highlights from search when ESC is used'})

-- Diagnostic keymaps ...
set('n', '[d', vim.diagnostic.goto_prev, {desc='Go to previous Diagnostic message'})
set('n', ']d', vim.diagnostic.goto_next, {desc='Go to previous Diagnostic message'})
set('n', '<leader>n', '<cmd>Neotree toggle<CR>')

-- Visual Mode Moving line shortcut ...
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- Table Mode ...
set("n", "<Space>tm", "<cmd>TableModeToggle<CR>")

-- LSP Shortcuts ...
set('n', 'K', vim.lsp.buf.hover, { desc = "shift+[K] for [M]an page" })
set('n', 'gd', vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })

