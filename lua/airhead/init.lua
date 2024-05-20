local M = {}

local C_GREEN = "#637a60"
local C_BLUE = "#3e6792"
local C_RED = "#D70000"

local C_GRAY1 = "#080808"
local C_GRAY2 = "#191919"
local C_GRAY3 = "#444444"
local C_GRAY4 = "#555555"
local C_GRAY5 = "#7a7a7a"
local C_GRAY6 = "#8f8f8f"
local C_GRAY7 = "#aaaaaa"
local C_GRAY8 = "#cccccc"

local C_SHELL = "#cdecf3"
local C_POP = "#9fbdf5"

M.colors = {
    info = C_BLUE,
    debug = C_GREEN,
    error = C_RED,
    warn = "#f5aa85",

    green = C_GREEN,
    blue = C_BLUE,
    red = C_RED,

    white = "#ffffff",
    black = "#000000",

    dul = "#cdd6df",
    pop = C_POP,

    menu_bg = C_GRAY2,
    menu_fg = C_GRAY5,
    select_bg = C_SHELL,
    select_fg = C_GRAY2,

    normal = C_SHELL,
    title = C_BLUE,

    type = C_GRAY7,
    constant = C_GRAY7,
    comment = '#2a2a2c',
    keyword = C_GRAY5,
    builtin = C_GREEN,
    punctuation = C_GRAY5,
    func = C_GRAY7,
    string = '#7c859b',

    block = "#0a0a0a",

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

local cc = function(name, fg, bg)
    if fg == nil then
        assert(false, name .. " fg cannot be nil")
    end
    if bg == nil then
        assert(false, name .. " bg cannot be nil")
    end

    return {
        name = name,
        fg = fg,
        bg = bg,
    }
end

local fg = function(name, fg)
    return cc(name, fg, c.none)
end

M.test_garbage = function()
    local wat = false
    if wat and true then
        print("cool\n that is sick")
    end
end

-- this is a comment
local colorscheme = {
    cc('Normal', c.normal, c.gray1),
    fg('Title', c.title),

    -- CURSOR
    cc('CursorLine', c.none, c.gray2),
    fg('CursorLineNr', c.gray7),
    fg('LineNr', c.gray3),

    -- UI
    cc('NormalFloat', c.normal, c.menu_bg),
    cc('FloatTitle', c.normal, c.menu_bg),
    cc('FloatBorder', c.normal, c.menu_bg),
    cc('Pmenu', c.menu_fg, c.menu_bg),
    cc('PmenuThumb', c.menu_fg, c.menu_bg),
    cc('PmenuSel', c.select_fg, c.select_bg),

    -- SYNTAX
    fg('Keyword', c.keyword),
    fg('Function', c.func),
    fg('Type', c.type),
    fg('Variable', c.white),
    fg('Special', c.warn),

    -- literals
    fg('String', c.string),
    fg('Constant', c.constant),
    fg('Number', c.constant),
    fg('Boolean', c.constant),
    fg('Float', c.constant),

    -- puctuation
    fg('Quote', c.string),
    fg('Operator', c.punctuation),
    fg('Delimiter', c.punctuation),
    fg('@punctuation.bracket', c.punctuation),
    fg('@punctuation.special', c.punctuation),

    -- comment
    fg('Comment', c.comment),
    fg('SpecialComment', c.comment),

    -- lsp
    fg('@lsp.type.function', c.gray8),
    fg('@lsp.type.type.zig', c.warn),
    fg('@lsp.type.property', c.white),

    -- lua
    fg('@function.builtin.lua', c.builtin),
    fg('@constructor.lua', c.punctuation),

    -- go
    fg('@function.builtin.go', c.builtin),
    fg('@variable.parameter.go', c.gray4),
    fg('@property.go', c.white),

    -- zig
    fg('@function.builtin.zig', c.builtin),
    fg('@lsp.type.builtin.zig', c.builtin),
    fg('@keyword.import.zig', c.builtin),
    fg('@function.call.zig', c.gray6),
    fg('@variable.parameter.zig', c.gray4),
    fg('@variable.member.zig', c.gray7),

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
    fg('@markup.quote.markdown', c.gray5),
    cc('@markup.raw.block.markdown', c.none, c.block),
    fg('@markup.list.unchecked.markdown', c.red),
    fg('@markup.list.checked.markdown', c.pop),
    fg('@markup.strong', c.gray3),
    fg('@markup.italic', c.gray3),
    fg('@markup.strikethrough', c.gray3),
    fg('@markup.list.markdown', c.gray4),
    fg('@markup.link.label.markdown_inline', c.green),
    fg('@markup.link.url.markdown_inline', c.gray3),
    fg('markdownCodeDelimiter', c.green),

    -- sql
    fg('sqlType', c.warn),
    fg('sqlKeyword', c.gray7),
    fg('sqlStatement', c.gray7),
    fg('sqlVariable', c.warn),

    -- bash
    fg('@function.builtin.bash', c.builtin),

    -- make
    fg('@function.builtin.make', c.builtin),
    fg('@string.special.symbol.make', c.string),
    fg('makeSpecial', c.blue),

    -- telescope
    fg('TelescopeNormal', c.white),
    fg('TelescopeResultsNormal', c.gray3),
    fg('TelescopeBorder', c.gray3),
    fg('TelescopeMultiSelection', c.green),
    fg('TelescopeMultiIcon', c.green),
    fg('TelescopePromptPrefix', c.gray5),
    fg('TelescopePromptCounter', c.string),
    cc('TelescopeSelection', c.gray1, c.white),

    -- todo
    fg('TodoBgTodo', c.green),
    fg('TodoBgNote', c.blue),
    fg('TodoBgFix', c.red),
    fg('TodoBgWarn', c.warn),
    fg('TodoBgPerf', c.warn),
    fg('TodoBgHack', c.warn),
}

M.setup = function()
    vim.cmd("hi clear")
    for i, value in ipairs(colorscheme) do
        local name = value.name
        value.name = nil
        vim.api.nvim_set_hl(0, name, value)
    end
end

M.setup()
return M
