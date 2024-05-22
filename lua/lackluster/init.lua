local M = {}

M.col = {
    red = "#D70000",
    blue = '#7788AA',
    green = "#789978",
    orange = '#ffaa88',

    luster = "#cfecf3",
    lack = '#5d656d',

    black = '#000000',
    white = '#ffffff',

    -- if the status bar value is slightly offset from all grays used in the normal config
    -- it allways looks good against popups
    _gray_stausbar_only = '#222222',

    gray1 = "#080808",
    gray2 = "#191919",
    gray3 = "#2a2a2a",
    gray4 = "#444444",
    gray5 = "#555555",
    gray6 = "#7a7a7a",
    gray7 = "#aaaaaa",
    gray8 = "#cccccc",
    none = "none",
}

M.col.log = {
    success = M.col.green,
    info = M.col.luster,
    warn = M.col.orange,
    error = M.col.red,
    hint = M.col.blue,
}

M.col.diagnostic = {
    -- NOTE: text often is used for hover/virtual text and the colors are used as signs
    -- this reduces visual noise (except for error text which should always be red)
    text = M.col.gray4,
    ok = M.col.green,
    hint = M.col.blue,
    error = M.col.red,
    info = M.col.blue,
    warn = M.col.orange,
    unnecessary = M.col.gray4,
    depricated = M.col.orange,
}

M.col.fs = {
    dir = M.col.lack,
    file = M.col.luster,
    link = M.col.blue,
    link_target = M.col.blue,
    socket = M.col.orange,
}

M.col.diff = {
    add = M.col.green,
    change = M.col.blue,
    delete = M.col.orange,
    info = M.col.gray5,
}

M.col.ui = {
    normal        = M.col.gray8,
    title         = M.col.gray7,
    visual_bg     = M.col.white,
    visual_fg     = M.col.black,
    search_fg     = M.col.black,
    search_inc_bg = M.col.lack,
    search_cur_bg = M.col.white,
    cursorline    = M.col.gray2,
    colorcolumn   = M.col.black,
    menu_bg       = M.col.gray2,
    menu_fg       = M.col.gray6,
    line_num      = M.col.gray4,
    line_num_cur  = M.col.gray7,
    win_seperator = M.col.lack,
}

M.col.syntax = {
    var = M.col.gray8,
    const = M.col.gray7,
    const_builtin = M.col.gray5,
    func = M.col.gray7,
    func_builtin = M.col.gray4,
    func_param = M.col.gray5,
    special = M.col.lack,
    type = M.col.gray7,
    type_primitave = M.col.gray7,
    keyword = M.col.gray6,
    str = M.col.lack,
    str_esc = M.col.blue,
    punctuation = M.col.gray6,
    comment = M.col.gray3,
    documentation = M.col.gray4,
}

local c = M.col

--- create a color spec
--- @param fg string
--- @param bg string
--- @param opts ?{[string]:any}
local co = function(name, fg, bg, opts)
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

--- set only foreground
--- @param name string
--- @param fg string
local fg = function(name, fg)
    return co(name, fg, c.none)
end

--- set only background
--- @param name string
--- @param bg string
local bg = function(name, bg)
    return co(name, c.none, bg)
end

--- set only options
--- @param name string
--- @param opts {[string]: any}
local op = function(name, opts)
    return co(name, c.none, c.none, opts)
end

--- create a hi link
--- @param name string
--- @param link string
local ln = function(name, link)
    return {
        name = name,
        link = link,
    }
end

