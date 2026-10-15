-- ============================================================================
-- High-End UI Suite Configuration (`lua/plugins/ui.lua`)
-- ============================================================================
vim.pack.add {
  -- Kanagawa Colorscheme
  { src = 'https://github.com/rebelot/kanagawa.nvim', name = 'kanagawa' },

  -- Floating Notifications
  { src = 'https://github.com/rcarriga/nvim-notify' },

  -- Statusline & Visual Indent Line Guides
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
  { src = 'https://github.com/lukas-reineke/indent-blankline.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  -- Rainbow Parentheses / Delimiters
  { src = 'https://github.com/HiPhish/rainbow-delimiters.nvim' },
}

vim.opt.fillchars = { eob = ' ' }
vim.opt.ruler = false -- Disable the ugly default ruler column

-- 1. Apply Kanagawa Dragon Colorscheme & Overrides
local kanagawa_ok, kanagawa = pcall(require, 'kanagawa')
if kanagawa_ok then
  kanagawa.setup {
    compile = true,
    undercurl = true,
    commentStyle = { italic = true },
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    transparent = true,
    theme = 'dragon',
    terminalColors = true,
    background = { dark = 'dragon', light = 'lotus' },
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = 'none',
          },
        },
      },
    },
    overrides = function(colors)
      local theme = colors.theme

      return {
        Visual = { bg = '#2d4f67', fg = 'NONE' }, -- Kanagawa wave/dragon visual selection background
        Cursor = { fg = '#181616', bg = '#FFA066' },
        NormalFloat = { bg = theme.ui.bg_m3 },
        FloatBorder = { bg = theme.ui.bg_m3, fg = theme.ui.bg_p2 },
        FloatTitle = { bg = theme.ui.bg_m3, fg = theme.ui.special },
        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
        PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },
        TelescopeTitle = { fg = theme.ui.special, bold = true },
        TelescopePromptNormal = { bg = theme.ui.bg_p1 },
        TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
        TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
        TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
        TelescopePreviewNormal = { bg = theme.ui.bg_dim },
        TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
        LineNr = { fg = '#727169', bg = 'NONE' },
        CursorLineNr = { fg = '#FFA066', bg = 'NONE', bold = true },
      }
    end,
  }
end
vim.cmd.colorscheme 'kanagawa-dragon'

-- 2. Configure nvim-notify with Animations
local notify_ok, notify = pcall(require, 'notify')
if notify_ok then
  notify.setup {
    timeout = 3000,
    background_colour = 'NormalFloat',
    fps = 60,
    render = 'minimal',
    merge_duplicates = true,
    stages = 'fade_in_slide_out',
  }
  vim.notify = notify
end
-- ============================================================================
-- 3. Lualine Setup (Arch Logo Restored & Clean Layout)
-- ============================================================================
local lualine_ok, lualine = pcall(require, 'lualine')
if lualine_ok then
  lualine.setup {
    options = {
      theme = 'kanagawa',
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      globalstatus = true,
      disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'neo-tree' } },
    },
    sections = {
      lualine_a = {
        {
          'mode',
          fmt = function(str) return str:sub(1, 1) end,
          icon = '󰣇', -- Restored Arch Linux icon
          separator = { left = '', right = '' },
        },
      },
      lualine_b = { { 'branch', icon = '󰊢' }, 'diff', 'diagnostics' },
      lualine_c = { { 'filename', path = 1, symbols = { modified = ' ', readonly = ' ', unnamed = '[No Name]' } } },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = {},
    },
  }
end
-- 4. Indent Blankline Setup
local ibl_ok, ibl = pcall(require, 'ibl')
if ibl_ok then ibl.setup {
  indent = { char = '│' },
  scope = { enabled = true },
} end

-- 5. Fixed Rainbow Delimiters Setup
vim.g.rainbow_delimiters = {
  strategy = {
    [''] = 'rainbow-delimiters.strategy.global',
    vim = 'rainbow-delimiters.strategy.local',
  },
  query = {
    [''] = 'rainbow-delimiters',
    lua = 'rainbow-blocks',
  },
  highlight = {
    'RainbowDelimiterOrange',
    'RainbowDelimiterYellow',
    'RainbowDelimiterGreen',
    'RainbowDelimiterBlue',
    'RainbowDelimiterViolet',
    'RainbowDelimiterCyan',
  },
}
