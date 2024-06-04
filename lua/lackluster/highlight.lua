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
    return co(name, fg, 'none')
end

--- set only background
--- @param name string
--- @param bg string
local bg = function(name, bg)
    return co(name, 'none', bg)
end

--- set only options
--- @param name string
--- @param opts {[string]: any}
local op = function(name, opts)
    return co(name, 'none', 'none', opts)
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

local highlight = function(theme, color, special)
    return {
        -- TEXT
        co('Normal', theme.ui.fg_normal, theme.ui.bg_normal),
        fg('Title', theme.ui.fg_title),

        -- CURSOR
        co('CursorLine', color.none, theme.ui.bg_cursorline),
        fg('CursorLineNr', theme.ui.fg_line_num_cur),
        fg('LineNr', theme.ui.fg_line_num),
        bg('ColorColumn', theme.ui.bg_colorcolumn),

        -- SEARCH
        co('Search', theme.ui.fg_search, theme.ui.bg_search_item),
        co('CurSearch', theme.ui.fg_search, theme.ui.bg_search_cur),
        ln('IncSearch', 'CurSearch'),
        ln('Substitue', 'Search'),

        -- VISUAL
        co('VISUAL', theme.ui.fg_visual, theme.ui.bg_visual),
        ln('VISUALNOS', 'VISUAL'),

        -- MESSAGE
        fg('Error', theme.log.error),
        fg('ModeMsg', theme.log.info),
        fg('MsgArea', theme.log.info),
        ln('ErrorMsg', 'Error'),
        fg('WarningMsg', theme.log.warn),
        fg('NvimInternalError', theme.log.error),
        fg('healthError', theme.log.error),
        fg('healthSuccess', theme.log.success),
        fg('healthWarning', theme.log.warn),

        -- StatusLine
        co('StatusLine', color.gray7, theme.ui.bg_statusline_cur),
        co('StatusLineNC', color.gray4, theme.ui.bg_statusline),

        -- TABLINE
        co('Tabline', color.gray4, theme.ui.bg_tab),
        co('TablineFill', color.gray7, theme.ui.bg_statusline_cur),
        co('TablineSel', color.gray1, theme.ui.bg_tab_cur),

        -- FLOAT
        co('NormalFloat', theme.ui.fg_normal, theme.ui.bg_popup),
        co('FloatBorder', theme.ui.fg_border, theme.ui.bg_popup),
        fg('FloatTitle', theme.ui.fg_title),

        -- MENU
        co('Pmenu', theme.ui.fg_menu, theme.ui.bg_menu),
        co('PmenuSbar', theme.ui.bg_scrollbar, theme.ui.bg_scrollbar),
        co('PmenuThumb', theme.ui.fg_scrollbar, theme.ui.fg_scrollbar),
        co('PmenuSel', theme.ui.fg_search, theme.ui.bg_search_cur),

        -- OTHER UI
        fg('WinSeparator', theme.ui.fg_border),
        fg('EndOfBuffer', color.gray4),
        fg('QuickFixLine', color.green),

        -- SYNTAX
        fg('Identifier', theme.syntax.type),
        fg('Function', theme.syntax.func_call),
        fg('Type', theme.syntax.type),
        fg('Variable', theme.syntax.var),
        fg('Statement', theme.syntax.var),
        fg('Special', theme.syntax.special),
        fg('Keyword', theme.syntax.keyword),
        ln('Conditional', 'Keyword'),
        ln('Repeat', 'Keyword'),
        ln('Label', 'Keyword'),
        ln('Exception', 'Keyword'),
        ln('PreProc', 'Keyword'),

        -- CONSTANTS
        fg('Constant', theme.syntax.const),
        fg('String', theme.syntax.string),
        ln('Character', 'String'),
        ln('Number', 'Constant'),
        ln('Boolean', 'Constant'),
        ln('Float', 'Constant'),

        -- PUNCTUATION
        fg('Quote', theme.syntax.string),
        fg('Operator', theme.syntax.punctuation),
        fg('Delimiter', theme.syntax.punctuation),
        co('MatchParen', theme.ui.bg_search_cur, theme.ui.bg_search_item),

        -- COMMENT
        fg('Todo', theme.log.hint),
        fg('Question', theme.log.hint),
        fg('Comment', theme.syntax.comment),
        fg('SpecialComment', theme.syntax.comment),

        -- DIAGNOSTICS
        fg('DiagnosticOk', theme.diagnostic.text),
        fg('DiagnosticHint', theme.diagnostic.text),
        fg('DiagnosticInfo', theme.diagnostic.text),
        fg('DiagnosticWarn', theme.diagnostic.text),
        fg('DiagnosticError', theme.diagnostic.error),
        fg('DiagnosticDeprecated', theme.diagnostic.text),
        fg('DiagnosticUnnecessary', theme.diagnostic.text),

        fg('DiagnosticVirtualTextOk', theme.diagnostic.text),
        fg('DiagnosticVirtualTextHint', theme.diagnostic.text),
        fg('DiagnosticVirtualTextInfo', theme.diagnostic.text),
        fg('DiagnosticVirtualTextWarn', theme.diagnostic.text),
        fg('DiagnosticVirtualTextError', theme.diagnostic.error),

        fg('DiagnosticSignOk', theme.diagnostic.ok),
        fg('DiagnosticSignInfo', theme.diagnostic.info),
        fg('DiagnosticSignHint', theme.diagnostic.hint),
        fg('DiagnosticSignWarn', theme.diagnostic.warn),
        fg('DiagnosticSignError', theme.diagnostic.error),
        fg('DiagnosticSignDeprecated', theme.diagnostic.depricated),

        -- TREESITTER
        -- treesitter syntax
        fg('@keyword', theme.syntax.keyword),
        fg('@keyword.return', theme.syntax.keyword_return),
        fg('@keyword.exception', theme.syntax.keyword_exception),
        fg('@attribute', theme.syntax.keyword),
        fg('@type', theme.syntax.type),
        fg('@type.definition', theme.syntax.type_def),
        fg('@property', color.gray7),
        fg('@label', theme.ui.fg_title),

        -- treesitter variable
        fg('@variable', theme.syntax.var),
        fg('@variable.member', theme.syntax.var_member),

        -- treesistter constant
        fg('@constant', theme.syntax.const),
        fg('@boolean', theme.syntax.const),
        fg('@number', theme.syntax.const),

        -- treesitter punctuation
        fg('@operator', theme.syntax.punctuation),
        fg('@punctuation.bracket', theme.syntax.punctuation),
        fg('@punctuation.special', theme.syntax.punctuation),
        fg('@punctuation.delimiter', theme.syntax.punctuation),
        fg('@constructor', theme.syntax.punctuation),

        -- treesitter func
        fg('@function', theme.syntax.func_def),
        fg('@function.method', theme.syntax.func_def),
        fg('@function.call', theme.syntax.func_call),
        fg('@function.method.call', theme.syntax.func_call),
        fg('@variable.parameter', theme.syntax.func_param),

        -- treesiter string
        fg('@string', theme.syntax.string),
        fg('@character', theme.syntax.string),
        fg('@string.escape', theme.syntax.string_escape),
        fg('@string.special', theme.syntax.string_escape),
        fg('@string.regexp', theme.syntax.string_escape),

        -- treesitter comment
        -- QUESTION: not sure if (todo, note, warn should actual bye c.syntax.comment)
        -- if it ends up highlighting the whole line I thing i would prefer .comment
        fg('@comment', theme.syntax.comment),
        fg('@comment.todo', theme.diagnostic.hint),
        fg('@comment.note', theme.diagnostic.hint),
        fg('@comment.warn', theme.diagnostic.warn),
        fg('@comment.error', theme.diagnostic.error),
        fg('@comment.documentation', theme.syntax.comment),

        -- treesitter markup
        fg('@markup.heading', theme.ui.fg_title),
        fg('@markup.quote', color.gray6),

        fg('@markup.strong', color.gray4),
        fg('@markup.italic', color.gray4),
        fg('@markup.strikethrough', color.gray4),
        op('@markup.underline', {
            undercurl = true,
        }),

        fg('@markup.list', color.gray4),
        fg('@markup.list.checked', theme.syntax.string_escape),
        fg('@markup.list.unchecked', color.red),

        fg('@markup.link', color.gray6),
        fg('@markup.link.label', color.gray6),
        fg('@markup.link.url', color.gray4),

        fg('@markup.math', color.orange),

        -- treesitter tags
        fg('@tag', theme.syntax.tag),
        fg('@tag.delimiter', theme.syntax.tag),
        fg('@tag.attribute', color.gray4),

        -- treesitter builtin
        fg('@type.builtin', theme.syntax.type_primitave),
        fg('@tag.builtin', theme.syntax.tag),
        fg('@variable.builtin', theme.syntax.var),
        fg('@function.builtin', theme.syntax.builtin),
        fg('@module.builtin', theme.syntax.builtin),
        fg('@constant.builtin', theme.syntax.const_builtin),

        -- treesitter diff
        fg('@diff.pluss', theme.diff.add),
        fg('@diff.minus', theme.diff.delete),
        fg('@diff.delta', theme.diff.change),

        -- lsp links to treesiter
        ln('@lsp.type.keyword', '@keyword'),
        ln('@lsp.type.function', '@function'),
        ln('@lsp.type.variable', '@variable'),
        ln('@lsp.type.operator', '@operator'),
        ln('@lsp.type.type', '@type'),
        ln('@lsp.type.string', '@string'),
        ln('@lsp.type.number', '@number'),
        ln('@lsp.type.boolean', '@boolean'),
        ln('@lsp.type.enumMember', '@variable.memeber'),

        --spell
        op('SpellBad', {
            undercurl = true,
        }),
        ln('SpellLocal', 'SpellBad'),
        ln('SpellCap', 'SpellBad'),
        ln('SpellRare', 'SpellBad'),

        -- diff
        fg('Added', theme.diff.add),
        fg('Changed', theme.diff.change),
        fg('Removed', theme.diff.delete),
        fg('DiffAdd', theme.diff.add),
        fg('DiffChange', theme.diff.change),
        fg('DiffDelete', theme.diff.delete),
        fg('DiffText', theme.diff.info),
        fg('DiffAdded', theme.diff.add),
        fg('DiffRemoved', theme.diff.delete),
        fg('DiffChanged', theme.diff.change),
        fg('DiffOldFile', theme.diff.info),
        fg('DiffNewFile', theme.diff.add),
        fg('DiffFile', theme.diff.change),
        fg('DiffLine', theme.diff.change),
        fg('DiffIndexLine', theme.diff.info),

        -- lisp
        fg('@string.special.symbol.clojure', theme.syntax.type), -- :symbols
        ln('lispFunc', '@variable.parameter'),
        ln('lispSymbol', "@variable"),
        ln('lispDecl', "@keyword"),

        -- zsh
        fg('zshFunction', theme.syntax.func_def),

        -- json,yaml,toml
        fg('@property.json', color.gray6),
        fg('@property.yaml', color.gray6),
        fg('@property.toml', color.gray6),
        fg('@type.toml', color.gray8),

        -- xml
        fg('xmlTag', color.gray5),
        fg('xmlTagName', color.gray5),
        fg('xmlAttrib', color.gray4),

        -- html
        fg('htmlTagName', theme.syntax.tag),

        -- text
        fg('texStatement', color.gray5),
        fg('texDefCmd', color.gray5),
        fg('texDefName', color.gray5),
        fg('texDocType', color.gray5),
        fg('texDocZone', color.gray5),
        fg('texDocAbstract', color.gray5),
        fg('texBeginEnd', color.gray5),

        -- css
        fg('cssMediaProp', theme.ui.fg_normal),
        fg('cssTransitionProp', theme.ui.fg_normal),
        fg('cssTextProp', theme.ui.fg_normal),
        fg('cssBoxProp', theme.ui.fg_normal),
        fg('cssFontProp', theme.ui.fg_normal),
        fg('cssPositioningProp', theme.ui.fg_normal),
        fg('cssBorderProp', theme.ui.fg_normal),
        fg('cssBackgroundProp', theme.ui.fg_normal),
        fg('cssTransformProp', theme.ui.fg_normal),
        fg('@property.css', theme.ui.fg_normal),
        fg('@tag.css', theme.ui.fg_normal),

        -- markdown
        fg('markdownCodeDelimiter', color.green),
        fg('markdownLinkDelimiter', color.gray6),
        ln('markdownLinkTextDelimiter', '@markup.link'),
        ln('markdownLinkText', '@markup.link'),
        ln('markdownUrl', '@markup.link.url'),

        -- sql
        fg('sqlType', theme.syntax.string),
        fg('sqlKeyword', theme.syntax.keyword),
        fg('sqlStatement', theme.syntax.keyword),
        fg('sqlVariable', theme.syntax.special),

        -- make
        fg('@string.special.symbol.make', theme.syntax.string),
        fg('makeSpecial', theme.syntax.special),

        -- telescope
        co('TelescopeNormal', theme.ui.fg_telescope, theme.ui.bg_telescope),
        co('TelescopeTitle', theme.ui.fg_telescope, theme.ui.bg_telescope),
        co('TelescopeResultsNormal', color.gray5, theme.ui.bg_telescope),
        co('TelescopeSelection', color.gray8, color.gray3),
        op('TelescopeMatching', { italic = true, }),
        fg('TelescopeMultiSelection', color.gray8),
        fg('TelescopeMultiIcon', color.gray8),
        fg('TelescopePromptPrefix', theme.ui.fg_normal),
        co('TelescopeBorder', color.gray7, theme.ui.bg_telescope),
        co('TelescopePreviewLine', color.black, color.gray9),
        co('TelescopePreviewMatch', color.black, color.gray9),
        fg('TelescopePromptCounter', color.gray7),
        fg('TelescopeResultsSpecialComment', color.gray5),
        fg('TelescopeResultsDiffUntracked', color.gray5),
        fg('TelescopeResultsIdentifier', color.gray5),
        fg('TelescopeResultsDiffDelete', color.gray5),
        fg('TelescopeResultsDiffChange', color.gray5),
        fg('TelescopeResultsVariable', color.gray5),
        fg('TelescopeResultsOperator', color.gray5),
        fg('TelescopeResultsFunction', color.gray5),
        fg('TelescopeResultsConstant', color.gray5),
        fg('TelescopeResultsDiffAdd', color.gray5),
        fg('TelescopeResultsComment', color.gray5),
        fg('TelescopeResultsSymbol', color.gray5),
        fg('TelescopeResultsStruct', color.gray5),
        fg('TelescopeResultsNumber', color.gray5),
        fg('TelescopeResultsMethod', color.gray5),
        fg('TelescopeResultsLineNr', color.gray5),
        fg('TelescopeResultsField', color.gray5),
        fg('TelescopeResultsClass', color.gray5),

        -- nvim_cmp
        fg('CmpItemKind', color.gray7),
        fg('CmpItemKindSnippet', color.lack),
        fg('CmpItemAbbrDeprecated', color.gray4),

        -- which-key.nvim
        fg('WhichKey', color.gray5),
        fg('WhichKeyGroup', color.lack),
        fg('WhichKeyDesc', color.gray5),
        fg('WhichKeySeparator', color.gray4),

        -- oil.nvim
        fg('Directory', theme.fs.dir),
        fg('OilFile', theme.fs.file),
        fg('OilDir', theme.fs.dir),
        fg('OilDirIcon', theme.fs.dir),
        fg('OilLink', theme.fs.link),
        ln('OilLinkTarget', 'OilLink'),
        fg('OilSocket', theme.fs.socket),
        fg('OilCreate', theme.diff.add),
        fg('OilCopy', theme.diff.add),
        fg('OilRestore', theme.diff.add),
        fg('OilDelete', theme.diff.delete),
        fg('OilPurge', theme.diff.delete),
        fg('OilTrash', theme.diff.delete),
        fg('OilTrashSourcePath', theme.diff.delete),
        fg('OilMove', theme.diff.change),
        fg('OilChange', theme.diff.change),

        -- gitsigns.nvim
        fg('GitSignsAdd', theme.diff.info),
        fg('GitSignsChange', theme.diff.change),
        fg('GitSignsDelete', theme.diff.delete),

        -- git gutter
        fg('GitGutterAdd', theme.diff.info),
        fg('GitGutterAddLineNr', theme.diff.info),
        fg('GitGutterChange', theme.diff.change),
        fg('GitGutterChangeLineNr', theme.diff.change),
        fg('GitGutterDelete', theme.diff.delete),
        fg('GitGutterDeleteLineNr', theme.diff.delete),

        -- mini.diff
        fg('MiniDiffSignAdd', theme.diff.info),
        fg('MiniDiffSignChange', theme.diff.change),
        fg('MiniDiffSignDelete', theme.diff.delete),

        -- todo-comments.nvim
        fg('TodoBgTodo', theme.log.hint),
        fg('TodoBgWarn', theme.log.warn),
        fg('TodoBgFix', theme.log.error),
        fg('TodoFgFix', theme.log.error),
        fg('TodoFgTodo', theme.syntax.comment),
        ln('TodoBgNote', 'TodoBgTodo'),
        ln('TodoBgPerf', 'TodoBgTodo'),
        ln('TodoBgHack', 'TodoBgWarn'),
        ln('TodoFgNote', 'TodoFgTodo'),
        ln('TodoFgPerf', 'TodoFgTodo'),
        ln('TodoFgWarn', 'TodoFgTodo'),
        ln('TodoFgHack', 'TodoFgTodo'),

        -- nvim-darkbulb
        fg('lightbulbSign', theme.diagnostic.text),

        -- nvim-lspconfig
        fg('lspInfoTip', color.gray5),

        -- lazy.nvim
        co('LazyNormal', color.gray8, theme.ui.bg_popup),
        co('LazyButton', color.gray5, theme.ui.bg_popup),
        fg('LazySpecial', color.gray5),
        co('LazyButtonActive', color.gray4, color.gray8),
        ln('LazyH1', 'LazyButtonActive'),
        fg('LazyComment', color.lack),

        -- mason.nvim
        fg('MasonHighlight', color.lack),
        co('MasonHeader', color.lack, theme.ui.bg_popup),
        co('MasonHighlightBlockBold', color.gray5, color.gray8),
        co('MasonHighlightBlock', color.gray4, color.gray8),
        co('MasonMutedBlock', color.gray5, theme.ui.bg_popup),

        -- trouble.nvim
        co('TroubleNormal', color.gray5, theme.ui.bg_popup),
        fg('TroubleSource', color.gray5),
        fg('TroubleCode', color.gray6),
        fg('TroubleLocation', color.gray5),
        fg('TroubleInformation', color.gray7),
        fg('TroubleTextError', theme.diagnostic.error),
        fg('TroubleTextWarning', color.gray7),

        -- nvim tree
        fg('NvimTreeExecFile', theme.fs.exec),
        fg('NvimTreeSymlink', theme.fs.link),
        fg('NvimTreeSymlinkIcon', theme.fs.link),
        fg('NvimTreeSymlinkFolderName', theme.fs.link),
        fg('NvimTreeSpecialFile', theme.fs.binary_data),
        fg('NvimTreeImageFile', theme.fs.binary_data),
        fg('NvimTreeRootFolder', theme.fs.dir),
        fg('NvimTreeFolder', theme.fs.dir),
        fg('NvimTreeFolderIcon', theme.fs.dir),
        fg('NvimTreeBookmarkIcon', color.lack),
        fg('NvimTreeBookmarkHl', color.lack),
        fg('NvimTreeGitDeletedIcon', theme.diff.delete),
        fg('NvimTreeGitMergeIcon', theme.diff.change),
        fg('NvimTreeGitRenamedIcon', theme.diff.change),
        fg('NvimTreeGitNewIcon', theme.diff.add),
        fg('NvimTreeGitDirtyIcon', theme.diff.change),
        fg('NvimTreeModifiedIcon', theme.diff.change),
        co('NvimTreeWindowPicker', color.gray8, color.lack),
        fg('NvimTreeDiagnosticErrorFileHl', theme.diagnostic.error),
        fg('NvimTreeDiagnosticInfoFileHl', theme.diagnostic.info),
        fg('NvimTreeDiagnosticHintFileHl', theme.diagnostic.hint),
        fg('NvimTreeDiagnosticWarnFileHl', theme.diagnostic.warn),

        -- flash.nvm
        co('FlashLabel', special.popup_background, color.blue),
        co('FlashMatch', color.gray6, special.main_background),
        co('FlashCurrent', color.black, color.gray9),

        -- rainbow-delimiters.nvim
        fg('RainbowDelimiterRed', theme.rainbow.red),
        fg('RainbowDelimiterYellow', theme.rainbow.yellow),
        fg('RainbowDelimiterBlue', theme.rainbow.blue),
        fg('RainbowDelimiterOrange', theme.rainbow.orange),
        fg('RainbowDelimiterGreen', theme.rainbow.green),
        fg('RainbowDelimiterViolet', theme.rainbow.violet),
        fg('RainbowDelimiterCyan', theme.rainbow.cyan),
    }
end

return highlight
