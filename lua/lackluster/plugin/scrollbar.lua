local spec = require("lackluster.spec")

---@param theme LacklusterTheme
---@return LacklusterHighlightGroup
return function(theme)
    local bg = theme.plugin_scrollbar.bg
    local cursor = theme.plugin_scrollbar.cursor
    return {
        plugin_name = "scrollbar",
        highlight = {
            spec.bg("ScrollbarHandle", bg),
            spec.co("ScrollbarCursor", cursor, bg),
            spec.co("ScrollbarCursorHandle", cursor, bg),
            spec.co("ScrollbarSearch", theme.ui.bg_search_item, "none"),
            spec.co("ScrollbarSearchHandle", theme.ui.bg_search_item, bg),
            spec.co("ScrollbarError", theme.log.error, "none"),
            spec.co("ScrollbarErrorHandle", theme.log.error, bg),
            spec.co("ScrollbarWarn", theme.log.warn, "none"),
            spec.co("ScrollbarWarnHandle", theme.log.warn, bg),
            spec.co("ScrollbarInfo", theme.log.hint, "none"),
            spec.co("ScrollbarInfoHandle", theme.log.hint, bg),
            spec.co("ScrollbarMisc", theme.log.hint, "none"),
            spec.co("ScrollbarMiscHandle", theme.log.hint, bg),
            spec.co("ScrollbarGitAdd", theme.diff.add, "none"),
            spec.co("ScrollbarGitAddHandle", theme.diff.add, bg),
            spec.co("ScrollbarGitChange", theme.diff.change, "none"),
            spec.co("ScrollbarGitChangeHandle", theme.diff.change, bg),
            spec.co("ScrollbarGitDelete", theme.diff.delete, "none"),
            spec.co("ScrollbarGitDeleteHandle", theme.diff.delete, bg),
        },
    }
end
