return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null = require('null-ls')
    sources = {

      -- Autocomplete ...
      null.builtins.completion.luasnip,
      null.builtins.completion.spell,

      -- LINTER / DIAGNOSTICS ...
      null.builtins.diagnostics.golangci_lint,
      null.builtins.diagnostics.markdownlint,
      null.builtins.diagnostics.selene,
      null.builtins.diagnostics.stylelint,

      -- FORMATTING ...
      null.builtins.formatting.black,
      null.builtins.formatting.isort,
      null.builtins.formatting.markdownlint,
      null.builtins.formatting.prettier,
      null.builtins.formatting.stylua,
      null.builtins.formatting.gofmt,
      null.builtins.formatting.sql_formatter,

      -- HOVER ...
      null.builtins.hover.dictionary

    }
    vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, { desc = "[G]lobal [F]ormat" })
  end
}
