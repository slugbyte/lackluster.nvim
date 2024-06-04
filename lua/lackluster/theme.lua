local color = require("lackluster.color")
local color_special = require("lackluster.color-special")

local M = {}

M.ui = {
    fg_normal         = color.gray8,
    bg_normal         = color_special.main_background,

    fg_title          = color.gray5,

    bg_statusline     = color.gray1,
    bg_statusline_cur = color_special.statusline,

    bg_tab            = color.gray2,
    bg_tab_cur        = color.gray8,

    fg_line_num       = color.gray4,
    fg_line_num_cur   = color.gray7,

    fg_border         = color.gray4,
    bg_colorcolumn    = color.gray1,
    bg_cursorline     = color.gray2,

    bg_visual         = color.gray8,
    fg_visual         = color.black,

    fg_search         = color.black,
    bg_search_item    = color.lack,
    bg_search_cur     = color.gray8,

    bg_scrollbar      = color.gray3,
    fg_scrollbar      = color.gray5,

    fg_popup          = color.gray6,
    bg_popup          = color_special.popup_background,

    fg_menu           = color.gray6,
    bg_menu           = color_special.menu_background,

    fg_telescope      = color.gray8,
    bg_telescope      = color_special.main_background,
}

-- syntax_tweeks get appyed by setup()
M.syntax_tweek = {}

M.syntax_default = {
    tag = color.gray5,
    var = color.gray8,
    var_member = color.gray7,
    const = color.gray7,
    const_builtin = color.gray6,
    func_def = color.luster,
    func_call = color.gray6,
    func_param = color_special.param,
    special = color.lack,
    type = color.gray7,
    type_def = color.gray8,
    type_primitave = color.gray7,
    builtin = color.gray5,
    keyword = color_special.keyword,
    keyword_return = color_special.exception,
    keyword_exception = color_special.exception,
    string = color.lack,
    string_escape = color.green,
    punctuation = color.gray6,
    comment = color_special.comment,
}

M.syntax_hack = vim.tbl_deep_extend("force", M.syntax_default, {
    keyword_return = color.green,
    keyword_exception = color.blue,
})

M.syntax_mint = vim.tbl_deep_extend("force", M.syntax_default, {
    type = color.green,
    type_primitave = color.green,
    func_param = color.gray7
})

M.syntax_night = vim.tbl_deep_extend("force", M.syntax_default, {
    keyword = color.lack,
    str = color.blue,
})

M.syntax_dark = {
    var = color.gray6,
    var_member = color.gray6,
    const = color.gray5,
    const_builtin = color.gray5,
    tag = color.gray5,
    func_call = color.gray5,
    func_def = color_special.keyword,
    builtin = color.gray4,
    func_param = color.gray6,
    special = color.lack,
    type = color.gray5,
    type_def = color.gray5,
    type_primitave = color.gray5,
    keyword = color.gray5,
    keyword_return = color_special.exception,
    keyword_exception = color_special.exception,
    string = "#aa6666",
    string_escape = color.blue,
    punctuation = color.gray6,
    comment = color_special.comment,
}

M.log = {
    success = color.green,
    info = color.luster,
    warn = color.orange,
    error = color.red,
    hint = color.gray6,
}

M.diagnostic = {
    -- NOTE: "text" is used for hover/virtual text and the colors are used as signs
    -- this reduces visual noise (except for error text which should always be red)
    text = color.gray4,
    ok = color.green,
    hint = color.gray6,
    error = color.red,
    info = color.gray6,
    warn = color.orange,
    unnecessary = color.gray4,
    depricated = color.orange,
}

M.fs = {
    dir = color.gray5,
    file = color.luster,
    exec = color.green,
    link = color.lack,
    binary_data = color.gray6,
    socket = color.gray6,
}

M.diff = {
    add = color.green,
    change = color.gray6,
    delete = color.orange,
    info = color.gray5,
}

M.rainbow = {
    red = "#555555",
    yellow = "#999999",
    blue = "#aaaaaa",
    orange = "#cccccc",
    green = "#666666",
    violet = "#BBBBBB",
    cyan = "#DDDDDD",
}

return M
