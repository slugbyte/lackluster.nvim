local spec = require("lackluster.spec")

---@param theme LacklusterTheme
---@return LacklusterHighlightGroup
return function(theme)
    local which_key = theme.plugin_which_key
    return {
        plugin_name = "which_key",
        highlight = {
            spec.fg("WhichKey", which_key.key),
            spec.fg("WhichKeyGroup", which_key.group),
            spec.fg("WhichKeyDesc", which_key.key),
            spec.fg("WhichKeySeparator", which_key.separator),
        },
    }
end
