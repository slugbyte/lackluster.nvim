local spec = require("lackluster.spec")
local color = require("lackluster.color")
local color_special = require("lackluster.color-special")

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
        },
    }
end
