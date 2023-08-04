local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
    return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
    return
end

local builtin = require("telescope.builtin")

telescope.setup({
    defaults = {
        -- https://github.com/nvim-telescope/telescope.nvim/issues/895
        path_display = { "truncate" },
        mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
        },
        file_ignore_patterns = {
            "static",
            "templates",
            "**/pnpm%-lock.yaml",
            "**/package%-lock.json",
            "dictionary_files",
            ".json",
            ".ico",
            ".jpg",
            ".jpeg",
            ".png",
            ".gif",
            ".svg",
        },
    },
    extensions = {
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
        },
        -- live_grep_args = {
        --     list = {
        --         search_dirs = { "~/Documents/Github-repos" },
        --     },
        -- },
        -- repo = {
        --     list = {
        --         search_dirs = { "~/Documents/Github-repos", "~/Documents/notes", "~/Documents/reference-repos" },
        --     },
        -- },
    },
})

-- telescope.load_extension("fzf")
