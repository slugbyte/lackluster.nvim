# LACKLUSTER DEVELOPMENT GUIDE

## GOALS
* Maximize code readability and minimize visual noise
* Make it easy to quickly visually identify...
  * Function and type definitions
  * Function return and exception points
  * Function calls
  * Builtin modules and functions
  * Diagnostic errors
* Support commonly used neovim plugins
* Be easy on the eyes

### NON GOALS
* light mode or other new themes

## SETUP DEVELOPMENT ENVIRONMENT

<details>

<summary>(RECOMENDED) How to setup dev env with lazy.nvim</summary>

1. fork this repository
2. create a directory where you want to develop neovim plugins
  * like `mkdir ~/code/neovim_dev`
3. add your directory to you lazy.nvim `setup()`
``` lua
require("lazy").setup(
    -- ...your config 
    {
        dev = {
            path = "~/code/neovim_dev",
        },
    },
)
```
4. clone your fork into your development direcotry
  * `cd ~/code/neovim_dev`
  * `git clone <your fork>`

5. setup your lazy plugin for lackluster to use `dev = true`
  * it will now look in your dev directory
```lua
-- setup your lazy plugin config with dev = true
return {
    "slugbyte/lackluster.nvim",
    dependencies = {
        -- NOTE: plenary.nvim is required for lackluster_reload() to work
        "nvim-lua/plenary.nvim",
    },
    lazy = false,
    dev = true,
    priority = 1000, -- make sure to load this before all the other start plugins
    init = function()
        local lackluster = require("lackluster")
        lackluster.dev.create_usercmds()
        vim.cmd.colorscheme("lackluster")
    end,
}
```
</details>

<details>

<summary>How to setup a dev environment at a custom location</summary>

1. fork this repository
2. create a directory where you want to develop neovim plugins 
  * like `mkdir ~/code/neovim_dev`
3. add your directory to the vim runtime path
  * `vim.opt.runtimepath:append(',~/code/neovim_dev')`
4. clone your fork into your development direcotry
  * `cd ~/code/neovim_dev`
  * `git clone <your fork>`
4. use your package manager to install `nvim-lua/plenary.nvim` a dependency of
   `lackluster_reload()`
5. load the dev lib and user commands
```lua
local lackluster = require("lackluster")
lackluster.dev.create_usercmds()
```
</details>

## COLOR NAMES
> Don't let the main readme fool you, the actual color names are red, orange, green, and blue

> there are are also quite a few other colors that start with `_specail_`
> that I ended up creating to ensure UIs consistently look good `¯\_(ツ)_/¯`

![](./asset/img/lackluster-pallet-dev.png)

## API
* `lackluster_dev.lackluster_reload()` - reload any changes made to lackluster
* `lackluster_dev.try_fg(hl_group, color_name)` - test out a lackluster color\_name or a hexcode a hl\_group
  * hex codes need to start with `#` like `#99ffaa`
* `lackluster_dev.try_bg(hl_group, color_name)` - test out a lackluster color\_name or a hexcode on a hl\_group
  * hex codes need to start with `#` like `#99ffaa`
* `lackluster_dev.create_usercmds()` - create lack luster development user commands

## USER COMMANDS
* `:LLR` - reload lackluster
* `:LLF <hl_group> <color_name>` - try a lackluster color on the foreground
* `:LLB <hl_group> <color_name>` - try a lackluster color on background
