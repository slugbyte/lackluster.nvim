local spec = require("lackluster.spec")

---@class LacklusterHighlightGroup
---@field plugin_name ?string
---@field dont_skip ?boolean -- force highlights to run if true
---@field highlight LacklusterHighlightSpec[]

-- TODO: ?? refactor theme and highlight() so that highlight() does not need color or special

---@param theme LacklusterTheme
---@return LacklusterHighlightGroup[]
local highlight = function(theme, color)
    return {
        {
            dont_skip = true,
            highlight = {
                -- TEXT
                spec.co("Normal", theme.ui.fg_normal, theme.ui.bg_normal),
                spec.fg("Title", theme.ui.fg_title),
                spec.fg("Whitespace", theme.ui.fg_whitespace),

                -- NON TEXT
                spec.fg("NonText", color.gray5),

                -- CURSOR
                spec.co("SignColumn", theme.ui.fg_line_num, theme.ui.bg_normal),
                spec.co("CursorLine", theme.none, theme.ui.bg_cursorline),
                spec.fg("CursorLineNr", theme.ui.fg_line_num_cur),
                spec.fg("LineNr", theme.ui.fg_line_num),
                spec.bg("ColorColumn", theme.ui.bg_colorcolumn),

                -- SEARCH
                spec.co("Search", theme.ui.fg_search, theme.ui.bg_search_item),
                spec.co("CurSearch", theme.ui.fg_search, theme.ui.bg_search_cur),
                spec.ln("IncSearch", "CurSearch"),
                spec.ln("Substitute", "Search"),

                -- VISUAL
                spec.co("VISUAL", theme.ui.fg_visual, theme.ui.bg_visual),
                spec.ln("VISUALNOS", "VISUAL"),

                -- FOLD
                spec.fg("Folded", color.gray4),
                spec.fg("FoldColumn", color.gray4),

                -- MESSAGE
                spec.fg("Error", theme.log.error),
                spec.fg("ModeMsg", theme.log.info),
                spec.fg("MoreMsg", theme.log.info),
                spec.fg("MsgArea", theme.log.info),
                spec.ln("ErrorMsg", "Error"),
                spec.fg("WarningMsg", theme.log.warn),
                spec.fg("NvimInternalError", theme.log.error),
                spec.fg("healthError", theme.log.error),
                spec.fg("healthSuccess", theme.log.success),
                spec.fg("healthWarning", theme.log.warn),

                -- StatusLine
                spec.co("StatusLine", theme.ui.fg_statusline, theme.ui.bg_statusline),
                spec.co("StatusLineNC", theme.ui.fg_statusline_nc, theme.ui.bg_statusline_nc),

                -- TABLINE
                spec.co("Tabline", theme.ui.fg_tab_nc, theme.ui.bg_tab_nc),
                spec.co("TablineSel", theme.ui.fg_tab_active, theme.ui.bg_tab_active),
                spec.co("TablineFill", theme.ui.fg_statusline, theme.ui.bg_statusline),

                -- FLOAT
                spec.co("NormalFloat", theme.ui.fg_normal, theme.ui.bg_popup),
                spec.co("FloatBorder", theme.ui.fg_border, theme.ui.bg_popup),
                spec.fg("FloatTitle", theme.ui.fg_title),

                -- MENU
                spec.co("Pmenu", theme.ui.fg_menu, theme.ui.bg_menu),
                spec.co("PmenuSbar", theme.ui.bg_scrollbar, theme.ui.bg_scrollbar),
                spec.co("PmenuThumb", theme.ui.fg_scrollbar, theme.ui.fg_scrollbar),
                spec.co("PmenuSel", theme.ui.fg_search, theme.ui.bg_search_cur),

                -- OTHER UI
                spec.fg("WinSeparator", theme.ui.fg_border),
                spec.fg("EndOfBuffer", theme.ui.fg_end_of_buffer),
                spec.fg("QuickFixLine", color.green),

                -- SYNTAX
                spec.fg("Identifier", theme.syntax.type),
                spec.fg("Function", theme.syntax.func_call),
                spec.fg("Type", theme.syntax.type),
                spec.fg("Variable", theme.syntax.var),
                spec.fg("Statement", theme.syntax.keyword),
                spec.fg("Special", theme.syntax.special),
                spec.fg("Keyword", theme.syntax.keyword),
                spec.ln("Conditional", "Keyword"),
                spec.ln("Repeat", "Keyword"),
                spec.ln("Label", "Keyword"),
                spec.ln("Exception", "Keyword"),
                spec.ln("PreProc", "Keyword"),

                -- CONSTANTS
                spec.fg("Constant", theme.syntax.const),
                spec.fg("String", theme.syntax.string),
                spec.ln("Character", "String"),
                spec.ln("Number", "Constant"),
                spec.ln("Boolean", "Constant"),
                spec.ln("Float", "Constant"),

                -- PUNCTUATION
                spec.fg("Quote", theme.syntax.string),
                spec.fg("Operator", theme.syntax.punctuation),
                spec.fg("Delimiter", theme.syntax.punctuation),
                spec.co("MatchParen", theme.ui.bg_search_cur, theme.ui.bg_search_item),

                -- COMMENT
                spec.fg("Todo", theme.log.hint),
                spec.fg("Question", theme.log.hint),
                spec.fg("Comment", theme.syntax.comment),
                spec.fg("SpecialComment", theme.syntax.comment),

                -- DIAGNOSTICS
                spec.fg("DiagnosticOk", theme.diagnostic.text),
                spec.fg("DiagnosticHint", theme.diagnostic.text),
                spec.fg("DiagnosticInfo", theme.diagnostic.text),
                spec.fg("DiagnosticWarn", theme.diagnostic.text),
                spec.fg("DiagnosticError", theme.diagnostic.error),
                spec.fg("DiagnosticDeprecated", theme.diagnostic.text),
                spec.fg("DiagnosticUnnecessary", theme.diagnostic.text),

                spec.fg("DiagnosticVirtualTextOk", theme.diagnostic.text),
                spec.fg("DiagnosticVirtualTextHint", theme.diagnostic.text),
                spec.fg("DiagnosticVirtualTextInfo", theme.diagnostic.text),
                spec.fg("DiagnosticVirtualTextWarn", theme.diagnostic.text),
                spec.fg("DiagnosticVirtualTextError", theme.diagnostic.error),

                spec.fg("DiagnosticSignOk", theme.diagnostic.ok),
                spec.fg("DiagnosticSignInfo", theme.diagnostic.info),
                spec.fg("DiagnosticSignHint", theme.diagnostic.hint),
                spec.fg("DiagnosticSignWarn", theme.diagnostic.warn),
                spec.fg("DiagnosticSignError", theme.diagnostic.error),
                spec.fg("DiagnosticSignDeprecated", theme.diagnostic.deprecated),

                spec.op("DiagnosticUnderlineWarn", {
                    undercurl = theme.ui.use_undercurl,
                    underline = not theme.ui.use_undercurl,
                    sp = theme.diagnostic.warn,
                }),
                spec.op("DiagnosticUnderlineInfo", {
                    undercurl = theme.ui.use_undercurl,
                    underline = not theme.ui.use_undercurl,
                    sp = theme.diagnostic.info,
                }),
                spec.op("DiagnosticUnderlineHint", {
                    undercurl = theme.ui.use_undercurl,
                    underline = not theme.ui.use_undercurl,
                    sp = theme.diagnostic.hint,
                }),
                spec.op("DiagnosticUnderlineError", {
                    undercurl = theme.ui.use_undercurl,
                    underline = not theme.ui.use_undercurl,
                    sp = theme.diagnostic.error,
                }),

                -- treesitter syntax
                spec.fg("@keyword", theme.syntax.keyword),
                spec.fg("@keyword.return", theme.syntax.keyword_return),
                spec.fg("@keyword.exception", theme.syntax.keyword_exception),
                spec.fg("@attribute", theme.syntax.keyword),
                spec.fg("@type", theme.syntax.type),
                spec.fg("@type.definition", theme.syntax.type_def),
                spec.fg("@property", color.gray7),
                spec.fg("@label", theme.ui.fg_title),

                -- treesitter variable
                spec.fg("@variable", theme.syntax.var),
                spec.fg("@variable.member", theme.syntax.var_member),

                -- treesistter constant
                spec.fg("@constant", theme.syntax.const),
                spec.fg("@boolean", theme.syntax.const),
                spec.fg("@number", theme.syntax.const),

                -- treesitter punctuation
                spec.fg("@operator", theme.syntax.punctuation),
                spec.fg("@punctuation.bracket", theme.syntax.punctuation),
                spec.fg("@punctuation.special", theme.syntax.punctuation),
                spec.fg("@punctuation.delimiter", theme.syntax.punctuation),
                spec.fg("@constructor", theme.syntax.punctuation),

                -- treesitter func
                spec.fg("@function", theme.syntax.func_def),
                spec.fg("@function.method", theme.syntax.func_def),
                spec.fg("@function.call", theme.syntax.func_call),
                spec.fg("@function.method.call", theme.syntax.func_call),
                spec.fg("@variable.parameter", theme.syntax.func_param),

                -- treesiter string
                spec.fg("@string", theme.syntax.string),
                spec.fg("@character", theme.syntax.string),
                spec.fg("@string.escape", theme.syntax.string_escape),
                spec.fg("@string.special", theme.syntax.string_escape),
                spec.fg("@string.regexp", theme.syntax.string_escape),

                -- treesitter comment
                -- QUESTION: not sure if (todo, note, warn should actual bye c.syntax.comment)
                -- if it ends up highlighting the whole line I thing i would prefer .comment
                spec.fg("@comment", theme.syntax.comment),
                spec.fg("@comment.todo", theme.diagnostic.hint),
                spec.fg("@comment.note", theme.diagnostic.hint),
                spec.fg("@comment.warn", theme.diagnostic.warn),
                spec.fg("@comment.error", theme.diagnostic.error),
                spec.fg("@comment.documentation", theme.syntax.comment),

                -- treesitter markup
                spec.fg("@markup.heading", theme.ui.fg_title),
                spec.fg("@markup.quote", color.gray6),
                spec.fg("@markup.strong", color.gray4),
                spec.fg("@markup.italic", color.gray4),
                spec.fg("@markup.strikethrough", color.gray4),
                spec.op("@markup.underline", {
                    underline = true,
                }),

                spec.fg("@markup.list", color.gray4),
                spec.fg("@markup.list.checked", theme.syntax.string_escape),
                spec.fg("@markup.list.unchecked", color.red),

                spec.fg("@markup.link", color.gray6),
                spec.fg("@markup.link.label", color.gray6),
                spec.fg("@markup.link.url", color.gray4),

                spec.fg("@markup.math", color.orange),

                -- treesitter tags
                spec.fg("@tag", theme.syntax.tag),
                spec.fg("@tag.delimiter", theme.syntax.tag),
                spec.fg("@tag.attribute", color.gray4),

                -- treesitter builtin
                spec.fg("@type.builtin", theme.syntax.type_primitive),
                spec.fg("@tag.builtin", theme.syntax.tag),
                spec.fg("@variable.builtin", theme.syntax.var),
                spec.fg("@function.builtin", theme.syntax.builtin),
                spec.fg("@module.builtin", theme.syntax.builtin),
                spec.fg("@constant.builtin", theme.syntax.const_builtin),

                -- treesitter diff
                spec.fg("@diff.pluss", theme.diff.add),
                spec.fg("@diff.minus", theme.diff.delete),
                spec.fg("@diff.delta", theme.diff.change),

                -- lsp links to treesiter
                spec.ln("@lsp.type.keyword", "@keyword"),
                spec.ln("@lsp.type.function", "@function"),
                spec.ln("@lsp.type.variable", "@variable"),
                spec.ln("@lsp.type.operator", "@operator"),
                spec.ln("@lsp.type.type", "@type"),
                spec.ln("@lsp.type.string", "@string"),
                spec.ln("@lsp.type.number", "@number"),
                spec.ln("@lsp.type.boolean", "@boolean"),
                spec.ln("@lsp.type.enumMember", "@variable.member"),

                --spell
                spec.op("SpellBad", {
                    undercurl = theme.ui.use_undercurl,
                    underline = not theme.ui.use_undercurl,
                }),
                spec.ln("SpellLocal", "SpellBad"),
                spec.ln("SpellCap", "SpellBad"),
                spec.ln("SpellRare", "SpellBad"),

                -- diff
                spec.fg("Added", theme.diff.add),
                spec.fg("Changed", theme.diff.change),
                spec.fg("Removed", theme.diff.delete),
                spec.fg("DiffAdd", theme.diff.add),
                spec.fg("DiffChange", theme.diff.change),
                spec.fg("DiffDelete", theme.diff.delete),
                spec.fg("DiffText", theme.diff.info),
                spec.fg("DiffAdded", theme.diff.add),
                spec.fg("DiffRemoved", theme.diff.delete),
                spec.fg("DiffChanged", theme.diff.change),
                spec.fg("DiffOldFile", theme.diff.info),
                spec.fg("DiffNewFile", theme.diff.add),
                spec.fg("DiffFile", theme.diff.change),
                spec.fg("DiffLine", theme.diff.change),
                spec.fg("DiffIndexLine", theme.diff.info),

                -- lisp
                spec.fg("@string.special.symbol.clojure", theme.syntax.type), -- :symbols
                spec.ln("lispFunc", "@variable.parameter"),
                spec.ln("lispSymbol", "@variable"),
                spec.ln("lispDecl", "@keyword"),

                -- zsh
                spec.fg("zshFunction", theme.syntax.func_def),

                -- json,yaml,toml
                spec.fg("@property.json", color.gray6),
                spec.fg("@property.yaml", color.gray6),
                spec.fg("@property.toml", color.gray6),
                spec.fg("@type.toml", color.gray8),

                -- xml
                spec.fg("xmlTag", color.gray5),
                spec.fg("xmlTagName", color.gray5),
                spec.fg("xmlAttrib", color.gray4),

                -- html
                spec.fg("htmlTagName", theme.syntax.tag),

                -- text
                spec.fg("texStatement", color.gray5),
                spec.fg("texDefCmd", color.gray5),
                spec.fg("texDefName", color.gray5),
                spec.fg("texDocType", color.gray5),
                spec.fg("texDocZone", color.gray5),
                spec.fg("texDocAbstract", color.gray5),
                spec.fg("texBeginEnd", color.gray5),

                -- css
                spec.fg("cssMediaProp", theme.ui.fg_normal),
                spec.fg("cssTransitionProp", theme.ui.fg_normal),
                spec.fg("cssTextProp", theme.ui.fg_normal),
                spec.fg("cssBoxProp", theme.ui.fg_normal),
                spec.fg("cssFontProp", theme.ui.fg_normal),
                spec.fg("cssPositioningProp", theme.ui.fg_normal),
                spec.fg("cssBorderProp", theme.ui.fg_normal),
                spec.fg("cssBackgroundProp", theme.ui.fg_normal),
                spec.fg("cssTransformProp", theme.ui.fg_normal),
                spec.fg("@property.css", theme.ui.fg_normal),
                spec.fg("@tag.css", theme.ui.fg_normal),

                -- markdown
                spec.fg("markdownCodeDelimiter", color.green),
                spec.fg("markdownLinkDelimiter", color.gray6),
                spec.ln("markdownLinkTextDelimiter", "@markup.link"),
                spec.ln("markdownLinkText", "@markup.link"),
                spec.ln("markdownUrl", "@markup.link.url"),

                -- sql
                spec.fg("sqlType", theme.syntax.string),
                spec.fg("sqlKeyword", theme.syntax.keyword),
                spec.fg("sqlStatement", theme.syntax.keyword),
                spec.fg("sqlVariable", theme.syntax.special),

                -- make
                spec.fg("@string.special.symbol.make", theme.syntax.string),
                spec.fg("makeSpecial", theme.syntax.special),

                -- webdevicon
                spec.fg("DevIconDefault", theme.ui.fg_icon),
            },
        },
        require("lackluster.plugin.cmp")(theme),
        require("lackluster.plugin.flash")(theme),
        require("lackluster.plugin.git-gutter")(theme),
        require("lackluster.plugin.git-signs")(theme),
        require("lackluster.plugin.lazy")(theme),
        require("lackluster.plugin.lightbulb")(theme),
        require("lackluster.plugin.lsp-config")(theme),
        require("lackluster.plugin.mason")(theme),
        require("lackluster.plugin.oil")(theme),
        require("lackluster.plugin.rainbow-delimiter")(theme),
        require("lackluster.plugin.telescope")(theme),
        require("lackluster.plugin.todo-comments")(theme),
        require("lackluster.plugin.tree")(theme),
        require("lackluster.plugin.trouble")(theme),
        require("lackluster.plugin.which-key")(theme),
        require("lackluster.plugin.notify")(theme),
        require("lackluster.plugin.navic")(theme),
        require("lackluster.plugin.yanky")(theme),
        require("lackluster.plugin.headlines")(theme),
        require("lackluster.plugin.noice")(theme),
        require("lackluster.plugin.dashboard")(theme),
        require("lackluster.plugin.scrollbar")(theme),
        require("lackluster.plugin.bufferline")(theme),
        require("lackluster.plugin.indentmini")(theme),
        -- TODO: decide if each individual mini plugin should be opt in
        -- can wait until all are supported before deciding
        require("lackluster.plugin.mini")(theme),
    }
end

return highlight
