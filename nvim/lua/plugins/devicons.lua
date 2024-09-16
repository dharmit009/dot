return {
    "nvim-tree/nvim-web-devicons",
    config = function()
        local devicons = require('nvim-web-devicons')
        devicons.get_icon(filename, extension, options)
        devicons.get_icon_by_filetype(filetype, opts)
        devicons.get_icon_colors_by_filetype(filetype, opts)
        devicons.get_icon_color_by_filetype(filetype, opts)
        devicons.get_icon_cterm_color_by_filetype(filetype, opts)
    end
}
