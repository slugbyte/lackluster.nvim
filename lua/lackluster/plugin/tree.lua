local spec = require("lackluster.spec")

---@param theme LacklusterTheme
---@return LacklusterHighlightGroup
return function(theme)
    return {
        plugin_name = "tree",
        highlight = {
            spec.fg("NvimTreeExecFile", theme.fs.exec),
            spec.fg("NvimTreeSymlink", theme.fs.link),
            spec.fg("NvimTreeSymlinkIcon", theme.fs.link),
            spec.fg("NvimTreeSymlinkFolderName", theme.fs.link),
            spec.fg("NvimTreeSpecialFile", theme.fs.binary_data),
            spec.fg("NvimTreeImageFile", theme.fs.binary_data),
            spec.fg("NvimTreeRootFolder", theme.fs.dir),
            spec.fg("NvimTreeFolder", theme.fs.dir),
            spec.fg("NvimTreeFolderIcon", theme.fs.dir),
            spec.fg("NvimTreeBookmarkIcon", theme.plugin_tree.bookmark),
            spec.fg("NvimTreeBookmarkHl", theme.plugin_tree.bookmark),
            spec.fg("NvimTreeGitDeletedIcon", theme.diff.delete),
            spec.fg("NvimTreeGitMergeIcon", theme.diff.change),
            spec.fg("NvimTreeGitRenamedIcon", theme.diff.change),
            spec.fg("NvimTreeGitNewIcon", theme.diff.add),
            spec.fg("NvimTreeGitDirtyIcon", theme.diff.change),
            spec.fg("NvimTreeModifiedIcon", theme.diff.change),
            spec.co("NvimTreeWindowPicker", theme.ui.fg_search, theme.ui.bg_search_cur),
            spec.fg("NvimTreeDiagnosticErrorFileHl", theme.diagnostic.error),
            spec.fg("NvimTreeDiagnosticInfoFileHl", theme.diagnostic.info),
            spec.fg("NvimTreeDiagnosticHintFileHl", theme.diagnostic.hint),
            spec.fg("NvimTreeDiagnosticWarnFileHl", theme.diagnostic.warn),
        },
    }
end
