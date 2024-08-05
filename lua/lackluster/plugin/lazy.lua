local spec = require("lackluster.spec")

---@param theme LacklusterTheme
---@return LacklusterHighlightGroup
return function(theme)
    return {
        plugin_name = "lazy",
        highlight = {
            spec.co("LazyNormal", theme.ui.fg_normal, theme.ui.bg_popup),
            spec.co("LazyButton", theme.ui.fg_button, theme.ui.bg_button),
            spec.co("LazyButtonActive", theme.ui.fg_button_active, theme.ui.bg_button_active),
            spec.fg("LazySpecial", theme.plugin_lazy.special),
            spec.fg("LazyComment", theme.plugin_lazy.comment),
            spec.ln("LazyH1", "LazyButtonActive"),
        },
    }
end
