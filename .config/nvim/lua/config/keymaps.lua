-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Resize with Alt + hjkl
-- map("n", "<A-h>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
-- map("n", "<A-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
-- map("n", "<A-j>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
-- map("n", "<A-k>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })

map("n", "<C-h>", require("smart-splits").move_cursor_left)
map("n", "<C-j>", require("smart-splits").move_cursor_down)
map("n", "<C-k>", require("smart-splits").move_cursor_up)
map("n", "<C-l>", require("smart-splits").move_cursor_right)

map("n", "<A-h>", require("smart-splits").resize_left)
map("n", "<A-j>", require("smart-splits").resize_down)
map("n", "<A-k>", require("smart-splits").resize_up)
map("n", "<A-l>", require("smart-splits").resize_right)
