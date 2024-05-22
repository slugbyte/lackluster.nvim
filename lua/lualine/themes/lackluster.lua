local col = require("lackluster").col

local lualine_theme = {
    normal = {
        a = { bg = col._gray_stausbar_only, fg = col.gray7, gui = 'bold' },
        b = { bg = col._gray_stausbar_only, fg = col.gray7 },
        c = { bg = col._gray_stausbar_only, fg = col.gray7 },
    },
    insert = {
        a = { bg = col.lack, fg = col.white, gui = 'bold' },
        b = { bg = col._gray_stausbar_only, fg = col.gray7 },
        c = { bg = col._gray_stausbar_only, fg = col.gray7 },
    },
    command = {
        a = { bg = col.lack, fg = col.white, gui = 'bold' },
        b = { bg = col._gray_stausbar_only, fg = col.gray7 },
        c = { bg = col._gray_stausbar_only, fg = col.gray7 },
    },
    visual = {
        a = { bg = col.white, fg = col.black, gui = 'bold' },
        b = { bg = col._gray_stausbar_only, fg = col.gray7 },
        c = { bg = col._gray_stausbar_only, fg = col.gray7 },
    },
    replace = {
        a = { bg = col.white, fg = col.black, gui = 'bold' },
        b = { bg = col._gray_stausbar_only, fg = col.gray7 },
        c = { bg = col._gray_stausbar_only, fg = col.gray7 },
    },
    inactive = {
        a = { bg = col.gray1, fg = col.gray4, gui = 'bold' },
        b = { bg = col.gray1, fg = col.gray4 },
        c = { bg = col.gray1, fg = col.gray4 },
    },
}

return lualine_theme
