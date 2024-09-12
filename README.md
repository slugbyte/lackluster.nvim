# lackluster
> a delightful and customizable mostly monochrome colorscheme thats soft on the eyes and supports treesitter, lsp, and heaps of neovim plugins.

![a screenshot of neovim with the lackluster colorscheme](https://raw.githubusercontent.com/slugbyte/lackluster.nvim/main/asset/lackluster.png)

> a minimal but flexible and good looking pallet made from beautiful hexcodes

[a bunch more screenshots...](https://github.com/slugbyte/lackluster.nvim/blob/main/SCREENSHOT.md)

### ABOUT
* Treesitter syntax highlights
* Uses 24bit [true color](https://en.wikipedia.org/wiki/ANSI_escape_code#24-bit)
* Easy on the eyes

## SETUP
1. Install `slugbyte/lackluster.nvim` with your favorite package manager
2. Set your colorscheme to `lackluster`, `lackluster-hack`, or `lackluster-mint`
3. (optional) Setup Lualine
5. (optional) Tweak Color Pallet
6. (optional) Tweak Syntax Colors and Background Transparency
7. (optional) Tweak UI
8. (optional) Tweak Highlights Manually (bold, italic, etc...)
9. (optional) Tweak Disable Plugin Highlights
10. (optional) Setup nvim-web-devicons

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
  <summary>(OPTIONAL) Tweak Color Pallet</summary>

> !! `setup()` **MUST** be called before setting your colorscheme !!

```lua 
local lackluster = require("lackluster")

-- !must called setup() before setting the colorscheme!
lackluster.setup({
    -- tweak_color allows you to overwrite the default colors in the lackluster theme
    tweak_color = {
        -- you can set a value to a custom hexcode like' #aaaa77' (hashtag required)
        -- or if the value is 'default' or nil it will use lackluster's default color
        -- lack = "#aaaa77",
        lack = "default", 
        luster = "default",
        orange = "default",
        yellow = "default",
        green = "default",
        blue = "default",
        red = "default",
        -- WARN: Watchout! messing with grays is probs a bad idea, its very easy to shoot yourself in the foot!
        -- black = "default",
        -- gray1 = "default",
        -- gray2 = "default",
        -- gray3 = "default",
        -- gray4 = "default",
        -- gray5 = "default",
        -- gray6 = "default",
        -- gray7 = "default",
        -- gray8 = "default",
        -- gray9 = "default",

    },
})

-- !must set colorscheme after calling setup()!
vim.cmd.colorscheme("lackluster")
```

</details>

<details>
  <summary>(OPTIONAL) Tweak Syntax Colors and Background Transparency</summary>

> !! `setup()` **MUST** be called before setting your colorscheme !!

```lua 
local lackluster = require("lackluster")

local color = lackluster.color -- blue, green, red, orange, black, lack, luster, gray1-9

-- !must called setup() before setting the colorscheme!
lackluster.setup({
    -- You can overwrite the following syntax colors by setting them to one of...
    --   1) a hexcode like "#a1b2c3" for a custom color.
    --   2) "default" or nil will just use whatever lackluster's default is.
    tweak_syntax = {
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
    tweak_background = {
        normal = 'default',    -- main background
        -- normal = 'none',    -- transparent
        -- normal = '#a1b2c3',    -- hexcode 
        -- normal = color.green,    -- lackluster color
        telescope = 'default', -- telescope
        menu = 'default',      -- nvim_cmp, wildmenu ... (bad idea to transparent)
        popup = 'default',     -- lazy, mason, whichkey ... (bad idea to transparent)
    },
})

-- !must set colorscheme after calling setup()!
vim.cmd.colorscheme("lackluster")
```

> Example transparent background `setup()`
```lua 
--  When testing transparent backgrounds I found that comments where often hard to read, 
--  and menus didn't look good but using setup() tweaks you can easily address that!
local lackluster = require("lackluster")

-- !must called setup() before setting the colorscheme!
lackluster.setup({
    tweak_syntax = {
        comment = lackluster.color.gray4, -- or gray5
    },
    tweak_background = {
        normal = 'none',
        telescope = 'none',
        menu = lackluster.color.gray3,
        popup = 'default',
    },
})

-- !must set colorscheme after calling setup()!
vim.cmd.colorscheme("lackluster")
```
</details>

<details>
  <summary>(OPTIONAL) Tweak UI</summary>

> !! `setup()` **MUST** be called before setting your colorscheme !!

```lua 
local lackluster = require("lackluster")

-- !must called setup() before setting the colorscheme!
lackluster.setup({
    tweak_ui = {
        disable_undercurl = false, -- set to true if you want underline instead of undercurl
        enable_end_of_buffer = false, -- set to true to show the end_of_buffer ~ symbols in the gutter
    },
})

-- !must set colorscheme after calling setup()!
vim.cmd.colorscheme("lackluster")
```

</details>

<details>
  <summary>(OPTIONAL) Tweak Highlights Manually (bold, italic, etc...)</summary>

```lua
local lackluster = require("lackluster")

-- !must called setup() before setting the colorscheme!
lackluster.setup({
    -- tweak_highlight allows you to update or overwrite the value passed into
    -- vim.api.nvim_set_hl which allows you to have complete control over modifying all
    -- highlights on a granular level.
    tweak_highlight = {
      -- modify @keyword's highlights to be bold and italic
      ["@keyword"] = {
        overwrite = false, -- overwrite falsey will extend/update lackluster's defaults (nil also does this)
        bold = true,
        italic = true,
        -- see `:help nvim_set_hl` for all possible keys
      },
      -- overwrite @function to link to @keyword
      ["@function"] = {
        overwrite = true, -- overwrite == true will force overwrite lackluster's default highlights
        link = "@keyword",
      },
    },
})

-- !must set colorscheme after calling setup()!
vim.cmd.colorscheme("lackluster")
```
</details>

<details>
  <summary>(OPTIONAL) Tweak Disable Plugin Highlights</summary>

> !! `setup()` **MUST** be called before setting your colorscheme !!

```lua
local lackluster = require("lackluster")

-- if for some reason you want to disable the highlights related to a specific plugin you 
-- can set any of these to true and the highlights will not be set

-- !must called setup() before setting the colorscheme!
lackluster.setup({
    disable_plugin = {
        bufferline = false,
        cmp = false,
        dashboard = false,
        flash = false,
        git_gutter = false,
        git_signs = false,
        headline = false,
        lazy = false,
        lightbulb = false,
        lsp_config = false,
        mason = false,
        mini_diff = false,
        navic = false,
        noice = false,
        notify = false,
        oil = false,
        rainbow_delimiter = false, -- if you want color-rainbows you should disable this
        scollbar = false,
        telescope = false,
        todo_comments = false,
        tree = false,
        trouble = false,
        which_key = false,
        yanky = false,
    },
})

-- !must set colorscheme after calling setup()!
vim.cmd.colorscheme("lackluster")
```
  </details>

<details>
  <summary>(OPTIONAL) Setup nvim-web-devicons</summary>

```lua 

-- nvim-web-devicons does not play well with colorschemes so if lackluster style icons
-- run the following setup before you load lackluster.
local lackluster = require("lackluster")
-- !must called setup() before setting the colorscheme!
require('nvim-web-devicons').setup({
    color_icons = false,
    override = {
        ["default_icon"] = {
            color = lackluster.color.gray4,
            name = "Default",
        }
    }
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

* [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
* [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim)
* [figet.nvim](https://github.com/j-hui/fidget.nvim)
* [flash.nvim](https://github.com/folke/flash.nvim)
* [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
* [headlines.nvim](https://github.com/lukas-reineke/headlines.nvim)
* [lazy.nvim](https://github.com/folke/lazy.nvim)
* [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
* [mason.nvim](https://github.com/williamboman/mason.nvim)
* [mini-cursorword.md](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-cursorword.md)
* [mini-diff.md](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-diff.md)
* [mini-indentscope.md](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-indentscope.md)
* [mini-jump.md](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-jump.md)
* [mini-jump2d.md](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-jump2d.md)
* [mini-starter.md](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-starter.md)
* [mini-statusline.md](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-statusline.md)
* [mini-tabline.md](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-tabline.md)
* [mini-trailspace.md](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-trailspace.md)
* [noice.nvim](https://github.com/folke/noice.nvim)
* [nvim-lightbulb](https://github.com/kosayoda/nvim-lightbulb)
* [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
* [nvim-navic](https://github.com/SmiteshP/nvim-navic)
* [nvim-notify](https://github.com/rcarriga/nvim-notify)
* [nvim-scrollbar](https://github.com/petertriho/nvim-scrollbar)
* [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua/tree/master?tab=readme-ov-file)
* [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
* [nvim\_cmp](https://github.com/hrsh7th/nvim-cmp)
* [oil.nvim](https://github.com/stevearc/oil.nvim)
* [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim)
* [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
* [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
* [trouble.nvim](https://github.com/folke/trouble.nvim)
* [vim-gitgutter](https://github.com/airblade/vim-gitgutter)
* [which-key.nvim](https://github.com/folke/which-key.nvim)
* [yanky.nvim](https://github.com/gbprod/yanky.nvim)

## SELF-PROMO
If you like this project star the GitHub repository :)

## HELP WANTED
If you find a bug please open a issue :) and please include screenshots if relevant :)

Is `lackluster` missing support for a plugin/extra you love? Open a suggestion issue, or
better yet Read the [CONTRIBUTING](https://github.com/slugbyte/lackluster.nvim/blob/main/CONTRIBUTING.md) 
and [DEVELOPMENT](https://github.com/slugbyte/lackluster.nvim/blob/main/DEVELOPMENT.md) Guides,
and make a contribution!

Your feedback and contributions are mega appreciated!

## ACKNOWLEDGEMENT
> I referenced the following colorscheme's source code when creating lackluster :)
* [rose-pine/neovim](https://github.com/rose-pine/neovim)
* [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim/tree/main)
* [nyoom-engineering/oxocarbon.nvim](https://github.com/nyoom-engineering/oxocarbon.nvim)
