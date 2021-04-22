# Vim installation

Dotfiles should already take care of setting up Vim.

## Extensions

Extensions are managed with [Plug](https://github.com/junegunn/vim-plug).

### Install a new extension

To install a new plugin, insert `Plug 'author/repository'` into the Plugin section in `vimrc`.

### Upgrade

To upgrade plugins, run `:PlugUpdate` in Vim.

### Remove a plugin

To remove a plugin, delete the plugin line from vimrc and run `:PlugClean`.
