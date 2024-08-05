local lackluster_color = require("lackluster.color")
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

    vim.api.nvim_set_hl(0, hl_group, {
        fg = color,
    })
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
    vim.api.nvim_set_hl(0, hl_group, {
        bg = color,
    })
end

-- define LLF LLFB and LLR usercommands
M.create_usrcmds = function()
    -- reload colorscheme
    vim.api.nvim_create_user_command("LLR", function()
        M.lackluster_reload()
    end, {
        desc = ":LLR (reload colorscheme)",
        nargs = 0,
    })
    -- try out a
    -- USAGE :LLF <hl_group> <lackluster_color_name>
    vim.api.nvim_create_user_command("LLF", function(opt)
        local hl_group = opt.fargs[1]
        local color_name = opt.fargs[2]
        M.try_fg(hl_group, color_name)
    end, {
        desc = ":LLF <hl_group> <lackluster_color_name> (apply color to fg)",
        nargs = "*",
    })

    -- try out a bg color
    -- USAGE :LLB <hl_group> <lackluster_color_name>
    vim.api.nvim_create_user_command("LLB", function(opt)
        local hl_group = opt.fargs[1]
        local color_name = opt.fargs[2]
        M.try_bg(hl_group, color_name)
    end, {
        desc = ":LLF <hl_group> <lackluster_color_name> (apply color to bg)",
        nargs = "*",
    })
end

return M
