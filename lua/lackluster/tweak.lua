local validate = require("lackluster.validate")

---@diagnostic disable: inject-field
local M = {}

---limit keys, aka dont allow willy nilly tweaks to theme.ui
local tweak_background_keys = {
    "normal",
    "menu",
    "popup",
    "telescope",
}

---modify the colors base don setup's config.tweak_color
M.color = function(tweak_color, color)
    for color_name, color_value in pairs(tweak_color) do
        if color_value and color_value ~= "default" then
            if validate.hexcode(color_value) then
                color[color_name] = color_value
            else
                vim.notify(
                    "ERROR: skiping lackluster tweak color [" .. color_name .. "] because of invalid value (" .. color_value .. ")",
                    vim.log.levels.ERROR
                )
            end
        end
    end
end

---modify the theme based on setup's config.tweak_background
M.background = function(tweak_background, theme)
    for _, key in ipairs(tweak_background_keys) do
        local value = tweak_background[key]
        if value and (value ~= "default") then
            if validate.hexcode_or_none(value) then
                if key == "telescope" then
                    theme.plugin_telescope["bg_normal"] = value
                else
                    theme.ui["bg_" .. key] = value
                end
            else
                vim.notify("ERROR: skiping lackluster tweak background [" .. key .. "] because of invalid value (" .. value .. ")", vim.log.levels.ERROR)
            end
        end
    end
end

---limit keys, aka dont allow willy nilly tweaks to theme.syntax
local tweak_syntax_keys = {
    "string",
    "string_escape",
    "comment",
    "builtin",
    "type",
    "keyword",
    "keyword_return",
    "keyword_exception",
}

---modify the theme based on setup's config.tweak_syntax
---@param tweak_syntax LacklusterConfigTweakSyntax
---@param theme LacklusterTheme
M.syntax = function(tweak_syntax, theme)
    for _, key in ipairs(tweak_syntax_keys) do
        local value = tweak_syntax[key]
        if value and (value ~= "default") then
            if validate.hexcode_or_none(value) then
                theme.syntax_tweak[key] = value
                if key == "type" then
                    ---@diagnostic disable-next-line: inject-field
                    theme.syntax_tweak.type_primitive = value
                end
            else
                vim.notify("ERROR: skiping lackluster tweak syntax [" .. key .. "] because of invalid value (" .. value .. ")", vim.log.levels.ERROR)
            end
        end
    end
end

---modify the theme based on config.tweak_ui
---@param tweak_ui LacklusterConfigTweakUI
---@param theme LacklusterTheme
---@param color LacklusterColor
M.ui = function(tweak_ui, theme, color)
    if tweak_ui.disable_undercurl then
        ---@diagnostic disable-next-line: inject-field
        theme.ui.use_undercurl = false
    end
    if tweak_ui.enable_end_of_buffer then
        ---@diagnostic disable-next-line: inject-field, undefined-field
        theme.ui.fg_end_of_buffer = color.gray4
    else
        -- Set the End-of-Buffer (EOB) character to an empty space
        vim.opt.fillchars:append({ eob = " " })
    end
end

---update or overwrite a hl_name with an hl_value
---@param hl_name string
---@param hl_value vim.api.keyset.highlight
---@param force boolean
M.tweak_highlight_apply = function(hl_name, hl_value, force)
    if force then
        vim.api.nvim_set_hl(0, hl_name, hl_value)
        return
    end
    local old_value = vim.api.nvim_get_hl(0, { name = hl_name })
    if vim.tbl_isempty(old_value) then
        return M.tweak_highlight_apply(hl_name, hl_value, true)
    end
    vim.api.nvim_set_hl(0, hl_name, vim.tbl_extend("force", old_value, hl_value))
end

---update or overwrite highlights
---@param tweak_highlight {[string]:vim.api.keyset.highlight}
M.highlight = function(tweak_highlight)
    for hl_name, hl_value in pairs(tweak_highlight) do
        local force = hl_value.overwrite == true
        hl_value.overwrite = nil
        M.tweak_highlight_apply(hl_name, hl_value, force)
    end
end

return M
