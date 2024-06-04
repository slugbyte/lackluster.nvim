-- ____   _________________________   ____________________________________
-- 7  7   7  _  77     77  7  77  7   7  7  77     77      77     77  _  7
-- |  |   |  _  ||  ___!|   __!|  |   |  |  ||  ___!!__  __!|  ___!|    _|
-- |  !___|  7  ||  7___|     ||  !___|  |  |!__   7  7  7  |  __|_|  _ \
-- |     7|  |  ||     7|  7  ||     7|  !  |7     |  |  |  |     7|  7  |
-- !_____!!__!__!!_____!!__!__!!_____!!_____!!_____!  !__!  !_____!!__!__!
--
--  Name: lackluster.nvim
--  License: MIT
--  Maintainer: Duncan Marsh (slugbyte@slugbyte.com)
--  Repository: https://github.com/slugbyte/lackluster.nvim

local dev = require("lackluster.dev")
local color = require("lackluster.color")
local color_special = require("lackluster.color-special")
local theme = require("lackluster.theme")
local tweek = require("lackluster.tweek")
local highlight = require("lackluster.highlight")

local M = {
    color = color,
    dev = dev,
}

---@class LacklusterConfigTweekSyntax
---@field string string
---@field string_escape string
---@field comment string
---@field builtin string
---@field type string
---@field keyword string
---@field keyword_return string
---@field keyword_exception string

---@class LacklusterConfigTweekBackground
---@field normal string
---@field menu string
---@field popup string
---@field telescope string

---@class LacklusterConfig
---@field tweek_syntax LacklusterConfigTweekSyntax
---@field tweek_background LacklusterConfigTweekBackground

--- @type LacklusterConfig
local default_config = {
    tweek_syntax = {
        -- ('default' is default) ('#ffaaff' is a custom colorcode)
        string = "default",
        string_escape = "default",
        comment = "default",
        builtin = "default", -- builtin modules and functions
        type = "default",
        keyword = "default",
        keyword_return = "default",
        keyword_exception = "default",
    },
    tweek_background = {
        -- ('default' is default) ('none' is transparent) ('#ffaaff' is a custom hexcode)
        normal = 'default',    -- main background
        menu = 'default',      -- nvim_cmp, wildmenu ...
        popup = 'default',     -- lazy, mason, whichkey ...
        telescope = 'default', -- telescope
    },
}

---configure lackluster with optional settings
---@param config ?LacklusterConfig
M.setup = function(config)
    config = vim.tbl_extend("force", default_config, config or {})
    config.tweek_background = config.tweek_background or {}
    config.tweek_syntax = config.tweek_syntax or {}

    tweek.background(config.tweek_background, theme)
    tweek.syntax(config.tweek_syntax, theme)
end

-- apply the colorscheme
M.load = function(opt)
    opt = opt or {}
    local dedup_set = {}

    local t = theme

    t.syntax = t.syntax_default

    -- official themes
    if opt.theme == "hack" then
        t.syntax = t.syntax_hack
    end

    if opt.theme == "mint" then
        t.syntax = t.syntax_mint
    end

    -- expieramental themes
    if opt.theme == "dark" then
        t.syntax = t.syntax_dark
    end

    if opt.theme == "night" then
        t.syntax = t.syntax_night
    end

    t.syntax = vim.tbl_extend('force', t.syntax, t.syntax_tweek)

    local highlight_list = highlight(t, color, color_special)

    for _, hi_spec in ipairs(highlight_list) do
        local name = hi_spec.name
        if dedup_set[name] then
            vim.notify("error: duplicate hidark :: " .. name, vim.log.levels.ERROR)
        else
            dedup_set[name] = true
            hi_spec.name = nil
            vim.api.nvim_set_hl(0, name, hi_spec)
        end
    end
end

return M
