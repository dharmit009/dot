-- ============================================================================
-- Telescope Fuzzy Finder Configuration (`lua/kickstart/plugins/telescope.lua`)
-- ============================================================================
local telescope_plugins = {
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' },
}

if vim.fn.executable 'make' == 1 then table.insert(telescope_plugins, { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' }) end

vim.pack.add(telescope_plugins)

local telescope_ok, telescope = pcall(require, 'telescope')
if telescope_ok then
  local actions = require 'telescope.actions'

  telescope.setup {
    defaults = {
      layout_strategy = 'bottom_pane',
      layout_config = {
        height = 0.45,
        prompt_position = 'top',
      },
      sorting_strategy = 'ascending',
      border = true,
      borderchars = {
        prompt = { '─', ' ', ' ', ' ', '─', '─', ' ', ' ' },
        results = { '─', ' ', ' ', ' ', '─', '─', ' ', ' ' },
        preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      },
      mappings = {
        i = {
          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
          ['<C-c>'] = actions.close,
          ['<Esc>'] = actions.close,
        },
      },
    },
    extensions = {
      ['ui-select'] = { require('telescope.themes').get_dropdown() },
    },
  }

  pcall(telescope.load_extension, 'fzf')
  pcall(telescope.load_extension, 'ui-select')

  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files Fuzzy' })
  vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'Find Word (Grep)' })
  vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find Open Buffers' })
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find Help Tags' })
  vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find Diagnostics' })
  vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config', follow = true } end, { desc = 'Search Neovim Files' })
end
