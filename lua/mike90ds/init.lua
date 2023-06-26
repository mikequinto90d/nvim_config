require("mike90ds.settings")
require("mike90ds.remap")
require("mike90ds.plugins")

local has = vim.fn.has
local is_linux = has("unix")
local is_win = has("win32")
-- https://www.reddit.com/r/neovim/comments/vr68yl/checking_for_wsl_in_initlua/
local is_wsl = (function()
    local output = vim.fn.systemlist("uname -r")
    return not not string.find(output[1] or "", "WSL")
end)()
