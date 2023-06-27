-- https://github.com/F-Robot/dotfiles/blob/master/.config/nvim/lua/mappings/command.lua
local keymap = vim.keymap

-- Command Mode Move
keymap.set("c", "<C-j>", "<Down>")
keymap.set("c", "<C-k>", "<Up>")
keymap.set("c", "<C-h>", "<Left>", { desc = "[Command mode] move inside command mode without using the arrow keys" })
keymap.set("c", "<C-l>", "<Right>", { desc = "[Command mode] move inside command mode without using the arrow keys" })
