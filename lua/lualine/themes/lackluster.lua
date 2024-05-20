local colors = require("lackluster").colors

local lualine_theme = {
    normal = {
        a = { bg = colors.gray2, fg = colors.gray7, gui = 'bold' },
        b = { bg = colors.gray2, fg = colors.gray7 },
        c = { bg = colors.gray2, fg = colors.gray7 },
    },
    insert = {
        a = { bg = colors.green, fg = colors.white, gui = 'bold' },
        b = { bg = colors.gray2, fg = colors.green },
        c = { bg = colors.black, fg = colors.green },
    },
    visual = {
        a = { bg = colors.sky, fg = colors.black, gui = 'bold' },
        b = { bg = colors.gray2, fg = colors.sky },
        c = { bg = colors.black, fg = colors.sky },
    },
    replace = {
        a = { bg = colors.sky, fg = colors.black, gui = 'bold' },
        b = { bg = colors.gray2, fg = colors.sky },
        c = { bg = colors.black, fg = colors.sky },
    },
    command = {
        a = { bg = colors.mild, fg = colors.black, gui = 'bold' },
        b = { bg = colors.gray2, fg = colors.mild },
        c = { bg = colors.black, fg = colors.mild },
    },
    inactive = {
        a = { bg = colors.black, fg = colors.gray2, gui = 'bold' },
        b = { bg = colors.black, fg = colors.gray2 },
        c = { bg = colors.black, fg = colors.gray2 },
    },
}

return lualine_theme
