-- ============================================================================
-- Modern High-Performance Autocomplete (`cmp.lua`)
-- Powered by `blink.cmp`, Mason, LSP, Conform, and Lint
-- ============================================================================

-- 1. Unified Package Declarations (Native vim.pack)
vim.pack.add {
  -- Autocomplete Engine
  { src = 'https://github.com/saghen/blink.cmp', version = 'v0.*' },
  { src = 'https://github.com/L3MON4D3/LuaSnip', version = 'v2.*' },

  -- Tag Autoclosing & Auto-Renaming
  { src = 'https://github.com/windwp/nvim-ts-autotag' },
  { src = 'https://github.com/windwp/nvim-autopairs' },

  -- LSP & Mason Ecosystem
  { src = 'https://github.com/williamboman/mason.nvim' },
  { src = 'https://github.com/williamboman/mason-lspconfig.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },

  -- Formatting & Linting
  { src = 'https://github.com/stevearc/conform.nvim' },
  { src = 'https://github.com/mfussenegger/nvim-lint' },

  -- Debugging Adapter Protocol (DAP)
  { src = 'https://github.com/mfussenegger/nvim-dap' },
  { src = 'https://github.com/rcarriga/nvim-dap-ui' },
  { src = 'https://github.com/nvim-neotest/nvim-nio' },
  { src = 'https://github.com/jay-babu/mason-nvim-dap.nvim' },
}

-- 2. Environment & Compiler Flag Safety (Arch/CachyOS -Werror Fix)
vim.env.CFLAGS = '-Wno-error=sign-compare -Wno-error=implicit-fallthrough -Wno-error=unused-value'

-- 3. Tag Management & Autopairs
require('nvim-ts-autotag').setup {
  opts = { enable_close = true, enable_rename = true, enable_close_on_slash = true },
}

local autopairs_ok, autopairs = pcall(require, 'nvim-autopairs')
if autopairs_ok then autopairs.setup {} end

-- 4. Snippet Engine Loader
local luasnip_ok, luasnip = pcall(require, 'luasnip')
if luasnip_ok then luasnip.config.setup {
  history = true,
  update_events = 'TextChanged,TextChangedI',
} end

-- ============================================================================
-- 5. blink.cmp Configuration (Styled Borders, Right-Side Docs, Instant Auto-Show)
-- ============================================================================
local blink_ok = pcall(require, 'blink.cmp')
if blink_ok then
  require('blink.cmp').setup {
    keymap = {
      preset = 'default',
      ['<CR>'] = { 'accept', 'fallback' },
      ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    },
    appearance = {
      nerd_font_variant = 'mono',
    },
    completion = {
      trigger = {
        show_on_keyword = true,
        show_on_insert_on_trigger_character = true,
      },
      -- Explicit Menu Border & Kanagawa Styling
      menu = {
        border = 'rounded',
        winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
        draw = {
          columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
        },
      },
      -- Explicit Documentation Border, Instant Pop, & Right-Side Bias
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
        window = {
          border = 'rounded',
          winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
          -- Forces preferred window sizing and layout behavior
          max_width = 50,
          max_height = 20,
        },
      },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lsp = {
          name = 'LSP',
          score_offset = 100, -- Prioritizes language server documentation payload
        },
      },
    },
    snippets = { preset = 'luasnip' },
    fuzzy = { implementation = 'lua' },
    signature = {
      enabled = true,
      window = {
        border = 'rounded',
        winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
      },
    },
  }

  -- Re-link autopairs completion confirm behavior for blink.cmp
  local cmp_autopairs_ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.blink')
  if cmp_autopairs_ok then cmp_autopairs.setup() end
end
-- ============================================================================
-- 6. Mason & Native LSP Provisioning with Blink Capabilities Handshake
-- ============================================================================
local mason_ok, mason = pcall(require, 'mason')
local mason_lsp_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')

