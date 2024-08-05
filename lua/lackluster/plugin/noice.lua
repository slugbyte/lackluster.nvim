local spec = require("lackluster.spec")

---@param theme LacklusterTheme
---@return LacklusterHighlightGroup
return function(theme)
    return {
        plugin_name = "noice",
        highlight = {
            spec.fg("NoiceCmdlineIcon", theme.log.hint),
            spec.fg("NoiceCmdlineIconSearch", theme.log.hint),
            spec.co("NoiceCmdlinePopup", theme.ui.fg_normal, theme.ui.bg_normal),
            spec.co("NoiceCmdlinePopupBorder", theme.ui.fg_normal, theme.ui.bg_normal),
            spec.co("NoiceCmdlinePopupBorderSearch", theme.ui.fg_normal, theme.ui.bg_normal),
            spec.co("NoiceCmdlinePopupTitle", theme.log.hint, theme.ui.bg_normal),
            spec.co("NoiceCmdlinePrompt", theme.log.warn, theme.ui.bg_normal),
            spec.co("NoiceCompletionItemKindDefault", theme.log.hint, theme.ui.bg_normal),
            spec.co("NoiceConfirm", theme.ui.fg_normal, theme.ui.bg_normal),
            spec.co("NoiceConfirmBorder", theme.ui.fg_normal, theme.ui.bg_normal),
            spec.co("NoicePopup", theme.ui.fg_normal, theme.ui.bg_popup),
            spec.co("NoicePopupBorder", theme.ui.bg_popup, theme.ui.bg_popup),
        },
    }
end
