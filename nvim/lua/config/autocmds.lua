-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Define an autocmd group for file type detection
vim.api.nvim_create_augroup("JenkinsfileFTDetect", { clear = true })

-- Set up an autocommand to associate Jenkinsfile patterns with the groovy filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "Jenkinsfile", "Jenkinsfile.*" },
  group = "JenkinsfileFTDetect",
  command = "set filetype=groovy",
})
