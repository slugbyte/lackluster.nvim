local spec = require("lackluster.spec")
local color = require("lackluster.color")

---@param theme LacklusterTheme
---@return LacklusterHighlightGroup
return function(theme)
    return {
        plugin_name = "mini",
        highlight = {
            -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-trailspace.md
            spec.fg("MiniTrailspace", color.orange),

            -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-trailspace.md
            spec.fg("MiniJump", color.black),
            spec.bg("MiniJump", color.gray8)
        },
    }
end
