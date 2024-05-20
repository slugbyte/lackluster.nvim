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

M.colors = {
    debug = C_GREEN,
    error = C_RED,
    warn = C_ORANGE,

    fs_dir = C_MILD,
    fs_file = C_SHELL,
    fs_link = C_BLUE,
    fs_link_target = C_BLUE,
    fs_socket = C_ORANGE,

    green = C_GREEN,
    blue = C_BLUE,
    red = C_RED,
    orange = C_ORANGE,

    white = "#ffffff",
    black = "#000000",

    mild = C_MILD,

    menu_bg = C_GRAY2,
    menu_fg = C_GRAY5,
    select_bg = C_SHELL,
    select_fg = C_GRAY2,

    normal = C_SHELL,
    title = C_MILD,

    type = C_GRAY7,
    primitave = C_ORANGE,
    constant = C_GRAY7,
    comment = '#2a2a2c',
    keyword = C_GRAY5,
    -- builtin = '#576076',
    builtin = '#5c6375',

    punctuation = C_GRAY5,
    func = C_GRAY7,
    string = C_MILD,
    string_escape = '#8e95af',

    gray1 = C_GRAY1,
    gray2 = C_GRAY2,
    gray3 = C_GRAY3,
    gray4 = C_GRAY4,
    gray5 = C_GRAY5,
    gray6 = C_GRAY6,
    gray7 = C_GRAY7,
    gray8 = C_GRAY8,
    none = 'NONE',
}

local c = M.colors

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