if mason_ok and mason_lsp_ok then
  mason.setup()
  mason_lspconfig.setup {
    ensure_installed = { 'lua_ls', 'cssls', 'ts_ls', 'tailwindcss', 'jsonls' },
    automatic_installation = true,
  }

  -- CRITICAL: Grab blink capabilities so LSPs return documentation payloads
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local blink_capabilities_ok, blink_cmp = pcall(require, 'blink.cmp')
  if blink_capabilities_ok then capabilities = blink_cmp.get_lsp_capabilities(capabilities) end

  vim.lsp.config('*', { capabilities = capabilities })

  -- Strict routing for ts_ls (React components, auto-imports & docs)
  vim.lsp.config('ts_ls', {
    capabilities = capabilities,
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    init_options = {
      hostInfo = 'neovim',
      preferences = {
        includeCompletionsForModuleExports = true,
        includeCompletionsForImportStatements = true,
      },
    },
  })
  vim.lsp.enable 'ts_ls'

  -- Tailwind CSS Server setup for React class autocompletion
  vim.lsp.config('tailwindcss', {
    capabilities = capabilities,
    filetypes = {
      'aspnetcorerazor',
      'astro',
      'astro-markdown',
      'blade',
      'clojure',
      'css',
      'less',
      'postcss',
      'sass',
      'scss',
      'stylus',
      'sugarss',
      'javascript',
      'javascriptreact',
      'reason',
      'rescript',
      'html',
      'htmldjango',
      'svelte',
      'vue',
      'vue-html',
      'typescript',
      'typescriptreact',
    },
  })
  vim.lsp.enable 'tailwindcss'
end

-- ============================================================================
-- 6. Mason & Modern Native LSP Provisioning (Strict Routing for React)
-- ============================================================================
local mason_ok, mason = pcall(require, 'mason')
local mason_lsp_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')

if mason_ok and mason_lsp_ok then
  mason.setup()
  mason_lspconfig.setup {
    ensure_installed = { 'lua_ls', 'cssls', 'ts_ls', 'tailwindcss', 'jsonls' },
    automatic_installation = true,
  }

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local blink_capabilities_ok, blink_cmp = pcall(require, 'blink.cmp')
  if blink_capabilities_ok then capabilities = blink_cmp.get_lsp_capabilities(capabilities) end

  vim.lsp.config('*', { capabilities = capabilities })

  vim.lsp.config('ts_ls', {
    capabilities = capabilities,
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    init_options = { hostInfo = 'neovim' },
  })
  vim.lsp.enable 'ts_ls'
end

-- ============================================================================
-- 7. Formatting (`conform.nvim`) - Format on Save
-- ============================================================================
local conform_ok, conform = pcall(require, 'conform')
if conform_ok then
  conform.setup {
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescriptreact = { 'prettier' },
      html = { 'prettier' },
      css = { 'prettier' },
      json = { 'prettier' },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  }
end

-- ============================================================================
-- 8. Linting (`nvim-lint`) - Safe Guarded
-- ============================================================================
local lint_ok, lint = pcall(require, 'lint')
if lint_ok then
  lint.linters_by_ft = {
    javascript = { 'eslint_d' },
    typescript = { 'eslint_d' },
    javascriptreact = { 'eslint_d' },
    typescriptreact = { 'eslint_d' },
  }

  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
    callback = function()
      local names = lint._resolve_linter_by_ft(vim.bo.filetype)
      if #names > 0 then lint.try_lint() end
    end,
  })
end

-- ============================================================================
-- 9. Debugging (DAP + UI + Mason Integration)
-- ============================================================================
local dap_ok, dap = pcall(require, 'dap')
local dapui_ok, dapui = pcall(require, 'dapui')
local mason_dap_ok, mason_dap = pcall(require, 'mason-nvim-dap')

if dap_ok and dapui_ok and mason_dap_ok then
  dapui.setup()
  mason_dap.setup {
    ensure_installed = { 'js' },
    automatic_installation = true,
  }

  dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
  dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
  dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end

  vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = 'DAP Continue' })
  vim.keymap.set('n', '<F9>', function() dap.toggle_breakpoint() end, { desc = 'DAP Toggle Breakpoint' })
  vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = 'DAP Step Over' })
  vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = 'DAP Step Into' })
end
