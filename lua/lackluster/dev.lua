local lackluster_color = require("lackluster.color")
local lackluster_tweak = require("lackluster.tweak")
local plenary_found, plenary_reload = pcall(require, "plenary.reload")

local M = {}

local err = function(fmt, ...)
    vim.notify(string.format(fmt, ...), vim.log.levels.ERROR)
end

local emoticon_list = {
    "( つ ◕o◕ )つ",
    "(´｡• ◡ •｡`)",
    "( ˘ ͜ʖ ˘)",
    "(⌐■-‿-■)",
    "( ＾◡＾)っ ♡",
    "(っ∩_∩)っ",
    "(っ◕‿◕)っ",
    ":っ)",
    "༼ つ ◕_◕ ༽つ",
    "( •◡•)",
}

local rand_emoticon = function()
    return emoticon_list[math.random(1, #emoticon_list)]
end

M.lackluster_reload = function(opt)
    opt = opt or {}
    if not plenary_found then
        return err("ERROR: lackluster_reload could not find dependency plenary.nvim")
    end
    plenary_reload.reload_module("lackluster")
    require("lackluster").load(opt)
    if opt.theme then
        print(string.format("%s lackluster-%s reloaded!", rand_emoticon(), opt.theme))
        return
    end
    print(rand_emoticon() .. " lackluster reloaded!")
end

--- try out a lackluster color on a hl_group
M.try_fg = function(hl_group, color_name)
    local color = lackluster_color[color_name]
    if string.sub(color_name, 1, 1) == "#" then
        color = color_name
    end

    if color == nil then
        return err("ERROR: %s is not a valid lackluster color", color_name)
    end
    lackluster_tweak.tweak_highlight_apply(hl_group, {
        fg = color,
    }, false)
end

--- try out a lackluster color on a hl_group
M.try_bg = function(hl_group, color_name)
    local color = lackluster_color[color_name]
    if string.sub(color_name, 1, 1) == "#" then
        color = color_name
    end
    if color == nil then
        return err("ERROR: %s is not a valid lackluster color", color_name)
    end
    lackluster_tweak.tweak_highlight_apply(hl_group, {
        bg = color,
    }, false)
end

M.try_color = function(hl_group, color_fg, color_bg)
    M.try_fg(hl_group, color_fg)
    M.try_bg(hl_group, color_bg)
end

-- define Lr Fg Bg Co
M.create_usrcmds = function()
    -- reload colorscheme
    vim.api.nvim_create_user_command("Lr", function(opt)
        local theme = opt.fargs[1]
        M.lackluster_reload({
            theme = theme,
        })
    end, {
        desc = ":Lr (optional variant name [hack|mint]) (reload colorscheme)",
        nargs = "*",
    })
    -- try out a
    -- USAGE :LLF <hl_group> <lackluster_color_name>
    vim.api.nvim_create_user_command("Fg", function(opt)
        local hl_group = opt.fargs[1]
        local color_name = opt.fargs[2]
        M.try_fg(hl_group, color_name)
    end, {
        desc = ":Bg <hl_group> <lackluster_color_name> (apply color to fg)",
        nargs = "*",
    })

    -- try out a bg color
    -- USAGE :LLB <hl_group> <lackluster_color_name>
    vim.api.nvim_create_user_command("Bg", function(opt)
        local hl_group = opt.fargs[1]
        local color_name = opt.fargs[2]
        M.try_bg(hl_group, color_name)
    end, {
        desc = ":Fg <hl_group> <lackluster_color_name> (apply color to bg)",
        nargs = "*",
    })

    -- test a highlight
    -- try out a bg color
    -- USAGE :LLB <hl_group> <lackluster_color_name>
    vim.api.nvim_create_user_command("Co", function(opt)
        local hl_group = opt.fargs[1]
        local color_fg = opt.fargs[2]
        local color_bg = opt.fargs[3]
        M.try_color(hl_group, color_fg, color_bg)
    end, {
        desc = ":Co <hl_group> <fg_color> <bg_color>",
        nargs = "*",
    })
end

return M
