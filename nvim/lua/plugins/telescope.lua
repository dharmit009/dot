return {
	'nvim-telescope/telescope.nvim',
	version = '*',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	},
	config = function()
		require('telescope').setup {
			pickers = {
				find_files = {
					theme = 'dropdown'
				}
			}
		}
		extensions = {
			fzf = {}
		}
		require('telescope').load_extension('fzf');
		vim.keymap.set('n', '<space>fg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' });
		vim.keymap.set("n", "<space>ff", require('telescope.builtin').find_files);
		vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags);

		vim.keymap.set("n", "<space>fn", function()
			local opts = require('telescope.themes').get_dropdown({
				cwd = vim.fn.stdpath("config"),
			})
			require('telescope.builtin').find_files(opts)
		end)

		vim.keymap.set("n", "<space>fp", function()
			require('telescope.builtin').find_files {
				cwd = vim.fs.joinpath(vim.fn.stdpath('data'), "lazy")
			}
		end)
	end
}
