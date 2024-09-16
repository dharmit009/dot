return {
  "fatih/vim-go",
  "dhruvasagar/vim-table-mode",
  {
    "ThePrimeagen/vim-be-good",
  },

  {
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
      "neovim/nvim-lspconfig",       -- optional
    },
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
  }

}
