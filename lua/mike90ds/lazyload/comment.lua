local has = vim.fn.has
local is_linux = has("unix")
local is_win = has("win32")
-- https://www.reddit.com/r/neovim/comments/vr68yl/checking_for_wsl_in_initlua/
local is_wsl = (function()
    local output = vim.fn.systemlist("uname -r")
    return not not string.find(output[1] or "", "WSL")
end)()

-- -- https://youtu.be/vdn_pKJUda8?list=PLTqGJvc0HUn2GY0sW2L61lDuBaXBKnorO&t=1432
local setup, comment = pcall(require, "Comment")
if not setup then
    return
end

if is_wsl or is_win then
    -- if is_wsl or is_win then
    comment.setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        toggler = {
            line = "//",
        },
        opleader = {
            block = "gb",
        },
    })
-- elseif is_linux then
elseif is_win then
    -- elseif is_linux or is_win then
    comment.setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        toggler = {
            line = "<C-/>",
        },
        opleader = {
            line = "<C-/>",
            block = "gb",
        },
    })
end
