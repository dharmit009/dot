return {
	"lervag/vimtex",
	lazy = false,
	tag = "v2.15",
	config = function()
		vim.g.vimtex_view_method = "mupdf"
		vim.g.vimtex_view_general_viewer = "mupdf"
		vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
		vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
		message = "%! TeX root = ./main.tex"
		-- print(message)
	end,
}
