local spec = require("lackluster.spec")

---@param theme LacklusterTheme
---@return LacklusterHighlightGroup
return function(theme)
    return {
        plugin_name = "navic",
        highlight = {
            spec.co("NavicIconsFile", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsModule", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsNamespace", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsPackage", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsClass", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsMethod", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsProperty", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsField", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsConstructor", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsEnum", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsInterface", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsFunction", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsVariable", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsConstant", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsString", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsNumber", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsBoolean", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsArray", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsObject", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsKey", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsNull", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsEnumMember", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsStruct", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsEvent", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsOperator", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicIconsTypeParameter", theme.plugin_navic.icon, theme.ui.bg_statusline),
            spec.co("NavicText", theme.plugin_navic.text, theme.ui.bg_statusline),
        },
    }
end
