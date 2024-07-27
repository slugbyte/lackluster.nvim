---@diagnostic disable: inject-field
local M = {}

-- limit keys, aka dont allow willy nilly tweaks to theme.ui
local tweak_background_keys = {
  'normal',
  'menu',
  'popup',
  'telescope',
}

-- TODO: @JuanBaut create M.pallet(tweak_pallet, color), a function that takes in tweak_pallet and color
-- and then overides color with anything set on tweak pallet (using mutation)

-- modify the theme based on setup's config.tweak_background
M.background = function(tweak_background, theme)
  for _, key in ipairs(tweak_background_keys) do
    local value = tweak_background[key]
    if key == 'telescope' then
      if value and (value ~= 'default') then
        theme.plugin_telescope['bg_normal'] = value
      end
    else
      if value and (value ~= 'default') then
        theme.ui['bg_' .. key] = value
      end
    end
  end
end

-- limit keys, aka dont allow willy nilly tweaks to theme.syntax
local tweak_syntax_keys = {
  'string',
  'string_escape',
  'comment',
  'builtin',
  'type',
  'keyword',
  'keyword_return',
  'keyword_exception',
}

-- modify the theme based on setup's config.tweak_syntax
---@param tweak_syntax LacklusterConfigTweakSyntax
---@param theme LacklusterTheme
M.syntax = function(tweak_syntax, theme)
  for _, key in ipairs(tweak_syntax_keys) do
    local value = tweak_syntax[key]
    if value and (value ~= 'default') then
      theme.syntax_tweak[key] = value
      if key == 'type' then
        ---@diagnostic disable-next-line: inject-field
        theme.syntax_tweak.type_primitive = value
      end
    end
  end
end

-- modify the theme based on config.tweak_ui
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
  end
end

return M
