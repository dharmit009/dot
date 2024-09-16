# Understanding Neovim Configuration ...

To configure neovim you need to have an `init.lua` or `init.vim` file in your configuration folder.

**For Linux:**

> /home/<Username>/.config/nvim

**For Windows:**

> C:\Users\<Username>\Appdata\Local\nvim\init.lua
    or 
> C:\Users\<Username>\Appdata\Local\nvim\init.vim

## The Tree Structure For Neovim Config: 

> C:.
> +---lua            -- The main lua folder
>    +---config      -- Configuration for: Lazy Package Manager is done here.
>    +---core        -- Configuration for: options.lua and windowUI are saved here.
>    +---plugins     -- Configuration for: Plugins are carried out here.

## Vim Option Property:

Neovim consist of almost 350+ options (version 0.7). The general syntax for configuring this options looks as follows:

> vim.opt.optionName = value

Here are the [list of options][1] which you configure. You can also view a list of options within nvim using `: option-list` 

```lua
vim.opt.number = true,
vim.opt.mouse = false,
vim.opt.ignorecase = true,
vim.opt.smartcase = true,
vim.opt.hlsearch = false,
vim.opt.wrap = true,
vim.opt.breakindent = true,
vim.opt.tabstop = 2,
vim.opt.shiftwidth = 2,
vim.opt.expandtab = true,

```
Let us shorten the `vim.opt.optionName` by using lua variables:

```lua

local o = vim.opt

o.undofile = true
o.backup = false
o.writebackup = false 
o.shiftwidth = 2
o.autoindent = true
o.breakindent = true
o.copyindent = true
o.expandtab = true
o.smartindent = true
o.number = true

```

# Keybindings:

To learn about Neovim keybindings we need to learn more about `vim.keymap.set`. Here is the basic syntax for how to create keymaps in neovim:

> vim.keymap.set({mode}, {lhs}, {rhs}, {opts})

Before we start remapping or creating new keybindings first let us see how many modes do we have in neovim:

* n: Normal Mode.
* i: Insert Mode.
* x: Visual Mode.
* s: Selection Mode.
* v: Visual + Selection.
* t: Terminal Mode.
* o: Operator-pending.
* '': Yes, an empty string is equivalent of n + v + o.

Let us see an example: 

> vim.keymap.set('n', '<space>w', '<cmd>write<cr>', {desc = 'Save'});


**Reference Links:**

[1]: <"https://neovim.io/doc/user/quickref.html#option-list"> "List Of Options"
