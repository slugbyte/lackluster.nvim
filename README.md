# lackluster
> a delightful grayscale colorscheme thats soft on the eyes, and supports heaps of plugins

![a screenshot of neovim with the lackluster colorscheme](./asset/lackluster.png)

![a picture of lackluster lualine variations](./asset/lackluster-lualine.png)

![a picture of the lackluster colorpallet](./asset/lackluster-pallet.png)

[more screenshots](./SCREENSHOT.md)

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

#### LUALINE SETUP
```lua
require('lualine').setup({
    options = {
        theme = "lackluster",
    },
})
```

## Explicitly supported plugins
> lots of other plugins should work right out of the box too!
* [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
* [lazy.nvim](https://github.com/folke/lazy.nvim)
* [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
* [mini.diff](https://github.com/echasnovski/mini.diff)
* [nvim-lightbulb](https://github.com/kosayoda/nvim-lightbulb)
* [nvim\_cmp](https://github.com/hrsh7th/nvim-cmp)
* [oil.nvim](https://github.com/stevearc/oil.nvim)
* [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
* [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
* [vim-gitgutter](https://github.com/airblade/vim-gitgutter)
* [which-key.nvim](https://github.com/folke/which-key.nvim)

## HELP WANTED
If you find in bugs, or syntax issues feel free to open a ticket!

Is `lackluster` missing support for a plugin you want? Feel free to open a PR with a
suggested implementation! Your contribution is mega much appreciated.

See the [Contributing Guide](./CONTRIBUTING.md)

## SELF-PROMO
If you like this project star the GitHub repository :)
