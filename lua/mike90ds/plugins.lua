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

    -- use({ "olimorris/onedarkpro.nvim", lock = true })
    use({ "catppuccin/nvim", as = "catppuccin", lock = true })
    use({ "Shatur/neovim-ayu", lock = true })

    -- comments and docstrings and string operation plugins
    use({ "numToStr/Comment.nvim", lock = true, event = "BufRead", config = [[require('mike90ds.lazyload.comment')]] })
    use({ "tpope/vim-surround", lock = true })
    -- react / jsx
    use({ "JoosepAlviste/nvim-ts-context-commentstring", lock = true })

    -- file explorer, file operations, buffer operations, tabs
    --[[ use({ "nvim-tree/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup()
        end,
        lock = true }) ]]
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = { 
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        lock = true
    }
    use({ "kyazdani42/nvim-web-devicons", lock = true })
    use({ "nvim-lualine/lualine.nvim", lock = true }) -- https://github.com/Strazil001/Nvim/blob/main/lua/svdv/packer.luais_linux
    use({
        "kdheepak/tabline.nvim",
        config = function()
            require("tabline").setup({
                -- Defaults configuration options
                enable = true,
                options = {
                    -- If lualine is installed tabline will use separators configured in lualine by default.
                    -- These options can be used to override those settings.
                    component_separators = { "", "" },
                    section_separators = { "", "" },
                    max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
                    show_tabs_always = true, -- this shows tabs only when there are more than one tab or if the first tab is named
                    show_devicons = true, -- this shows devicons in buffer section
                    colored = true,
                    show_bufnr = false, -- this appends [bufnr] to buffer section,
                    tabline_show_last_separator = true,
                    show_filename_only = true, -- shows base filename only instead of relative path in filename
                    modified_icon = "+ ", -- change the default modified icon
                    modified_italic = true, -- set to true by default; this determines whether the filename turns italic if modified
                    show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
                },
            })
            vim.cmd([[
              set guioptions-=e " Use showtabline in gui vim
              set sessionoptions+=tabpages,globals " store tabpages and globals in session
            ]])
        end,
        lock = true,
    })
    use({ "moll/vim-bbye", lock = true })


    -- aucomplete / cmp / autocomplettion
    use({
        "hrsh7th/nvim-cmp",
        lock = true,
        config = function()
            require("mike90ds.lazyload.nvimcmp")
        end,
    })
    use({ "hrsh7th/cmp-cmdline", lock = true })

    -- snippets
    use({ "L3MON4D3/LuaSnip", lock = true, disable = false })

    -- managing and installing LSP servers (that mason will install)
    use({ "williamboman/mason.nvim", lock = true })
    use({ "williamboman/mason-lspconfig.nvim", lock = true }) -- bridges mason and nvim-lspconfig

    -- LSP servers config
    use({ "neovim/nvim-lspconfig", lock = true }) -- for configuring LSP servers
    use({ "hrsh7th/cmp-nvim-lsp", lock = true }) -- so that the lsp appears in autocompletion
    use({ "glepnir/lspsaga.nvim", branch = "main", lock = true }) -- enhanced lsp uis
    use({ "jose-elias-alvarez/typescript.nvim", lock = true })
    use({ "onsails/lspkind.nvim", lock = true }) -- vs-code like icons for autocompletion

    -- formatting and linting
    use({ "jose-elias-alvarez/null-ls.nvim", lock = true })
    use({ "jay-babu/mason-null-ls.nvim", lock = true }) -- similar to mason-lspconfig but for formatters
    
    -- Treesitter
    -- examples of lazyloading: https://github.com/jdhao/nvim-config/blob/master/lua/plugins.lua#L36
    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      lock = true,
      config = [[require('mike90ds.lazyload.treesitter')]],
    })
    -- autoclosing
    use({
        "windwp/nvim-autopairs",
        lock = true,
        config = [[require('mike90ds.lazyload.autopairs')]],
    })
    use({
        "windwp/nvim-ts-autotag",
        lock = true,
        after = "nvim-treesitter",
    })

    -- git (https://www.youtube.com/watch?v=ZgyVY7tArwg)
    use({ "lewis6991/gitsigns.nvim", lock = true })

    -- terminal
    use({
        "akinsho/toggleterm.nvim",
        tag = "*",
        config = function()
            -- require("configs.toggleterm")
            require("mike90ds.lazyload.toggleterm")
        end,
        -- lock = true,
        -- cmd = { "ToggleTerm", "ToggleTermToggleAll" },
        -- keys = {
        --     "<leader>tpy",
        --     "<leader>lz",
        --     "<leader>fl",
        --     "<C-`>",
        --     "<C-\\>",
        -- },
    })

    --scrollbar and other UI elements
    use({ "dstein64/nvim-scrollview", lock = true })
    use({
        "lukas-reineke/indent-blankline.nvim",
        lock = true,
        event = "BufRead",
        config = [[require('mike90ds.lazyload.indent-blank')]],
    })
    -- Lua
    use({
        "folke/zen-mode.nvim",
        lock = true,
        event = "BufRead",
        cmd = { "ZenMode" },
        -- config = [[require('lemongrass.lazyload.zenmode')]],
    })

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        lock = true,
    })
    -- use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", lock = true, after = "telescope.nvim" })
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build', lock = true }
    use({
        "nvim-telescope/telescope-live-grep-args.nvim",
        lock = true,
        after = "telescope.nvim",
        config = function()
            require("telescope").load_extension("live_grep_args")
            -- Telescope with rg syntax
            local telescope_rg = require("telescope").extensions.live_grep_args
            vim.keymap.set("n", "<leader>trg", function()
                telescope_rg.live_grep_args()
            end, { desc = "[Telescope] live grep with args (defaults to cwd)" })
        end,
    })
end)