-- this is a comment
M.theme = function()
    return {
        cc('Normal', c.normal, '#0a0a0a'),
        fg('Title', c.title),
        cc('Spell', c.none, c.none, {
            underline = true,
        }),

        -- CURSOR
        cc('CursorLine', c.none, c.gray2),
        fg('CursorLineNr', c.gray7),
        fg('LineNr', c.gray3),
        bg('ColorColumn', c.black),

        -- SEARCH
        cc('Search', c.black, c.mild),
        cc('IncSearch', c.black, c.white),
        cc('CurSearch', c.black, c.white),

        -- VISUAL
        cc('VISUAL', c.black, c.white),
        cc('VISUALNOS', c.black, c.white),

        -- message
        fg('ErrorMsg', c.error),
        fg('WarningMsg', c.warn),
        fg('ModeMsg', c.mild),
        fg('MsgArea', c.normal),

        -- UI
        cc('NormalFloat', c.normal, c.menu_bg),
        cc('FloatTitle', c.normal, c.menu_bg),
        cc('FloatBorder', c.normal, c.menu_bg),
        cc('Pmenu', c.menu_fg, c.menu_bg),
        cc('PmenuThumb', c.menu_fg, c.menu_bg),
        cc('PmenuSel', c.select_fg, c.select_bg),
        fg('WinSeparator', c.mild),

        -- SYNTAX
        fg('Function', c.func),
        fg('Type', c.type),
        fg('Variable', c.normal),
        fg('Special', c.builtin),
        fg('Keyword', c.keyword),
        fg('Conditional', c.keyword),
        fg('Repeat', c.keyword),
        fg('Label', c.keyword),
        fg('Exception', c.warn),
        fg('PreProc', c.builtin),

        -- literals
        fg('Constant', c.constant),
        fg('String', c.string),
        fg('Character', c.string),
        fg('Number', c.constant),
        fg('Boolean', c.constant),
        fg('Float', c.constant),

        -- puctuation
        fg('Quote', c.string),
        fg('Operator', c.punctuation),
        fg('Delimiter', c.punctuation),
        cc('MatchParen', c.white, c.mild),

        -- comment
        fg('Comment', c.comment),
        fg('SpecialComment', c.comment),

        -- diagnostics
        fg('DiagnosticHint', c.gray3),
        fg('DiagnosticInfo', c.gray3),
        fg('DiagnosticWarn', c.warn),
        fg('DiagnosticError', c.error),

        fg('DiagnosticSignHint', c.green),
        fg('DiagnosticSignInfo', c.blue),
        fg('DiagnosticSignWarn', c.warn),
        fg('DiagnosticSignError', c.error),

        -- lsp
        fg('@lsp.type.function', c.gray8),
        fg('@lsp.type.property', c.normal),
        fg('@constant.builtin.lua', c.gray4),

        -- treesitter
        fg('@punctuation.bracket', c.punctuation),
        fg('@punctuation.special', c.punctuation),
        fg('@type.builtin', c.primitave),
        fg('@function.call', c.func),
        fg('@constant.builtin', c.gray4),
        fg('@function.builtin', c.builtin),
        fg('@variable.parameter', c.gray4),
        fg('@variable.member', c.gray7),
        fg('@attribute', c.keyword),
        fg('@property', c.normal),
        fg('@string.escape', c.string_escape),

        -- diff
        fg('diffAdded', c.green),
        fg('diffRemoved', c.error),
        fg('diffChanged', c.mild),
        fg('diffOldFile', c.warn),
        fg('diffNewFile', c.green),
        fg('diffFile', c.mild),
        fg('diffLine', c.mild),
        fg('diffIndexLine', c.mild),

        -- lua
        fg('@constructor.lua', c.punctuation),

        -- zig
        fg('@keyword.import.zig', c.builtin),

        -- html
        fg('htmlTagName', c.gray4),
        fg('@tag.html', c.gray4),
        fg('@tag.delimiter.html', c.gray4),
        fg('@tag.attribute.html', c.green),

        -- css
        fg('cssMediaProp', c.normal),
        fg('cssTransitionProp', c.normal),
        fg('cssTextProp', c.normal),
        fg('cssBoxProp', c.normal),
        fg('cssFontProp', c.normal),
        fg('cssPositioningProp', c.normal),
        fg('cssBorderProp', c.normal),
        fg('cssBackgroundProp', c.normal),
        fg('cssTransformProp', c.normal),
        fg('@property.css', c.normal),
        fg('@tag.css', c.normal),

        -- markdown
        fg('@markup.quote', c.gray5),
        fg('@markup.list.unchecked', c.red),
        fg('@markup.list.checked', c.string_escape),
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
        fg('sqlType', c.builtin),
        fg('sqlKeyword', c.gray7),
        fg('sqlStatement', c.gray7),
        fg('sqlVariable', c.primitave),

        -- javascript
        fg("@function.builtin.javascript", c.orange),
        fg("@function.builtin.typescript", c.orange),
        fg("@keyword.exception.javascript", c.orange),
        fg("@keyword.exception.typescript", c.orange),

        -- make
        fg('@string.special.symbol.make', c.string),
        fg('makeSpecial', c.blue),

        -- telescope
        fg('TelescopeNormal', c.white),
        fg('TelescopeMatching', c.gray3),
        fg('TelescopeResultsNormal', c.gray4),
        fg('TelescopeBorder', c.gray3),
        fg('TelescopeMultiSelection', c.green),
        fg('TelescopeMultiIcon', c.green),
        fg('TelescopePromptPrefix', c.gray5),
        fg('TelescopePromptCounter', c.string),
        cc('TelescopeSelection', c.gray1, c.white),

        -- nvim cmp
        fg('CmpItemAbbrDeprecated', c.gray3),

        -- which key
        fg('WhichKey', c.white),
        fg('WhichKeyGroup', c.string),
        fg('WhichKeyDesc', c.normal),
        fg('WhichKeySeparator', c.mild),

        -- oil
        fg('OilFile', c.fs_file),
        fg('OilDir', c.fs_dir),
        fg('OilDirIcon', c.fs_dir),
        fg('OilLink', c.fs_link),
        fg('OilLinkTarget', c.fs_link_target),

        -- git signs
        fg('GitSignsAdd', c.gray3),
        fg('GitSignsChange', c.blue),
        fg('GitSignsDelete', c.warn),
        fg('GitSignsChangeDelete', c.warn),

        -- todo
        fg('TodoBgTodo', c.green),
        fg('TodoBgNote', c.blue),
        fg('TodoBgFix', c.red),
        fg('TodoBgWarn', c.warn),
        fg('TodoBgPerf', c.warn),
        fg('TodoBgHack', c.warn),

        -- lightbulb
        fg('LightBulbSign', c.gray3),
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
