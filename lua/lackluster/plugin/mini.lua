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

            -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-jump.md
            spec.co("MiniJump", color.gray1, color.lack),

            -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-jump2d.md
            spec.co("MiniJump2dSpot", color.gray1, color.lack),

            -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-starter.md
            spec.co("MiniStarterQuery ", color.lack, color.none),
            spec.co("MiniStarterItemPrefix", color.gray6, color.none),
        },
    }
end
