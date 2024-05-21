local M = {}

-- TODO: get you a new green
local C_GREEN = "#637a60"
local C_BLUE = "#3e6792"
local C_RED = "#D70000"
local C_ORANGE = '#f5aa85'

local C_SHELL = "#cdecf3"
local C_MILD = '#5d626b'

local C_GRAY1 = "#080808"
local C_GRAY2 = "#191919"
local C_GRAY3 = "#444444"
local C_GRAY4 = "#555555"
local C_GRAY5 = "#7a7a7a"
local C_GRAY6 = "#8f8f8f"
local C_GRAY7 = "#aaaaaa"
local C_GRAY8 = "#cccccc"

M.col = {
    green = "#637a60",
    blue = "#3e6792",
    red = "#D70000",
    orange = '#f5aa85',

    mild = '#5d626b',

    black = '#000000',
    white = '#ffffff',
    shell = "#cdecf3",

    gray1 = "#080808",
    gray2 = "#191919",
    gray3 = "#444444",
    gray4 = "#555555",
    gray5 = "#7a7a7a",
    gray6 = "#8f8f8f",
    gray7 = "#aaaaaa",
    gray8 = "#cccccc",
    none = "none",
}

M.col.log = {
    info = M.col.shell,
    debug = M.col.gray3,
    warn = M.col.orange,
    error = M.col.red,
    hint = M.col.blue,
}

M.col.fs = {
    dir = M.col.mild,
    file = M.col.shell,
    link = M.col.blue,
    link_target = M.col.blue,
    socket = M.col.orange,
}

M.col.diff = {
    add = M.col.green,
    change = M.col.blue,
    delete = M.col.orange,
    info = M.col.gray4,
}

M.col.ui = {
    normal        = M.col.shell,
    title         = M.col.gray7,
    visual_bg     = M.col.black,
    visual_fg     = M.col.white,
    search_fg     = M.col.black,
    search_inc_bg = M.col.mild,
    search_cur_bg = M.col.white,
    cursorline    = M.col.gray2,
    colorcolumn   = M.col.black,
    menu_bg       = M.col.gray2,
    menu_fg       = M.col.gray5,
    line_num      = M.col.gray3,
    line_num_cur  = M.col.gray7,
    win_seperator = M.col.mild,
}

M.col.syntax = {
    var = M.col.shell,
    const = M.col.gray7,
    const_builtin = M.col.gray4,
    func = M.col.gray7,
    -- func_builtin = '#5c6375',
    func_builtin = M.col.gray3,
    func_param = M.col.gray4,
    special = M.col.mild,
    type = M.col.gray7,
    type_primitave = M.col.gray7,
    keyword = M.col.gray5,
    str = M.col.mild,
    str_esc = '#8e95af',
    punctuation = M.col.gray5,
    comment = '#2a2a2a',
}

local c = M.col

local cc = function(name, fg, bg, opts)
    opts = opts or {}
    if fg == nil then
        assert(false, name .. " fg cannot be nil")
    end
    if bg == nil then
        assert(false, name .. " bg cannot be nil")
    end

    return vim.tbl_extend("force", opts, {
        name = name,
        fg = fg,
        bg = bg,
    })
end

local fg = function(name, fg)
    return cc(name, fg, c.none)
end

local bg = function(name, bg)
    return cc(name, c.none, bg)
end

local ln = function(name, link)
    return {
        name = name,
        link = link,
    }
end

