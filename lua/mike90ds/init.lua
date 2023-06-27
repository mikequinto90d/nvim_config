require("mike90ds.settings")
require("mike90ds.remap")
require("mike90ds.plugins")
require("mike90ds.colorscheme")
require("mike90ds.lsp.mason")
require("mike90ds.lsp.lspsaga")
require("mike90ds.lsp.lspconfig")
require("mike90ds.lsp.null-ls")
require("mike90ds.re_command")
require("mike90ds.lazyload.lazykeymaps")

local has = vim.fn.has
local is_linux = has("unix")
local is_win = has("win32")
-- https://www.reddit.com/r/neovim/comments/vr68yl/checking_for_wsl_in_initlua/
local is_wsl = (function()
	local output = vim.fn.systemlist("uname -r")
	return not not string.find(output[1] or "", "WSL")
end)()

if is_linux then
	require("mike90ds.linux")
end

if is_win then
	require("mike90ds.windows")
end

if is_wsl then
	require("mike90ds.windows")
end
