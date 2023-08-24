-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

-- Default options are not included
--- See: https://neovim.io/doc/user/vim_diff.html
--- [2] Defaults - *nvim-defaults*

-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
local cmd = vim.cmd     				      -- Execute Vim commands
local exec = vim.api.nvim_exec 	      -- Execute Vimscript
local g = vim.g         				      -- Global variables
local opt = vim.opt         		      -- Set options (global/buffer/windows-scoped)
--local fn = vim.fn       				    -- Call Vim functions

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'                       -- Enable mouse support
-- opt.clipboard = 'unnamedplus'         -- Copy/paste to system clipboard
opt.completeopt = 'menuone,noselect,noinsert'  -- Autocomplete options
-- opt.timeoutlen = 500 -- mapping timeout 500ms  (adjust for preference)
-- opt.ttimeoutlen = 20 -- keycode timeout 20ms
opt.undofile = true -- Enable persistent undo

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true                     -- Show line number
opt.showmatch = true                  -- Highlight matching parenthesis
opt.matchtime = 2                     -- How many tenths of a second to blink when matching brackets
opt.foldmethod = 'marker'             -- Enable folding (default 'foldmarker')
-- opt.colorcolumn = '80'                -- Line lenght marker at 80 columns
vim.signcolumn = true                 -- Always display sign column
opt.splitright = true                 -- Vertical split to the right
opt.splitbelow = true                 -- Orizontal split to the bottom
opt.ignorecase = true                 -- Ignore case letters when search
opt.smartcase = true                  -- Ignore lowercase for the whole pattern
opt.linebreak = true                  -- Wrap on word boundary
opt.termguicolors = true              -- Enable 24-bit RGB colors
opt.scrolloff=5                       -- Start scrolling before reaching the edge when moving with j/k
opt.inccommand='nosplit'              -- Live preview of substitution results
opt.diffopt:append 'vertical,iwhite,algorithm:patience,hiddenoff'
opt.pumblend = 10                     -- Transparency for completions menu
opt.cmdheight=0                       -- Hide command prompt
opt.updatetime=300                    -- You will have bad experience for diagnostic messages when it's default 4000.
opt.listchars='eol:↲,tab:» ,extends:›,precedes:‹,nbsp:☠,trail:·'

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true                  -- Use spaces instead of tabs
opt.shiftwidth = 2                    -- Shift 4 spaces when tab
opt.tabstop = 2                       -- 1 tab == 4 spaces
opt.smartindent = true                -- Autoindent new lines

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true                     -- Enable background buffers
opt.history = 100                     -- Remember N lines in history
opt.lazyredraw = true                 -- Faster scrolling
opt.synmaxcol = 240                   -- Max column for syntax highlight

-----------------------------------------------------------
-- Autocommands
-----------------------------------------------------------

-- Remove whitespace on save
cmd [[au BufWritePre * :%s/\s\+$//e]]

-- Highlight on yank
exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=800}
  augroup end
]], false)

-- Don't auto-comment new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- Remove line lenght marker for selected filetypes
-- cmd [[autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0]]

-- 2 spaces for selected filetypes
cmd [[
  autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml,terraform,sh setlocal shiftwidth=2 tabstop=2
]]

-- Return to last edit position when opening files
cmd [[
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------

-- Disable nvim intro
opt.shortmess:append "sI"

-- Disable builtins plugins
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end

