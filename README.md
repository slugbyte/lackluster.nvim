# airhead
> muted colors

## INSTALL
1. Install `slugbyte/airhead` with your favorite package manager
2. Set your colorscheme to `airhead`

```lua 
-- example lazy.nvim install setup
return {
    "slugbyte/airhead.nvim",
    lazy = false,
    priority = 1000,
    init = function()
        vim.cmd.colorscheme("airhead")
    end,
}
```

## LUALINE
```lua
require('lualine').setup({
    options = {
        theme = "airhead",
    },
})
```

## Supported plugins
* [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
* [nvim\_cmp](https://github.com/hrsh7th/nvim-cmp)
* [which-key.nvim](https://github.com/folke/which-key.nvim)
* [oil.nvim](https://github.com/stevearc/oil.nvim)
* [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
* [nvim-lightbulb](https://github.com/kosayoda/nvim-lightbulb)
