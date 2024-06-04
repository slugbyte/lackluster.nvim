# lackluster
> a delightful mostly grayscale colorscheme thats soft on the eyes, and supports heaps of plugins

![a screenshot of neovim with the lackluster colorscheme](https://raw.githubusercontent.com/slugbyte/lackluster.nvim/main/asset/img/lackluster.png)

![a picture of lackluster lualine variations](https://raw.githubusercontent.com/slugbyte/lackluster.nvim/main/asset/img/detail/lackluster-lualine.png)

> a minimal but flexible and good looking pallet made from beautiful hexcodes

![a picture of the lackluster color pallet](https://raw.githubusercontent.com/slugbyte/lackluster.nvim/main/asset/img/lackluster-pallet.png)

[a bunch more screenshots...](https://github.com/slugbyte/lackluster.nvim/blob/main/SCREENSHOT.md)

### ABOUT
* Treesitter syntax highlights
* Uses 24bit [true color](https://en.wikipedia.org/wiki/ANSI_escape_code#24-bit)
* Easy on the eyes

## SETUP
1. Install `slugbyte/lackluster.nvim` with your favorite package manager
2. Set your colorscheme to `lackluster`, `lackluster-hack`, or `lackluster-mint`
3. (optional) setup lualine
3. (optional) color and transparency tweaks

```lua 
-- example lazy.nvim install setup
return {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
    init = function()
        vim.cmd.colorscheme("lackluster")
        -- vim.cmd.colorscheme("lackluster-hack") -- my favorite
        -- vim.cmd.colorscheme("lackluster-mint")
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

<details>
  <summary> (OPTIONAL) Color and Transparency Tweaks </summary>

> !! `setup()` **MUST** be called before setting your colorscheme !!

```lua 
local lackluster = require("lackluster")

local color = lackluster.color -- blue, green, red, orange, black, lack, luster, gray1-9

lackluster.setup({
    -- You can overwrite the following syntax colors by setting them to one of...
    --   1) a hexcode like "#a1b2c3" for a custom color
    --   2) "default" or nil will just use whatever lackluster's default is.
    tweek_syntax = {
        string = "default",
        -- string = "#a1b2c3", -- custom hexcode
        -- string = color.green, -- lackluster color
        string_escape = "default",
        comment = "default",
        builtin = "default", -- builtin modules and functions
        type = "default",
        keyword = "default",
        keyword_return = "default",
        keyword_exception = "default",
    },
    -- You can overwrite the following background colors by setting them to one of...
    --   1) a hexcode like "#a1b2c3" for a custom color
    --   2) "none" for transparency
    --   3) "default" or nil will just use whatever lackluster's default is.
    -- NOTE: when testing transparent backgrounds I found that comments where often hard
    --       to read and I found that setting lighter gray looked nice.
    tweek_background = {
        normal = 'default',    -- main background
        -- normal = 'none',    -- transparent
        -- normal = '#a1b2c3',    -- hexcode 
        -- normal = color.green,    -- lackluster color
        menu = 'default',      -- nvim_cmp, wildmenu ...
        popup = 'default',     -- lazy, mason, whichkey ...
        telescope = 'default', -- telescope
    },
})

vim.cmd.colorscheme("lackluster")
```
</details>

## VARIATIONS
> lackluster-hack (return is green, exception is blue)

![a screenshot of neovim with the lackluster-hack colorscheme](https://raw.githubusercontent.com/slugbyte/lackluster.nvim/main/asset/img/theme/lackluster-hack.png)

> lackluster-mint (types are green)

![a screenshot of neovim with the lackluster-mint colorscheme](https://raw.githubusercontent.com/slugbyte/lackluster.nvim/main/asset/img/theme/lackluster-mint.png)

[more variations..](https://github.com/slugbyte/lackluster.nvim/blob/main/SCREENSHOT.md#experimental-variations)

## EXPLICITLY SUPPORTED PLUGINS
> lots of other plugins should work right out of the box too!

Screenshots of many of the plugins can be found [here](https://github.com/slugbyte/lackluster.nvim/blob/main/SCREENSHOT.md)

* [figet.nvim](https://github.com/j-hui/fidget.nvim)
* [flash.nvim](https://github.com/folke/flash.nvim)
* [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
* [lazy.nvim](https://github.com/folke/lazy.nvim)
* [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
* [mason.nvim](https://github.com/williamboman/mason.nvim)
* [mini.diff](https://github.com/echasnovski/mini.diff)
* [nvim-lightbulb](https://github.com/kosayoda/nvim-lightbulb)
* [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
* [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua/tree/master?tab=readme-ov-file)
* [nvim\_cmp](https://github.com/hrsh7th/nvim-cmp)
* [oil.nvim](https://github.com/stevearc/oil.nvim)
* [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim)
* [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
* [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
* [trouble.nvim](https://github.com/folke/trouble.nvim)
* [vim-gitgutter](https://github.com/airblade/vim-gitgutter)
* [which-key.nvim](https://github.com/folke/which-key.nvim)

## SELF-PROMO
If you like this project star the GitHub repository :)

## HELP WANTED
If you find a bug please open a ticket :) and please include screenshots if relevant :)

Is `lackluster` missing support for a plugin you love? Feel free to open a PR with a
suggested implementation! Your contribution is mega appreciated.

See the [CONTRIBUTING](https://github.com/slugbyte/lackluster.nvim/blob/main/CONTRIBUTING.md) and [DEVELOPMENT](https://github.com/slugbyte/lackluster.nvim/blob/main/DEVELOPMENT.md) Guides!

## ACKNOWLEDGEMENT
> I referenced the following colorscheme's source code when creating lackluster :)
* [rose-pine/neovim](https://github.com/rose-pine/neovim)
* [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim/tree/main)
* [nyoom-engineering/oxocarbon.nvim](https://github.com/nyoom-engineering/oxocarbon.nvim)
