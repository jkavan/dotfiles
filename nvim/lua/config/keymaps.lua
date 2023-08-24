-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keys = vim.keymap

-- Replace lazygit keymaps with Git Fugitive
keys.set("n", "<leader>gg", ":G<CR>", { desc = "Open Git Fugitive" })
keys.del("n", "<leader>gG")
