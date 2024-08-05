local spec = require("lackluster.spec")

---@param theme LacklusterTheme
---@return LacklusterHighlightGroup
return function(theme)
    return {
        plugin_name = "yanky",
        highlight = {
            spec.ln("YankyPut", "Visual"),
            spec.ln("YankyYanked", "Visual"),
        },
    }
end
