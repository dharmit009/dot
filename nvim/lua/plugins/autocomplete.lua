return {
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = false,
    priority = 100,
    dependencies = {
      "L3MON4D3/luaSnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
  },

  {
    "hrsh7th/nvim-cmp",
    config = function()
      local lspkind = require("lspkind")
      lspkind.init {}
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()
      cmp.setup({

        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'buffer' },
          { name = 'luasnip' },
        }),

        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),

        formatting = {
          format = require("lspkind").cmp_format({
            before = require("tailwind-tools.cmp").lspkind_format
          })
        }

      })
    end
  },
  {
    "L3MON4D3/luaSnip",
    config = function()
      local snip = require("luasnip")
      snip.config.set_config {
        history = false,
        updateevents = "TextChanged, TextChangedI",
      }
      vim.keymap.set({ "i", "s" }, "<c-k>", function()
        if snip.expand_or_jumpable() then
          snip.expand_or_jump()
        end
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<c-j>", function()
        if snip.jumpable(-1) then
          snip.expand_or_jump()
        end
      end, { silent = true })
    end

  },

  {

    "codota/tabnine-nvim",
    build = "powershell.exe -file .\\dl_binaries.ps1",
    config = function()
      local tabnine = require("tabnine")
      tabnine.setup({
        disable_auto_comment = true,
        accept_keymap = "<Tab>",
        dismiss_keymap = "<C-]>",
        debounce_ms = 800,
        suggestion_color = { gui = "#808080", cterm = 244 },
        exclude_filetypes = { "TelescopePrompt", "NvimTree" },
        log_file_path = nil,
        ignore_certificate_errors = false,
      })
    end

  },

}
