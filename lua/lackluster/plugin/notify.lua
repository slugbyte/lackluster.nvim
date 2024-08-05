local spec = require("lackluster.spec")

---@param theme LacklusterTheme
---@return LacklusterHighlightGroup
return function(theme)
    return {
        plugin_name = "notify",
        highlight = {
            spec.co("NotifyInfoBorder", theme.ui.fg_border, theme.ui.bg_normal),
            spec.co("NotifyInfoTitle", theme.log.hint, theme.ui.bg_normal),
            spec.co("NotifyInfoIcon", theme.log.hint, theme.ui.bg_normal),
            spec.co("NotifyInfoBody", theme.log.hint, theme.ui.bg_normal),

            spec.co("NotifyWarnBorder", theme.ui.fg_border, theme.ui.bg_normal),
            spec.co("NotifyWarnTitle", theme.log.warn, theme.ui.bg_normal),
            spec.co("NotifyWarnIcon", theme.log.warn, theme.ui.bg_normal),
            spec.co("NotifyWarnBody", theme.log.hint, theme.ui.bg_normal),

            spec.co("NotifyErrorBorder", theme.log.hint, theme.ui.bg_normal),
            spec.co("NotifyErrorTitle", theme.log.error, theme.ui.bg_normal),
            spec.co("NotifyErrorIcon", theme.log.error, theme.ui.bg_normal),
            spec.co("NotifyErrorBody", theme.log.hint, theme.ui.bg_normal),

            spec.co("NotifyDebugBorder", theme.log.hint, theme.ui.bg_normal),
            spec.co("NotifyDebugTitle", theme.log.debug, theme.ui.bg_normal),
            spec.co("NotifyDebugIcon", theme.log.debug, theme.ui.bg_normal),
            spec.co("NotifyDebugBody", theme.log.hint, theme.ui.bg_normal),

            spec.co("NotifyTraceBorder", theme.log.hint, theme.ui.bg_normal),
            spec.co("NotifyTraceTitle", theme.log.debug, theme.ui.bg_normal),
            spec.co("NotifyTraceIcon", theme.log.debug, theme.ui.bg_normal),
            spec.co("NotifyTraceBody", theme.log.hint, theme.ui.bg_normal),
        },
    }
end
