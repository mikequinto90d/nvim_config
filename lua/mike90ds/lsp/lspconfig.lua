-- import lspconfig plugin safely (prob neovim/nvim-lspconfig)
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
    return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
    return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
    return
end

-- :LspInfo to see what lsp is run on current file
local keymap = vim.keymap
local on_attach = function(client, bufnr)
    -- keybind options
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- set keybinds
    keymap.set(
        "n",
        "gf",
        "<cmd>Lspsaga lsp_finder<CR>",
        { desc = "[Lspsaga] LSP Finder(definition, references, implementation(if there are any)" },
        opts
    )
    -- keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration (essentially a less good version of Lspsaga goto_definition, can be buggy)
    keymap.set("n", "gP", "<cmd>Lspsaga peek_definition<CR>", { desc = "[Lspsaga] Peek definition" }, opts) -- see definition and make edits in window
    keymap.set("n", "gD", "<cmd>Lspsaga goto_definition<CR>", { desc = "[Lspsaga] go to definiton" }, opts)
    keymap.set(
        "n",
        "gi",
        "<cmd>lua vim.lsp.buf.implementation()<CR>",
        { desc = "[vim.lsp.buf](LSP) go to implementation" },
        opts
    )
    keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "[Lspsaga] code action" }, opts)
    keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "[Lspsaga] rename" }, opts)
    keymap.set(
        "n",
        "<leader>D",
        "<cmd>Lspsaga show_line_diagnostics<CR>",
        { desc = "[Lspsaga] show diagnostics" },
        opts
    )
    keymap.set(
        "n",
        "<leader>dd",
        "<cmd>Lspsaga show_cursor_diagnostics<CR>",
        { desc = "[Lspsaga] show diagnostic under cursor" },
        opts
    )
    keymap.set(
        "n",
        "[d",
        "<cmd>Lspsaga diagnostic_jump_prev<CR>",
        { desc = "[Lspsaga] jump through diagnostics" },
        opts
    )
    keymap.set(
        "n",
        "]d",
        "<cmd>Lspsaga diagnostic_jump_next<CR>",
        { desc = "[Lspsaga] jump through diagnostics" },
        opts
    ) -- jump to next diagnostic in buffer
    keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "[Lspsaga] show hover documentation" }, opts)
    keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

    -- typescript specific keymaps (e.g. rename file and update imports)
    if client.name == "tsserver" then
        keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
        keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
        keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
    end
end

