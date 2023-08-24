-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Map leader key to comma instead of space
vim.g.mapleader = ","

local opt = vim.opt

-- Disable autowrite
opt.autowrite = false

-- Disable yanking to clipboard
opt.clipboard = nil
