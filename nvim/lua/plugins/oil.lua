return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	lazy = false,
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			columns = {
				"icons",
			},
			delete_to_trash = true,
			view_options = {
				show_hidden = true,
			},
		})
	end,
}
