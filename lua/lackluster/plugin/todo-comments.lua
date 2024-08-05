local spec = require("lackluster.spec")

---@param theme LacklusterTheme
---@return LacklusterHighlightGroup
return function(theme)
    return {
        plugin_name = "todo_comments",
        highlight = {
            spec.fg("TodoBgTodo", theme.log.hint),
            spec.fg("TodoBgWarn", theme.log.warn),
            spec.fg("TodoBgFix", theme.log.error),
            spec.fg("TodoFgFix", theme.log.error),
            spec.fg("TodoFgTodo", theme.syntax.comment),
            spec.ln("TodoBgNote", "TodoBgTodo"),
            spec.ln("TodoBgPerf", "TodoBgTodo"),
            spec.ln("TodoBgHack", "TodoBgWarn"),
            spec.ln("TodoFgNote", "TodoFgTodo"),
            spec.ln("TodoFgPerf", "TodoFgTodo"),
            spec.ln("TodoFgWarn", "TodoFgTodo"),
            spec.ln("TodoFgHack", "TodoFgTodo"),
        },
    }
end
