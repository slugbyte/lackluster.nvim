local spec = require("lackluster.spec")

---@param theme LacklusterTheme
---@return LacklusterHighlightGroup
return function(theme)
    return {
        plugin_name = "trouble",
        highlight = {
            spec.co("TroubleNormal", theme.plugin_trouble.normal, theme.ui.bg_popup),
            spec.fg("TroubleSource", theme.plugin_trouble.normal),
            spec.fg("TroubleCode", theme.plugin_trouble.code),
            spec.fg("TroubleLocation", theme.plugin_trouble.code),
            spec.fg("TroubleInformation", theme.diagnostic.info),
            spec.fg("TroubleTextError", theme.diagnostic.error),
            spec.fg("TroubleTextWarning", theme.diagnostic.warn),
        },
    }
end
