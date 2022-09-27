-----------------------------------------------------------
-- File manager configuration file
-----------------------------------------------------------

-- Plugin: nvim-tree
-- url: https://github.com/kyazdani42/nvim-tree.lua

--- Keybindings are defined in `core/keymapping.lua`:
--- https://github.com/kyazdani42/nvim-tree.lua#keybindings

--- Note: options under the g: command should be set BEFORE running the
--- setup function: https://github.com/kyazdani42/nvim-tree.lua#setup
--- Default options are not included.
--- See: `help NvimTree`
local g = vim.g

g.nvim_tree_width_allow_resize  = 1

require('nvim-tree').setup {
  renderer = {
    indent_markers = {
      enable = true
    },
    highlight_git = true,
    highlight_opened_files = "all",
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
      }
    }
  },
respect_buf_cwd = true,
  open_on_setup = true,
  update_cwd = true,
  actions = {
    open_file = {
      resize_window = false,
      quit_on_open = false,
      window_picker = { enable = false },
    },
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = true,
    custom = { '.git', 'node_modules', '.cache', '.bin' },
  },
  view = { width = 32 },
}
