local spec = require("lackluster.spec")

---@param theme LacklusterTheme
---@return LacklusterHighlightGroup
return function(theme)
    return {
        plugin_name = "rainbow_delimiter",
        highlight = {
            spec.fg("RainbowDelimiterRed", theme.plugin_rainbow.red),
            spec.fg("RainbowDelimiterYellow", theme.plugin_rainbow.yellow),
            spec.fg("RainbowDelimiterBlue", theme.plugin_rainbow.blue),
            spec.fg("RainbowDelimiterOrange", theme.plugin_rainbow.orange),
            spec.fg("RainbowDelimiterGreen", theme.plugin_rainbow.green),
            spec.fg("RainbowDelimiterViolet", theme.plugin_rainbow.violet),
            spec.fg("RainbowDelimiterCyan", theme.plugin_rainbow.cyan),
        },
    }
end
