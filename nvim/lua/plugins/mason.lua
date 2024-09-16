return {
  -- Mason configuration ...
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  -- Mason lsp config ...
  {

    "williamboman/mason-lspconfig.nvim",
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'gopls', 'html', 'grammarly', 'marksman', 'pyright' },
        automatic_installation = true,
        handlers = nil,
      })
    end

  },

  {

    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      lspconfig.gopls.setup({ capabilities = capabilities })
      lspconfig.grammarly.setup({ capabilities = capabilities })
      lspconfig.html.setup({ capabilities = capabilities })
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.marksman.setup({ capabilities = capabilities })
      lspconfig.pyright.setup({ capabilities = capabilities })
      lspconfig.stylelint_lsp.setup({ capabilities = capabilities })
      lspconfig.svelte.setup({ capabilities = capabilities })
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango",
          "edge", "eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "gohtmltmpl", "haml", "handlebars", "hbs",
          "html", "htmlangular", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk",
          "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss",
          "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte",
          "templ" },
        {
          tailwindCSS = {
            classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
            includeLanguages = {
              eelixir = "html-eex",
              eruby = "erb",
              htmlangular = "html",
              templ = "html"
            },
            lint = {
              cssConflict = "warning",
              invalidApply = "error",
              invalidConfigPath = "error",
              invalidScreen = "error",
              invalidTailwindDirective = "error",
              invalidVariant = "error",
              recommendedVariantOrder = "warning"
            },
            validate = true
          }
        }
      })

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "shift+[K] for [M]an page" })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
    end

  },

  {
    "mfussenegger/nvim-dap",
  },

  {
    "mfussenegger/nvim-lint",
  },

  {
    "mhartington/formatter.nvim",
  },
}
