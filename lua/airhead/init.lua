local M = {}

-- TODO: get you a new green
local C_GREEN = "#637a60"
local C_BLUE = "#3e6792"
local C_RED = "#D70000"
local C_ORANGE = '#f5aa85'

local C_SHELL = "#cdecf3"
local C_SKY = "#9fbdf5"
local C_MILD = '#7c859b'

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
    fs_link = C_SKY,
    fs_link_target = C_BLUE,
    fs_socket = C_ORANGE,

    green = C_GREEN,
    blue = C_BLUE,
    red = C_RED,
    orange = C_ORANGE,

    white = "#ffffff",
    black = "#000000",

    sky = C_SKY,
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
    -- builtin = '#936363',
    -- builtin = '#897676',
    builtin = '#576066',
    punctuation = C_GRAY5,
    func = C_GRAY7,
    string = C_MILD,

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

local bg = function(name, bg)
    return cc(name, c.none, bg)
end

M.test_garbage = function()
    local wat = false
    if wat and true then
        print("cool\n that is sick")
    end
end

-- this is a comment
M.theme = function()
    return {
        cc('Normal', c.normal, c.gray1),
        fg('Title', c.title),

        -- CURSOR
        cc('CursorLine', c.none, c.gray2),
        fg('CursorLineNr', c.gray7),
        fg('LineNr', c.gray3),
        bg('ColorColumn', c.black),

        -- SEARCH
        cc('Search', c.black, c.sky),
        cc('IncSearch', c.black, c.white),
        cc('CurSearch', c.black, c.white),

        -- VISUAL
        cc('VISUAL', c.black, c.white),
        cc('VISUALNOS', c.black, c.white),

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
        fg('Variable', c.normal),
        fg('Special', c.orange),
        -- TODO: move Special to builtin color? and then fix escapse and suff?

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

        -- lua
        fg('@function.builtin.lua', c.builtin),
        fg('@constructor.lua', c.punctuation),
        fg('@variable.member.lua', c.gray7),
        fg('@function.call.lua', c.func),

        -- go
        fg('@lsp.type.type.go', c.primitave),
        fg('@constant.builtin.go', c.gray4),
        fg('@function.builtin.go', c.builtin),
        fg('@variable.parameter.go', c.gray4),
        fg('@variable.member.go', c.gray7),
        fg('@function.call.go', c.func),
        fg('@property.go', c.normal),

        -- zig
        fg('@lsp.type.type.zig', c.primitave),
        fg('@constant.builtin.zig', c.gray4),
        fg('@function.builtin.zig', c.builtin),
        fg('@lsp.type.builtin.zig', c.builtin),
        fg('@keyword.import.zig', c.builtin),
        fg('@function.call.zig', c.func),
        fg('@variable.parameter.zig', c.gray4),
        fg('@variable.member.zig', c.gray7),
        fg('@attribute.zig', c.keyword),

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
        fg('@markup.list.checked.markdown', c.sky),
        fg('@markup.strong', c.gray3),
        fg('@markup.italic', c.gray3),
        fg('@markup.strikethrough', c.gray3),
        fg('@markup.list.markdown', c.gray4),
        fg('@markup.link.label.markdown_inline', c.sky),
        fg('@markup.link.url.markdown_inline', c.gray3),
        fg('markdownCodeDelimiter', c.green),

        -- sql
        fg('sqlType', c.builtin),
        fg('sqlKeyword', c.gray7),
        fg('sqlStatement', c.gray7),
        fg('sqlVariable', c.primitave),

        -- bash
        fg('@function.builtin.bash', c.builtin),

        -- make
        fg('@function.builtin.make', c.builtin),
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
    vim.cmd("hi clear")
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
