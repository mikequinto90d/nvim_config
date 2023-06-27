-- import mason plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then
    return
end

-- import mason-lspconfig plugin safely
-- mason-lspconfig is the bridge between mason and neovim/lsp-config
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
    return
end

-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
    return
end

mason.setup()

-- language servers
-- https://github.com/williamboman/mason-lspconfig.nvim
mason_lspconfig.setup({
    ensure_installed = {
        "tsserver",
        "html",
        "cssls",
        -- "tailwindcss",
        "lua_ls",
        "emmet_ls",
        "bashls",
        "emmet_ls",
        "jsonls",
        "pyright",
        "volar",
    },
})

-- linters and formatters
-- https://github.com/jay-babu/mason-null-ls.nvim
-- these are to be added to mason.lua (more like null-ls.lua right?)
mason_null_ls.setup({
    ensure_installed = {
        -- "prettier",
        "prettierd",
        "stylua",
        "eslint_d",
        "black",
        -- "pylint", -- if disabled, sometimes it uses the venv pylint instead?
        "isort",
    },
})
