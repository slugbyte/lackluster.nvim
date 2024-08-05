local spec = require("lackluster.spec")

---@param theme LacklusterTheme
---@return LacklusterHighlightGroup
return function(theme)
    return {
        plugin_name = "lightbulb",
        highlight = {
            spec.fg("lightbulbSign", theme.diagnostic.text),
        },
    }
end
