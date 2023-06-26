local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    return
end

treesitter.setup({
    -- A list of parser names, or "all"
    ensure_installed = {
        "help",
        "javascript",
        "typescript",
        "lua",
        "json",
        "toml",
        "markdown",
        "markdown_inline",
        "svelte",
        "vue",
        "bash",
        "vim",
        "css",
        "tsx",
    },
    -- https://www.lazyvim.org/plugins/treesitter
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<nop>",
            node_decremental = "<bs>",
        },
    },

    indent = { enable = true },

    autotag = { enable = true },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
        config = {
            javascript = {
                __default = "// %s",
                --[[ jsx_element = "{/* %s */}", ]]
                jsx_fragment = "{/* %s */}",
                jsx_attribute = "// %s",
                comment = "// %s",
            },
        },
    },
})
