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
local theme = require("lackluster.theme")
local tweek = require("lackluster.tweek")
local highlight = require("lackluster.highlight")

local M = {
    color = color,
    dev = dev,
}

---@class LacklusterConfigTweekSyntax
---@field string ?string
---@field string_escape ?string
---@field comment ?string
---@field builtin ?string
---@field type ?string
---@field keyword ?string
---@field keyword_return ?string
---@field keyword_exception ?string

---@class LacklusterConfigTweekBackground
---@field normal ?string
---@field menu ?string
---@field popup ?string
---@field telescope ?string

---@class LacklusterConfigDisablePlugin
---@field cmp ?boolean
---@field flash ?boolean
---@field git_gutter ?boolean
---@field git_signs ?boolean
---@field lazy ?boolean
---@field lightbulb ?boolean
---@field lsp_config ?boolean
---@field mason ?boolean
---@field mini_diff ?boolean
---@field oil ?boolean
---@field rainbow_delimiter ?boolean
---@field telescope ?boolean
---@field todo_comments ?boolean
---@field tree ?boolean
---@field trouble ?boolean
---@field which_key ?boolean

---@class LacklusterConfig
---@field tweek_syntax ?LacklusterConfigTweekSyntax
---@field tweek_background ?LacklusterConfigTweekBackground
---@field disable_plugin LacklusterConfigDisablePlugin

--- @type LacklusterConfig | nil
local USER_CONFIG = nil

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
    disable_plugin = {
        cmp = nil,
        flash = nil,
        git_gutter = nil,
        git_signs = nil,
        lazy = nil,
        lightbulb = nil,
        lsp_config = nil,
        mason = nil,
        mini_diff = nil,
        oil = nil,
        rainbow_delimiter = nil,
        telescope = nil,
        todo_comments = nil,
        tree = nil,
        trouble = nil,
        which_key = nil,
    },
}

---configure lackluster with optional settings
---@param config ?LacklusterConfig
M.setup = function(config)
    config = vim.tbl_deep_extend("keep", config or {}, default_config)
    USER_CONFIG = config
    tweek.background(config.tweek_background, theme)
    tweek.syntax(config.tweek_syntax, theme)
end

-- apply the colorscheme
M.load = function(opt)
    opt = opt or {}

    if USER_CONFIG == nil then
        USER_CONFIG = vim.tbl_deep_extend("force", {}, default_config)
    end

    local t = theme
    t.syntax = t.syntax_default
    vim.o.termguicolors = true
    vim.g.colors_name = "lackluster"

    -- official themes
    if opt.theme == "hack" then
        t.syntax = t.syntax_hack
        vim.g.colors_name = "lackluster-hack"
    end

    if opt.theme == "mint" then
        t.syntax = t.syntax_mint
        vim.g.colors_name = "lackluster-mint"
    end

    -- expieramental themes
    if opt.theme == "dark" then
        t.syntax = t.syntax_dark
        vim.g.colors_name = "lackluster-dark"
    end

    if opt.theme == "night" then
        t.syntax = t.syntax_night
        vim.g.colors_name = "lackluster-night"
    end

    t.syntax = vim.tbl_extend('force', t.syntax, t.syntax_tweek)

    local dedup_set = {}
    local highlight_group_list = highlight(t, color)

    for _, highlight_group in ipairs(highlight_group_list) do
        local highlight_spec_list = highlight_group.highlight
        local is_plugin_enabled = not USER_CONFIG.disable_plugin[highlight_group.plugin_name]

        if highlight_group.dont_skip or is_plugin_enabled then
            for _, hl_spec in ipairs(highlight_spec_list) do
                local hl_name = hl_spec.name
                if dedup_set[hl_name] then
                    vim.notify("error: duplicate hi_spec :: " .. hl_name, vim.log.levels.ERROR)
                else
                    dedup_set[hl_name] = true
                    hl_spec.name = nil -- must set to nil so that nvim_set_hl doen't freq out
                    ---@diagnostic disable-next-line: param-type-mismatch
                    vim.api.nvim_set_hl(0, hl_name, hl_spec)
                end
            end
        end
    end
end

return M