M.theme = function()
    return {
        -- TEXT
        co('Normal', c.ui.normal, '#0a0a0a'),
        fg('Title', c.ui.title),
        op('Spell', {
            underline = true,
        }),

        -- CURSOR
        co('CursorLine', c.none, c.ui.cursorline),
        fg('CursorLineNr', c.ui.line_num_cur),
        fg('LineNr', c.ui.line_num),
        bg('ColorColumn', c.ui.colorcolumn),

        -- SEARCH
        co('Search', c.ui.search_fg, c.ui.search_inc_bg),
        co('CurSearch', c.ui.search_fg, c.ui.search_cur_bg),
        ln('IncSearch', 'CurSearch'),

        -- VISUAL
        co('VISUAL', c.ui.visual_fg, c.ui.visual_bg),
        ln('VISUALNOS', 'VISUAL'),

        -- message
        fg('Error', c.log.error),
        ln('ErrorMsg', 'Error'),
        fg('WarningMsg', c.log.warn),
        fg('ModeMsg', c.log.info),
        fg('MsgArea', c.log.info),

        -- UI
        co('StatusLine', c.gray7, c._gray_stausbar_only),
        co('StatusLineNC', c.gray4, c.gray1),
        co('Tabline', c.gray4, c.gray2),
        co('TablineFill', c.gray7, c._gray_stausbar_only),
        co('TablineSel', c.gray1, c.gray8),
        co('NormalFloat', c.ui.normal, c.ui.menu_bg),
        co('FloatTitle', c.ui.normal, c.ui.menu_bg),
        co('FloatBorder', c.ui.normal, c.ui.menu_bg),
        co('Pmenu', c.ui.menu_fg, c.ui.menu_bg),
        co('PmenuThumb', c.ui.menu_fg, c.ui.menu_bg),
        co('PmenuSel', c.ui.search_fg, c.ui.search_cur_bg),
        fg('WinSeparator', c.ui.win_seperator),
        fg('EndOfBuffer', c.gray4),

        -- SYNTAX
        fg('Identifier', c.syntax.type),
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
        co('MatchParen', c.ui.search_cur_bg, c.ui.search_inc_bg),

        -- comment
        fg('Todo', c.log.hint),
        fg('Comment', c.syntax.comment),
        fg('SpecialComment', c.syntax.documentation),

        -- diagnostics
        fg('DiagnosticOk', c.diagnostic.text),
        fg('DiagnosticHint', c.diagnostic.text),
        fg('DiagnosticInfo', c.diagnostic.text),
        fg('DiagnosticWarn', c.diagnostic.text),
        fg('DiagnosticError', c.diagnostic.error),
        fg('DiagnosticDeprecated', c.diagnostic.text),
        fg('DiagnosticUnnecessary', c.diagnostic.text),

        fg('DiagnosticVirtualTextOk', c.diagnostic.text),
        fg('DiagnosticVirtualTextHint', c.diagnostic.text),
        fg('DiagnosticVirtualTextInfo', c.diagnostic.text),
        fg('DiagnosticVirtualTextWarn', c.diagnostic.text),
        fg('DiagnosticVirtualTextError', c.diagnostic.error),

        fg('DiagnosticSignOk', c.diagnostic.ok),
        fg('DiagnosticSignInfo', c.diagnostic.info),
        fg('DiagnosticSignHint', c.diagnostic.hint),
        fg('DiagnosticSignWarn', c.diagnostic.warn),
        fg('DiagnosticSignError', c.diagnostic.error),
        fg('DiagnosticSignDeprecated', c.diagnostic.depricated),

        -- treesitter overrides
        fg('@punctuation.bracket', c.syntax.punctuation),
        fg('@punctuation.special', c.syntax.punctuation),
        fg('@punctuation.delimiter', c.syntax.punctuation),
        fg('@constructor', c.syntax.punctuation),
        fg('@variable', c.syntax.var),
        fg('@property', c.luster),
        fg('@type.builtin', c.syntax.type_primitave),
        fg('@function', c.syntax.func),
        fg('@function.call', c.syntax.func),
        fg('@function.builtin', c.syntax.func_builtin),
        fg('@variable.parameter', c.syntax.func_param),
        fg('@constant.builtin', c.syntax.const_builtin),
        fg('@variable.member', c.syntax.type),
        fg('@attribute', c.syntax.keyword),
        fg('@string.escape', c.syntax.str_esc),
        fg('@comment.documentation', c.syntax.documentation),

        -- neovim
        fg('NvimInternalError', c.log.error),
        fg('healthError', c.log.error),
        fg('healthSuccess', c.log.success),
        fg('healthWarning', c.log.warn),

        -- diff
        fg('Added', c.diff.add),
        fg('Changed', c.diff.change),
        fg('Removed', c.diff.delete),
        fg('DiffAdd', c.diff.add),
        fg('DiffChange', c.diff.change),
        fg('DiffDelete', c.diff.delete),
        fg('DiffText', c.diff.info),
        fg('DiffAdded', c.diff.add),
        fg('DiffRemoved', c.diff.delete),
        fg('DiffChanged', c.diff.change),
        fg('DiffOldFile', c.diff.info),
        fg('DiffNewFile', c.diff.add),
        fg('DiffFile', c.diff.change),
        fg('DiffLine', c.diff.change),
        fg('DiffIndexLine', c.diff.info),

        -- go
        fg('@type.builtin.go', c.gray5),
        fg('@variable.parameter.go', c.gray8),
        fg('@function.go', c.gray6),

        -- lua
        fg('@keyword.function.lua', c.lack),

        -- zig
        fg('@keyword.import.zig', c.syntax.func_builtin),
        fg('@variable.member.zig', c.gray6),

        -- zsh
        fg('zshFunction', c.syntax.func),

        -- json,yaml,toml
        fg('@property.json', c.gray5),
        fg('@property.yaml', c.gray5),
        fg('@property.toml', c.gray5),

        -- xml
        fg('xmlTag', c.gray5),
        fg('xmlTagName', c.gray5),
        fg('xmlAttrib', c.gray4),

        -- html
        fg('htmlTagName', c.gray5),
        fg('@tag', c.gray5),
        fg('@tag.delimiter', c.gray5),
        fg('@tag.attribute', c.gray4),

        -- text
        fg('texStatement', c.gray5),
        fg('texDefCmd', c.gray5),
        fg('texDefName', c.gray5),
        fg('texDocType', c.gray5),
        fg('texDocZone', c.gray5),
        fg('texDocAbstract', c.gray5),
        fg('texBeginEnd', c.gray5),

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
        fg('@markup.quote', c.gray6),
        fg('@markup.list.unchecked', c.red),
        fg('@markup.list.checked', c.syntax.str_esc),
        fg('@markup.strong', c.gray4),
        fg('@markup.italic', c.gray4),
        fg('@markup.strikethrough', c.gray4),
        fg('@markup.list', c.gray4),
        fg('@markup.link', c.gray6),
        fg('@markup.link.label', c.gray6),
        fg('@markup.link.url', c.gray4),
        fg('@markup.math', c.orange),
        fg('markdownCodeDelimiter', c.green),
        fg('markdownLinkDelimiter', c.gray6),

        -- sql
        fg('sqlType', c.syntax.str),
        fg('sqlKeyword', c.syntax.keyword),
        fg('sqlStatement', c.syntax.keyword),
        fg('sqlVariable', c.syntax.special),

        -- javascript
        -- NOTE: warn because js builtins are sketchy and throw errors when not expected
        fg("@function.builtin.javascript", c.log.warn),
        fg("@function.builtin.typescript", c.log.warn),
        fg("@keyword.exception.javascript", c.log.warn),
        fg("@keyword.exception.typescript", c.log.warn),

        -- make
        fg('@string.special.symbol.make', c.syntax.str),
        fg('makeSpecial', c.syntax.special),

        -- telescope
        fg('TelescopeNormal', c.ui.normal),
        fg('TelescopeResultsNormal', c.gray5),
        fg('TelescopeMatching', c.gray4),
        fg('TelescopeBorder', c.gray4),
        fg('TelescopeMultiSelection', c.green),
        fg('TelescopeMultiIcon', c.green),
        fg('TelescopePromptPrefix', c.gray6),
        fg('TelescopePromptCounter', c.blue),
        co('TelescopeSelection', c.gray1, c.white),

        -- nvim_cmp
        fg('CmpItemKind', c.gray7),
        fg('CmpItemKindSnippet', c.lack),
        fg('CmpItemAbbrDeprecated', c.gray4),

        -- which-key.nvim
        fg('WhichKey', c.gray4),
        fg('WhichKeyGroup', c.lack),
        fg('WhichKeyDesc', c.gray4),
        fg('WhichKeySeparator', c.gray3),

        -- oil.nvim
        fg('Directory', c.fs.dir),
        fg('OilFile', c.fs.file),
        fg('OilDir', c.fs.dir),
        fg('OilDirIcon', c.fs.dir),
        fg('OilLink', c.fs.link),
        ln('OilLinkTarget', 'OilLink'),
        fg('OilSocket', c.fs.socket),
        fg('OilCreate', c.diff.add),
        fg('OilCopy', c.diff.add),
        fg('OilRestore', c.diff.add),
        fg('OilDelete', c.diff.delete),
        fg('OilPurge', c.diff.delete),
        fg('OilTrash', c.diff.delete),
        fg('OilTrashSourcePath', c.diff.delete),
        fg('OilMove', c.diff.change),
        fg('OilChange', c.diff.change),

        -- gitsigns.nvim
        fg('GitSignsAdd', c.diff.info),
        fg('GitSignsChange', c.diff.change),
        fg('GitSignsDelete', c.diff.delete),

        -- git gutter
        fg('GitGutterAdd', c.diff.info),
        fg('GitGutterAddLineNr', c.diff.info),
        fg('GitGutterChange', c.diff.change),
        fg('GitGutterChangeLineNr', c.diff.change),
        fg('GitGutterDelete', c.diff.delete),
        fg('GitGutterDeleteLineNr', c.diff.delete),

        -- mini.diff
        fg('MiniDiffSignAdd', c.diff.info),
        fg('MiniDiffSignChange', c.diff.change),
        fg('MiniDiffSignDelete', c.diff.delete),

        -- todo-comments.nvim
        fg('TodoBgTodo', c.blue),
        fg('TodoBgNote', c.blue),
        ln('TodoBgPerf', 'TodoBgNote'),
        fg('TodoBgWarn', c.log.warn),
        ln('TodoBgHack', 'TodoBgWarn'),
        fg('TodoBgFix', c.log.error),
        fg('TodoFgFix', c.log.error),
        fg('TodoFgTodo', c.gray4),
        ln('TodoFgNote', 'TodoFgTodo'),
        ln('TodoFgPerf', 'TodoFgTodo'),
        ln('TodoFgWarn', 'TodoFgTodo'),
        ln('TodoFgHack', 'TodoFgTodo'),

        -- nvim-lightbulb
        fg('LightBulbSign', c.diagnostic.text),

        -- lazy.nvim
        co('LazyNormal', c.gray8, c.gray3),
        co('LazyButton', c.gray6, c.gray3),
        co('LazyButtonActive', c.gray5, c.gray2),
        co('LazyH1', c.gray5, c.gray2),
        fg('LazyComment', c.lack),
        fg('LazySpecial', c.gray2),

        -- trouble.nvim
        co('TroubleNormal', c.gray5, c.gray2),
        fg('TroubleSource', c.gray5),
        fg('TroubleCode', c.gray6),
        fg('TroubleLocation', c.gray5),
        fg('TroubleInformation', c.gray7),
        fg('TroubleTextError', c.diagnostic.error),
        fg('TroubleTextWarning', c.gray7),
    }
end

M.load = function()
    local dedup_set = {}

    for _, hi_spec in ipairs(M.theme()) do
        local name = hi_spec.name
        if dedup_set[name] then
            vim.notify("error: duplicate hilight :: " .. name, vim.log.levels.ERROR)
        else
            dedup_set[name] = true
            hi_spec.name = nil
            vim.api.nvim_set_hl(0, name, hi_spec)
        end
    end
end

return M
