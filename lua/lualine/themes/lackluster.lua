local col = require("lackluster").color

local lualine_theme = {
    normal = {
        a = { bg = col._special_gray_statusline, fg = col.gray7, gui = 'bold' },
        b = { bg = col._special_gray_statusline, fg = col.gray7 },
        c = { bg = col._special_gray_statusline, fg = col.gray7 },
    },
    insert = {
        a = { bg = col.lack, fg = col.gray9, gui = 'bold' },
        b = { bg = col._special_gray_statusline, fg = col.gray7 },
        c = { bg = col._special_gray_statusline, fg = col.gray7 },
    },
    command = {
        a = { bg = col.lack, fg = col.gray9, gui = 'bold' },
        b = { bg = col._special_gray_statusline, fg = col.gray7 },
        c = { bg = col._special_gray_statusline, fg = col.gray7 },
    },
    visual = {
        a = { bg = col.gray9, fg = col.black, gui = 'bold' },
        b = { bg = col._special_gray_statusline, fg = col.gray7 },
        c = { bg = col._special_gray_statusline, fg = col.gray7 },
    },
    replace = {
        a = { bg = col.gray9, fg = col.black, gui = 'bold' },
        b = { bg = col._special_gray_statusline, fg = col.gray7 },
        c = { bg = col._special_gray_statusline, fg = col.gray7 },
    },
    inactive = {
        a = { bg = col.gray1, fg = col.gray4, gui = 'bold' },
        b = { bg = col.gray1, fg = col.gray4 },
        c = { bg = col.gray1, fg = col.gray4 },
    },
}

return lualine_theme
