local has = vim.fn.has
local is_linux = has("unix")
local is_wsl = (function()
    local output = vim.fn.systemlist("uname -r")
    return not not string.find(output[1] or "", "WSL")
end)()

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

local status, packer = pcall(require, "packer")
if not status then
    return
end

return require("packer").startup(function(use)
    use({ "lewis6991/impatient.nvim", config = [[require('impatient')]], lock = true })
    use({ "wbthomason/packer.nvim" })
    use({ "nvim-lua/plenary.nvim", lock = true })

    use({ "olimorris/onedarkpro.nvim", lock = true })
    use({ "catppuccin/nvim", as = "catppuccin", lock = true })
    use({ "Shatur/neovim-ayu", lock = true })

    -- comments and docstrings and string operation plugins
    use({ "numToStr/Comment.nvim", lock = true, event = "BufRead", config = [[require('mike90ds.lazyload.comment')]] })

    -- Treesitter
    -- examples of lazyloading: https://github.com/jdhao/nvim-config/blob/master/lua/plugins.lua#L36
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        lock = true,
        config = [[require('mike90ds.lazyload.treesitter')]],
    })

end)
