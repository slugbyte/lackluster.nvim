local spec = require('lackluster.spec')

---@param theme LacklusterTheme
---@return LacklusterHightlightGroup
return function(theme)
    return {
        plugin_name = "lsp_config",
        highlight = {
            spec.fg('lspInfoTip', theme.diagnostic.info),
        },
    }
end
