local spec = require("lackluster.spec")

---@param theme LacklusterTheme
---@return LacklusterHighlightGroup
return function(theme)
    local telescope = theme.plugin_telescope
    return {
        plugin_name = "telescope",
        highlight = {
            spec.co("TelescopeNormal", telescope.fg_normal, telescope.bg_normal),
            spec.co("TelescopeBorder", telescope.fg_border, telescope.bg_normal),

            spec.op("TelescopeMatching", { italic = true }),
            spec.co("TelescopeSelection", telescope.fg_normal, telescope.bg_selection),
            spec.co("TelescopePreviewLine", telescope.fg_preview, telescope.bg_preview),
            spec.ln("TelescopePreviewMatch", "TelescopePreviewLine"),

            spec.fg("TelescopeTitle", telescope.fg_normal),
            spec.ln("TelescopeMultiSelection", "TelescopeTitle"),
            spec.ln("TelescopeMultiIcon", "TelescopeTitle"),

            spec.ln("TelescopePromptPrefix", "TelescopeTitle"),
            spec.fg("TelescopePromptCounter", telescope.fg_counter),

            spec.co("TelescopeResultsNormal", telescope.fg_results, telescope.bg_normal),
            spec.ln("TelescopeResultsSpecialComment", "TelescopeResultsNormal"),
            spec.ln("TelescopeResultsDiffUntracked", "TelescopeResultsNormal"),
            spec.ln("TelescopeResultsIdentifier", "TelescopeResultsNormal"),
            spec.ln("TelescopeResultsDiffDelete", "TelescopeResultsNormal"),
            spec.ln("TelescopeResultsDiffChange", "TelescopeResultsNormal"),
            spec.ln("TelescopeResultsVariable", "TelescopeResultsNormal"),
            spec.ln("TelescopeResultsOperator", "TelescopeResultsNormal"),
            spec.ln("TelescopeResultsFunction", "TelescopeResultsNormal"),
            spec.ln("TelescopeResultsConstant", "TelescopeResultsNormal"),
            spec.ln("TelescopeResultsDiffAdd", "TelescopeResultsNormal"),
            spec.ln("TelescopeResultsComment", "TelescopeResultsNormal"),
            spec.ln("TelescopeResultsSymbol", "TelescopeResultsNormal"),
            spec.ln("TelescopeResultsStruct", "TelescopeResultsNormal"),
            spec.ln("TelescopeResultsNumber", "TelescopeResultsNormal"),
            spec.ln("TelescopeResultsMethod", "TelescopeResultsNormal"),
            spec.ln("TelescopeResultsLineNr", "TelescopeResultsNormal"),
            spec.ln("TelescopeResultsField", "TelescopeResultsNormal"),
            spec.ln("TelescopeResultsClass", "TelescopeResultsNormal"),
        },
    }
end
