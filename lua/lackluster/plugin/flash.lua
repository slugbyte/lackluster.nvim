local spec = require("lackluster.spec")

---@param theme LacklusterTheme
---@return LacklusterHighlightGroup
return function(theme)
    return {
        plugin_name = "flash",
        highlight = {
            -- flash.nvim
            spec.co("FlashLabel", theme.plugin_flash.fg_label, theme.plugin_flash.bg_label),
            spec.co("FlashMatch", theme.plugin_flash.fg_match, theme.plugin_flash.bg_match),
            spec.co("FlashCurrent", theme.plugin_flash.fg_current, theme.plugin_flash.bg_current),
        },
    }
end
