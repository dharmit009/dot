return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		branch = "master",
		commit = "066fd6505377e3fd4aa219e61ce94c2b8bdb0b79",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"markdown",
					"markdown_inline",
					"typescript",
				},
				sync_install = true,
				auto_install = true,
				ignore_install = { "javascript" },
				highlight = {
					enable = true,
					disable = { "c", "rust" },
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
					additional_vim_regex_highlighting = false,
				},
			})
			vim.env.CFLAGS = (vim.env.CFLAGS or "") .. " -Wno-unused-value"
		end,
	},
}
