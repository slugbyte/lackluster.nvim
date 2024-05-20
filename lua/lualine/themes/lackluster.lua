local colors = require("lackluster").colors

local lualine_theme = {
    normal = {
        a = { bg = colors.gray2, fg = colors.gray7, gui = 'bold' },
        b = { bg = colors.gray2, fg = colors.gray7 },
        c = { bg = colors.gray2, fg = colors.gray7 },
    },
    insert = {
        a = { bg = colors.mild, fg = colors.white, gui = 'bold' },
        b = { bg = colors.gray2, fg = colors.mild },
        c = { bg = colors.black, fg = colors.mild },
    },
    visual = {
        a = { bg = colors.white, fg = colors.black, gui = 'bold' },
        b = { bg = colors.gray2, fg = colors.white },
        c = { bg = colors.black, fg = colors.white },
    },
    replace = {
        a = { bg = colors.white, fg = colors.black, gui = 'bold' },
        b = { bg = colors.gray2, fg = colors.white },
        c = { bg = colors.black, fg = colors.white },
    },
    command = {
        a = { bg = colors.mild, fg = colors.black, gui = 'bold' },
        b = { bg = colors.gray2, fg = colors.mild },
        c = { bg = colors.black, fg = colors.mild },
    },
    inactive = {
        a = { bg = colors.black, fg = colors.gray2, gui = 'bold' },
        b = { bg = colors.black, fg = colors.gray2 },
        c = { bg = colors.black, fg = colors.gray5 },
    },
}

return lualine_theme
