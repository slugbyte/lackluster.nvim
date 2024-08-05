local spec = require("lackluster.spec")

---@param theme LacklusterTheme
---@return LacklusterHighlightGroup
return function(theme)
    return {
        plugin_name = "git_gutter",
        highlight = {
            spec.fg("GitGutterAdd", theme.diff.info),
            spec.fg("GitGutterAddLineNr", theme.diff.info),
            spec.fg("GitGutterChange", theme.diff.change),
            spec.fg("GitGutterChangeLineNr", theme.diff.change),
            spec.fg("GitGutterDelete", theme.diff.delete),
            spec.fg("GitGutterDeleteLineNr", theme.diff.delete),
        },
    }
end
