local col = require("lackluster").col

local lualine_theme = {
    normal = {
        a = { bg = col.gray2, fg = col.gray7, gui = 'bold' },
        b = { bg = col.gray2, fg = col.gray7 },
        c = { bg = col.gray2, fg = col.gray7 },
    },
    insert = {
        a = { bg = col.lack, fg = col.white, gui = 'bold' },
        b = { bg = col.gray2, fg = col.lack },
        c = { bg = col.black, fg = col.lack },
    },
    visual = {
        a = { bg = col.white, fg = col.black, gui = 'bold' },
        b = { bg = col.gray2, fg = col.white },
        c = { bg = col.black, fg = col.white },
    },
    replace = {
        a = { bg = col.white, fg = col.black, gui = 'bold' },
        b = { bg = col.gray2, fg = col.white },
        c = { bg = col.black, fg = col.white },
    },
    command = {
        a = { bg = col.lack, fg = col.black, gui = 'bold' },
        b = { bg = col.gray2, fg = col.lack },
        c = { bg = col.black, fg = col.lack },
    },
    inactive = {
        a = { bg = col.black, fg = col.gray2, gui = 'bold' },
        b = { bg = col.black, fg = col.gray2 },
        c = { bg = col.black, fg = col.gray5 },
    },
}

return lualine_theme
