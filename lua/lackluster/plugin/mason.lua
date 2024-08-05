local spec = require("lackluster.spec")

---@param theme LacklusterTheme
---@return LacklusterHighlightGroup
return function(theme)
    return {
        plugin_name = "mason",
        highlight = {
            spec.fg("MasonHighlight", theme.plugin_mason.highlight),
            spec.co("MasonHeader", theme.plugin_mason.header, theme.ui.bg_popup),
            spec.co("MasonHighlightBlock", theme.ui.fg_button, theme.ui.bg_button),
            spec.co("MasonHighlightBlockBold", theme.ui.fg_button_active, theme.ui.bg_button_active),
            spec.ln("MasonMutedBlock", "MasonHighlightBlock"),
        },
    }
end