-- this is a comment
M.theme = function()
    return {
        cc('Normal', c.ui.normal, '#0a0a0a'),
        fg('Title', c.ui.title),
        cc('Spell', c.none, c.none, {
            underline = true,
        }),

        -- CURSOR
        cc('CursorLine', c.none, c.ui.cursorline),
        fg('CursorLineNr', c.ui.line_num_cur),
        fg('LineNr', c.ui.line_num),
        bg('ColorColumn', c.ui.colorcolumn),

        -- SEARCH
        cc('Search', c.ui.search_fg, c.ui.search_inc_bg),
        cc('CurSearch', c.ui.search_fg, c.ui.search_cur_bg),
        ln('IncSearch', 'CurSearch'),

        -- VISUAL
        cc('VISUAL', c.ui.visual_fg, c.ui.visual_bg),
        ln('VISUALNOS', 'VISUAL'),

        -- message
        fg('ErrorMsg', c.log.error),
        fg('WarningMsg', c.log.warn),
        fg('ModeMsg', c.log.info),
        fg('MsgArea', c.log.info),

        -- UI
        cc('NormalFloat', c.ui.normal, c.ui.menu_bg),
        cc('FloatTitle', c.ui.normal, c.ui.menu_bg),
        cc('FloatBorder', c.ui.normal, c.ui.menu_bg),
        cc('Pmenu', c.ui.menu_fg, c.ui.menu_bg),
        cc('PmenuThumb', c.ui.menu_fg, c.ui.menu_bg),
        cc('PmenuSel', c.ui.search_fg, c.ui.search_cur_bg),
        fg('WinSeparator', c.ui.win_seperator),

        -- SYNTAX
        fg('Function', c.syntax.func),
        fg('Type', c.syntax.type),
        fg('Variable', c.syntax.var),
        fg('Special', c.syntax.special),
        fg('Keyword', c.syntax.keyword),
        ln('Conditional', 'Keyword'),
        ln('Repeat', 'Keyword'),
        ln('Label', 'Keyword'),
        ln('Exception', 'Keyword'),
        ln('PreProc', 'Keyword'),

        -- literals
        fg('String', c.syntax.str),
        ln('Character', 'String'),
        fg('Constant', c.syntax.const),
        ln('Number', 'Constant'),
        ln('Boolean', 'Constant'),
        ln('Float', 'Constant'),

        -- puctuation
        fg('Quote', c.syntax.str),
        fg('Operator', c.syntax.punctuation),
        fg('Delimiter', c.syntax.punctuation),
        cc('MatchParen', c.ui.search_cur_bg, c.ui.search_inc_bg),

        -- comment
        fg('Comment', c.syntax.comment),
        fg('SpecialComment', c.syntax.comment),

        -- diagnostics
        fg('DiagnosticHint', c.log.debug),
        fg('DiagnosticInfo', c.log.debug),
        fg('DiagnosticWarn', c.log.warn),
        fg('DiagnosticError', c.log.error),

        fg('DiagnosticSignHint', c.log.hint),
        fg('DiagnosticSignInfo', c.log.debug),
        fg('DiagnosticSignWarn', c.log.warn),
        fg('DiagnosticSignError', c.log.error),

        -- lsp
        fg('@lsp.type.function', c.gray8),
        fg('@lsp.type.property', c.ui.normal),
        fg('@constant.builtin.lua', c.gray4),

        -- treesitter
        fg('@punctuation.bracket', c.syntax.punctuation),
        fg('@punctuation.special', c.syntax.punctuation),
        fg('@type.builtin', c.syntax.type_primitave),
        fg('@function.call', c.syntax.func),
        fg('@function.builtin', c.syntax.func_builtin),
        fg('@variable.parameter', c.syntax.func_param),
        fg('@constant.builtin', c.syntax.const_builtin),
        fg('@variable.member', c.syntax.type),
        fg('@attribute', c.syntax.keyword),
        fg('@property', c.ui.normal),
        fg('@string.escape', c.syntax.str_esc),

        -- diff
        fg('diffAdded', c.diff.add),
        fg('diffRemoved', c.diff.delete),
        fg('diffChanged', c.diff.change),
        fg('diffOldFile', c.diff.info),
        fg('diffNewFile', c.diff.add),
        fg('diffFile', c.diff.change),
        fg('diffLine', c.diff.change),
        fg('diffIndexLine', c.diff.info),

        -- lua
        fg('@constructor.lua', c.syntax.punctuation),

        -- zig
        fg('@keyword.import.zig', c.syntax.func_builtin),

        -- html
        fg('htmlTagName', c.gray4),
        fg('@tag.html', c.gray4),
        fg('@tag.delimiter.html', c.gray4),
        fg('@tag.attribute.html', c.green),

        -- css
        fg('cssMediaProp', c.ui.normal),
        fg('cssTransitionProp', c.ui.normal),
        fg('cssTextProp', c.ui.normal),
        fg('cssBoxProp', c.ui.normal),
        fg('cssFontProp', c.ui.normal),
        fg('cssPositioningProp', c.ui.normal),
        fg('cssBorderProp', c.ui.normal),
        fg('cssBackgroundProp', c.ui.normal),
        fg('cssTransformProp', c.ui.normal),
        fg('@property.css', c.ui.normal),
        fg('@tag.css', c.ui.normal),

        -- markdown
        fg('@markup.quote', c.gray5),
        fg('@markup.list.unchecked', c.red),
        fg('@markup.list.checked', c.syntax.str_esc),
        fg('@markup.strong', c.gray3),
        fg('@markup.italic', c.gray3),
        fg('@markup.strikethrough', c.gray3),
        fg('@markup.list', c.gray3),
        fg('@markup.link', c.gray5),
        fg('@markup.link.label', c.gray5),
        fg('@markup.link.url', c.gray3),
        fg('@markup.math', c.orange),
        fg('markdownCodeDelimiter', c.green),
        fg('markdownLinkDelimiter', c.gray5),

        -- sql
        fg('sqlType', c.syntax.str),
        fg('sqlKeyword', c.syntax.keyword),
        fg('sqlStatement', c.syntax.keyword),
        fg('sqlVariable', c.syntax.special),

        -- javascript
        fg("@function.builtin.javascript", c.log.warn),
        fg("@function.builtin.typescript", c.log.warn),
        fg("@keyword.exception.javascript", c.log.warn),
        fg("@keyword.exception.typescript", c.log.warn),

        -- make
        fg('@string.special.symbol.make', c.syntax.str),
        fg('makeSpecial', c.syntax.special),

        -- telescope
        fg('TelescopeNormal', c.ui.normal),
        fg('TelescopeResultsNormal', c.gray4),
        fg('TelescopeMatching', c.gray3),
        fg('TelescopeBorder', c.gray3),
        fg('TelescopeMultiSelection', c.green),
        fg('TelescopeMultiIcon', c.green),
        fg('TelescopePromptPrefix', c.gray5),
        fg('TelescopePromptCounter', c.orange),
        cc('TelescopeSelection', c.gray1, c.white),

        -- nvim cmp
        fg('CmpItemAbbrDeprecated', c.gray3),

        -- which key
        fg('WhichKey', c.white),
        fg('WhichKeyGroup', c.mild),
        fg('WhichKeyDesc', c.ui.normal),
        fg('WhichKeySeparator', c.mild),

        -- oil
        fg('OilFile', c.fs.file),
        fg('OilDir', c.fs.dir),
        fg('OilDirIcon', c.fs.dir),
        fg('OilLink', c.fs.link),
        ln('OilLinkTarget', 'OilLink'),

        -- git signs
        fg('GitSignsAdd', c.diff.info),
        fg('GitSignsChange', c.diff.change),
        fg('GitSignsDelete', c.diff.delete),
        fg('GitSignsChangeDelete', c.diff.delete),

        -- todo
        fg('TodoBgTodo', c.log.info),
        fg('TodoBgNote', c.log.hint),
        fg('TodoBgFix', c.log.error),
        ln('TodoBgWarn', 'TodoBgFix'),
        ln('TodoBgPerf', 'TodoBgFix'),
        ln('TodoBgHack', 'TodoBgFix'),

        -- lightbulb
        fg('LightBulbSign', c.log.debug),
    }
end

M.load = function()
    local dedup_set = {}
    -- vim.cmd("hi clear")
    for _, hi_spec in ipairs(M.theme()) do
        local name = hi_spec.name
        if dedup_set[name] then
            vim.notify("error: duplicate hilight :: " .. name, vim.log.levels.ERROR)
        end
        dedup_set[name] = true
        hi_spec.name = nil
        vim.api.nvim_set_hl(0, name, hi_spec)
    end
end

return M
