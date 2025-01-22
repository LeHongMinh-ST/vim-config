-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("telescope").setup({
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key",
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- },
    -- please take a look at the readme of the extension you want to configure
  },
})

vim.g.blamer_enabled = true
vim.g.NERDTreeShowHidden = 1
vim.o.mouse = "a"

-- vim.cmd("colorscheme tokyonight")
-- vim.cmd("colorscheme rose-pine")
-- vim.cmd("colorscheme vscode")
-- vim.cmd("colorscheme catppuccin-macchiato")
vim.cmd("colorscheme kanagawa")
-- vim.cmd("colorscheme nightfox")
-- vim.cmd("colorscheme darcula-dark")
-- vim.cmd("colorscheme solarized-osaka")
