# lackluster
> a mostly muted colorscheme

## INSTALL
1. Install `slugbyte/lackluster.nvim` with your favorite package manager
2. Set your colorscheme to `lackluster`

```lua 
-- example lazy.nvim install setup
return {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
    init = function()
        vim.cmd.colorscheme("lackluster")
    end,
}
```

## LUALINE
```lua
require('lualine').setup({
    options = {
        theme = "lackluster",
    },
})
```

## todo
* rename lackluster.nvim

## Supported plugins
* [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
* [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
* [nvim-lightbulb](https://github.com/kosayoda/nvim-lightbulb)
* [nvim\_cmp](https://github.com/hrsh7th/nvim-cmp)
* [oil.nvim](https://github.com/stevearc/oil.nvim)
* [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
* [which-key.nvim](https://github.com/folke/which-key.nvim)
