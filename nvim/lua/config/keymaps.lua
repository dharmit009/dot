-- Files and Folders Exploring keymaps
vim.keymap.set("n", "<space>e", ":Oil<CR>", { desc = "[E]xplorer]" })
vim.keymap.set("n", "<space>xl", ":.lua<CR>", { desc = "[E]xecute [L]ua Code" })
vim.keymap.set("v", "<space>xl", ":lua<CR>", { desc = "[E]xecute [L]ua Code Block" })
vim.keymap.set("v", "<space>ll", ":VimtexCompile<CR>", { desc = "[E]xecute [L]ua Code Block" })
vim.keymap.set("v", "<space>ls", ":VimtexStop<CR>", { desc = "[E]xecute [L]ua Code Block" })

-- Quickfix list cprev and cnext
vim.keymap.set("n", "<A-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<A-k>", "<cmd>cprev<CR>")

-- Vim diagnostics keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "<space>st", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 12)
end)

vim.keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<CR>")
vim.keymap.set("n", "<leader>wc", "<cmd>VimtextCountWords<CR>")

vim.keymap.set("n", "<leader>lt", function()
	require("live-server-nvim").toggle()
end)
