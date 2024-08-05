local spec = require("lackluster.spec")

---@param theme LacklusterTheme
---@return LacklusterHighlightGroup
return function(theme)
    return {
        plugin_name = "git_signs",
        highlight = {
            spec.fg("GitSignsAdd", theme.diff.info),
            spec.fg("GitSignsChange", theme.diff.change),
            spec.fg("GitSignsDelete", theme.diff.delete),
        },
    }
end
