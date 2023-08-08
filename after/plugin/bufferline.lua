local bufferline = require("bufferline")
bufferline.setup({
    options = {
        numbers = "ordinal",
        buffer_close_icon = '󰅖',
        modified_icon = '●',
        close_icon = '󰅖',
        left_trunc_marker = '',
        right_trunc_marker = '...',
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "left",
                separator = true,
            }
        },
    }
})
