-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.map
local unmap = vim.keymap.del

unmap("t", "<C-h>")
unmap("t", "<C-j>")
unmap("t", "<C-k>")
unmap("t", "<C-l>")
