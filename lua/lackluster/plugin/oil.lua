local spec = require("lackluster.spec")

---@param theme LacklusterTheme
---@return LacklusterHighlightGroup
return function(theme)
    return {
        plugin_name = "oil",
        highlight = {
            spec.fg("Directory", theme.fs.dir),
            spec.fg("OilFile", theme.fs.file),
            spec.fg("OilDir", theme.fs.dir),
            spec.fg("OilDirIcon", theme.fs.dir),
            spec.fg("OilLink", theme.fs.link),
            spec.ln("OilLinkTarget", "OilLink"),
            spec.fg("OilSocket", theme.fs.socket),
            spec.fg("OilCreate", theme.diff.add),
            spec.fg("OilCopy", theme.diff.add),
            spec.fg("OilRestore", theme.diff.add),
            spec.fg("OilDelete", theme.diff.delete),
            spec.fg("OilPurge", theme.diff.delete),
            spec.fg("OilTrash", theme.diff.delete),
            spec.fg("OilTrashSourcePath", theme.diff.delete),
            spec.fg("OilMove", theme.diff.change),
            spec.fg("OilChange", theme.diff.change),
        },
    }
end
