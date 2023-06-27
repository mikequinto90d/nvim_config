-- local status, colorscheme = pcall(require, "catppuccin")
-- if not status then
--     return
-- end

local status, colorscheme = pcall(require, "ayu")
if not status then
    return
end
colorscheme.setup({
    colors = {
        dark = {
            bg = "#464646", -- yellow
        },
    },
})

vim.cmd("colorscheme ayu-mirage")
