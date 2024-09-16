return {

  'sainnhe/gruvbox-material',
  lazy = false,
  priority = 1000,
  config = function()

    -- Gruvbox Settings ...
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_disable_italic_comment = 1
    vim.g.gruvbox_material_enable_bold = 1
    vim.g.gruvbox_material_enable_italic = 0
    vim.g.gruvbox_material_transparent_background = 0
    vim.g.gruvbox_material_spell_foreground = 'colored'
    vim.g.gruvbox_material_ui_contrast = 'high'
    vim.g.gruvbox_material_float_style = 'dim'


    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_foreground = "original"
    vim.cmd.colorscheme('gruvbox-material')

    -- Highlighting Number Lines
    vim.api.nvim_set_hl(0, "LineNRAbove", { fg = "DarkGreen", bold = true })
    vim.api.nvim_set_hl(0, "CursorLineNR", { fg = "Orange" , bold = true})
    vim.api.nvim_set_hl(0, "LineNRBelow", { fg = "DarkYellow" , bold = true})
    vim.cmd("highlight! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg")
  end

}
-- return {
--   "ellisonleao/gruvbox.nvim",
--   priority = 1000,
--   config = function()
--     local gruvbox = require("gruvbox")
--     gruvbox.setup({
--       terminal_colors = true,
--       undercurl = false,
--       underline = true,
--       bold = true,
--       italic = {
--         strings = false,
--         emphasis = false,
--         comments = false,
--         operators = false,
--         folds = false,
--       },
--       strikethrough = true,
--       invert_selection = true,
--       invert_signs = false,
--       invert_tabline = false,
--       invert_intend_guides = false,
--       inverse = true,
--       contrast = "dark",
--       palette_overrides = {},
--       overrides = {},
--       dim_inactive = false,
--       transparent_mode = false,
--     })
--   end,
--
-- }
