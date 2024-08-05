local color = require("lackluster.color")
local color_special = require("lackluster.color-special")

local lualine_theme = {
    normal = {
        a = { bg = color_special.statusline, fg = color.gray7, gui = "bold" },
        b = { bg = color_special.statusline, fg = color.gray7 },
        c = { bg = color_special.statusline, fg = color.gray7 },
    },
    insert = {
        a = { bg = color.lack, fg = color.gray9, gui = "bold" },
        b = { bg = color_special.statusline, fg = color.gray7 },
        c = { bg = color_special.statusline, fg = color.gray7 },
    },
    command = {
        a = { bg = color.lack, fg = color.gray9, gui = "bold" },
        b = { bg = color_special.statusline, fg = color.gray7 },
        c = { bg = color_special.statusline, fg = color.gray7 },
    },
    visual = {
        a = { bg = color.gray9, fg = color.black, gui = "bold" },
        b = { bg = color_special.statusline, fg = color.gray7 },
        c = { bg = color_special.statusline, fg = color.gray7 },
    },
    replace = {
        a = { bg = color.gray9, fg = color.black, gui = "bold" },
        b = { bg = color_special.statusline, fg = color.gray7 },
        c = { bg = color_special.statusline, fg = color.gray7 },
    },
    inactive = {
        a = { bg = color.gray1, fg = color.gray4, gui = "bold" },
        b = { bg = color.gray1, fg = color.gray4 },
        c = { bg = color.gray1, fg = color.gray4 },
    },
}

return lualine_theme
