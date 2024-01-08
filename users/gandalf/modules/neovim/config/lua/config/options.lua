-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set the filetype for .y files to be the same as .lex files
vim.api.nvim_exec([[ au BufRead,BufNewFile *.y set filetype=lex ]], false)
