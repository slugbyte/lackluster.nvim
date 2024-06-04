local M = {}

-- limit keys, aka dont allow willy nilly tweeks to theme.ui
local tweek_background_keys = {
    "normal",
    "menu",
    "popup",
    "telescope",
}

-- modifty the theme based on setup's config.tweek_background
M.background = function(tweek_background, theme)
    for _, key in ipairs(tweek_background_keys) do
        local value = tweek_background[key]
        if value and (value ~= 'default') then
            theme.ui["bg_" .. key] = value
        end
    end
end


-- limit keys, aka dont allow willy nilly tweeks to theme.syntax
local tweek_syntax_keys = {
    "string",
    "string_escape",
    "comment",
    "builtin",
    "type",
    "keyword",
    "keyword_return",
    "keyword_exception",
}

-- modifty the theme based on setup's config.tweek_syntax
M.syntax = function(tweek_syntax, theme)
    for _, key in ipairs(tweek_syntax_keys) do
        local value = tweek_syntax[key]
        if value and (value ~= 'default') then
            theme.syntax_tweek[key] = value
            if key == 'type' then
                -- M.color.syntax_tweek.type_def = value
                theme.syntax_tweek.type_primitave = value
            end
        end
    end
end

return M
