local spec = require("lackluster.spec")
local color = require("lackluster.color")

-- TODO: HELP: I cannot figure out how to make these appear
-- BufferLineDuplicate
-- BufferLineDuplicateSelected
-- BufferLineDuplicateVisible
-- BufferLineGroupLabel

---@param theme LacklusterTheme
---@return LacklusterHighlightGroup
return function(theme)
    local bg_fill = theme.ui.bg_statusline
    local fg_active = theme.ui.fg_tab_active
    local bg_active = theme.ui.bg_tab_active
    local bg_nc = theme.ui.bg_tab_nc
    local fg_nc = theme.ui.fg_tab_nc
    local bg_vis = bg_nc
    local fg_vis = color.gray6
    local icon = theme.ui.fg_icon

    return {
        plugin_name = "bufferline",
        highlight = {
            spec.bg("BufferLineFill", theme.ui.bg_statusline),
            spec.co("BufferLineTruncMarker", color.gray5, theme.ui.bg_statusline),

            -- hint
            spec.co("BufferLinePick", color.black, color.gray9),
            spec.co("BufferLinePickSelected", color.black, color.gray9),
            spec.co("BufferLinePickVisible", color.black, color.gray9),

            -- seperat
            spec.co("BufferLineSeparator", bg_fill, bg_fill),
            spec.co("BufferLineOffsetSeparator", bg_fill, bg_fill),
            spec.co("BufferLineTabSeparator", bg_fill, bg_fill),
            spec.co("BufferLineTabSeparatorSelected", bg_fill, bg_fill),
            spec.co("BufferLineSeparatorVisible", bg_fill, bg_fill),
            spec.co("BufferLineSeparatorSelected", bg_fill, bg_fill),
            spec.co("BufferLineGroupSeparator", bg_fill, bg_fill),
            spec.co("BufferLineGroupLabel", color.blue, color.green),

            -- tabs
            spec.co("BufferLineTab", theme.ui.fg_tab_nc, theme.ui.bg_tab_nc),
            spec.co("BufferLineTabClose", theme.ui.fg_tab_nc, theme.ui.bg_tab_nc),
            spec.co("BufferLineTabSelected", theme.ui.fg_tab_active, theme.ui.bg_tab_active),

            -- buffer
            spec.co("BufferLineBuffer", theme.ui.fg_tab_nc, color.none),
            spec.co("BufferLineBackground", theme.ui.fg_tab_nc, theme.ui.bg_tab_nc),
            spec.co("BufferLineCloseButton", fg_nc, bg_nc),
            spec.co("BufferLineModified", theme.diff.change, bg_nc),
            spec.co("BufferLineDevIconDefault", icon, bg_nc),
            spec.co("BufferLineNumbers", fg_nc, bg_nc),
            spec.co("BufferLineError", theme.diagnostic.error, bg_nc),
            spec.co("BufferLineErrorDiagnostic", theme.diagnostic.error, bg_nc),
            spec.co("BufferLineHint", fg_nc, bg_nc),
            spec.co("BufferLineHintDiagnostic", fg_nc, bg_nc),
            spec.co("BufferLineInfo", fg_nc, bg_nc),
            spec.co("BufferLineInfoDiagnostic", fg_nc, bg_nc),
            spec.co("BufferLineWarning", fg_nc, bg_nc),
            spec.co("BufferLineWarningDiagnostic", fg_nc, bg_nc),
            spec.co("BufferLineDiagnostic", fg_nc, bg_nc),

            -- visable
            spec.co("BufferLineBufferVisible", fg_vis, bg_vis),
            spec.co("BufferLineCloseButtonVisible", fg_nc, bg_vis),
            spec.co("BufferLineIndicatorVisible", bg_vis, bg_vis),
            spec.co("BufferLineModifiedVisible", theme.diff.change, bg_vis),
            spec.co("BufferLineDevIconDefaultInactive", icon, bg_vis),
            spec.co("BufferLineNumbersVisible", fg_nc, bg_vis),
            spec.co("BufferLineErrorVisible", theme.diagnostic.error, bg_vis),
            spec.co("BufferLineErrorDiagnosticVisible", theme.diagnostic.error, bg_vis),
            spec.co("BufferLineHintVisible", fg_nc, bg_nc),
            spec.co("BufferLineHintDiagnosticVisible", fg_nc, bg_nc),
            spec.co("BufferLineInfoVisible", fg_nc, bg_nc),
            spec.co("BufferLineInfoDiagnosticVisible", fg_nc, bg_nc),
            spec.co("BufferLineWarningVisible", fg_nc, bg_nc),
            spec.co("BufferLineWarningDiagnosticVisible", fg_nc, bg_nc),
            spec.co("BufferLineDiagnosticVisible", fg_nc, bg_nc),

            -- selected
            spec.co("BufferLineBufferSelected", fg_active, theme.ui.bg_tab_active),
            spec.co("BufferLineCloseButtonSelected", fg_active, theme.ui.bg_tab_active),
            spec.co("BufferLineIndicatorSelected", fg_active, theme.ui.bg_tab_active),
            spec.co("BufferLineModifiedSelected", theme.diff.change, theme.ui.bg_tab_active),
            spec.co("BufferLineDevIconDefaultSelected", icon, bg_active),
            spec.co("BufferLineNumbersSelected", fg_active, bg_active),
            spec.co("BufferLineErrorSelected", theme.diagnostic.error, bg_active),
            spec.co("BufferLineErrorDiagnosticSelected", theme.diagnostic.error, bg_active),
            spec.co("BufferLineHintSelected", fg_active, bg_active),
            spec.co("BufferLineHintDiagnosticSelected", fg_active, bg_active),
            spec.co("BufferLineInfoSelected", fg_active, bg_active),
            spec.co("BufferLineInfoDiagnosticSelected", fg_active, bg_active),
            spec.co("BufferLineWarningSelected", fg_active, bg_active),
            spec.co("BufferLineWarningDiagnosticSelected", fg_active, bg_active),
            spec.co("BufferLineDiagnosticSelected", fg_active, bg_active),
        },
    }
end
