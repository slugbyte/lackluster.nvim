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

            -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-starter.md
            spec.co("MiniStarterQuery", color.blue, color.none),
            spec.co("MiniStarterItemPrefix", color.gray6, color.none),

            -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-statusline.md
            -- Statusline modes highlights
            spec.co("MiniStatuslineModeNormal", color.gray7, color_special.statusline, { bold = true }),
            spec.co("MiniStatuslineModeInsert", color.gray9, color.lack, { bold = true }),
            spec.co("MiniStatuslineModeVisual", color.black, color.gray9, { bold = true }),
            spec.co("MiniStatuslineModeCommand", color.gray9, color.lack, { bold = true }),
            spec.co("MiniStatuslineModeReplace", color.black, color.gray9, { bold = true }),
            spec.co("MiniStatuslineModeOther", color.gray9, color.lack, { bold = true }),

            -- Other statusline highlights
            spec.co("MiniStatuslineInactive", color.gray4, color.gray1, { bold = false }),
            spec.co("MiniStatuslineFilename", color.gray7, color_special.statusline),
            spec.co("MiniStatuslineFileinfo", color.gray7, color_special.statusline),
            spec.co("MiniStatuslineDevinfo", color.gray7, color_special.statusline),

            -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-tabline.md
            spec.co("MiniTablineCurrent", color.gray6, theme.ui.bg_menu),
            spec.co("MiniTablineHidden", color.gray4, theme.ui.bg_normal),
            spec.co("MiniTablineVisible", color.none, theme.ui.bg_normal),
            spec.bg("MiniTablineFill", theme.ui.bg_normal),

            -- hint
            spec.co("MiniTablineTabpagesection", color.black, color.gray9),

            -- modified
            spec.co("MiniTablineModifiedCurrent", color.gray7, theme.ui.bg_menu),
            spec.co("MiniTablineModifiedHidden", color.gray7, theme.ui.bg_normal),
            spec.co("MiniTablineModifiedVisible", color.gray7, theme.ui.bg_normal),

            -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md
            spec.co("MiniSurround", color.gray1, color.lack),
        },
    }
end
