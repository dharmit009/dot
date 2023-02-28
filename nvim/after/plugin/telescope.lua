local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

-- Custom global search using <leader>gs 
vim.keymap.set('n', '<leader>gs', function()
	builtin.grep_string({ search = vim.fn.input("GLOBAL SEARCH: ") });
end)
