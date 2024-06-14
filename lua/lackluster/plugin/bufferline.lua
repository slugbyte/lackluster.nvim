local spec = require("lackluster.spec")
local color = require("lackluster.color")

---@param theme LacklusterTheme
---@return LacklusterHighlightGroup
return function(theme)
    local bg_fill   = theme.ui.bg_statusline
    local bg_active = theme.ui.bg_tab_active
    local bg_nc     = theme.ui.bg_tab_nc
    local icon      = theme.ui.fg_icon

    return {
        plugin_name = "bufferline",
        highlight = {
            spec.bg("BufferLineFill", theme.ui.bg_statusline),

            -- buffer
            spec.co("BufferLineBuffer", theme.ui.fg_tab_nc, color.none),
            spec.co("BufferLineBackground", theme.ui.fg_tab_nc, theme.ui.bg_tab_nc),
            spec.co("BufferLineCloseButton", color.gray2, color.gray4),

            -- hint
            spec.co("BufferLineHint", icon, bg_nc),


            -- devicon
            spec.co("BufferLineDevIconDefault", icon, bg_nc),
            spec.co("BufferLineDevIconDefaultInactive", icon, bg_nc),
            spec.co("BufferLineDevIconDefaultSelected", color.blue, bg_active),

            -- seperat
            spec.co("BufferLineSeparator", bg_fill, bg_fill),
            spec.co("BufferLineOffsetSeparator", bg_fill, bg_fill),
            spec.co("BufferLineTabSeparator", bg_fill, bg_fill),
            spec.co("BufferLineTabSeparatorSelected", bg_fill, bg_fill),
            spec.co("BufferLineSeparatorVisible", bg_fill, bg_fill),
            spec.co("BufferLineSeparatorSelected", bg_fill, bg_fill),
            spec.co("BufferLineGroupSeparator", bg_fill, bg_fill),

            -- visable
            spec.co("BufferLineBufferVisible", color.lack, bg_nc),

            -- spec.co("BufferLineBackground", color.blue, color.red),
            spec.co("BufferLineNumbers", color.blue, color.red),
            spec.co("BufferLineGroupLabel", color.blue, color.green),

            -- tabs
            spec.co("BufferLineTab", theme.ui.fg_tab_nc, theme.ui.bg_tab_nc),
            spec.co("BufferLineTabSelected", theme.ui.fg_tab_active, theme.ui.bg_tab_active),

            -- selected
            spec.co("BufferLineBufferSelected", theme.ui.fg_tab_active, theme.ui.bg_tab_active),
            spec.co("BufferLineCloseButtonSelected", theme.ui.fg_tab_active, theme.ui.bg_tab_active),
        }
    }
end
