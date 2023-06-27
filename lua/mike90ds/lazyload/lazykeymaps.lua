local keymap = vim.keymap

keymap.set(
    { "n", "t" },
    "<C-`>",
    "<Esc><C-\\><C-n><cmd>ToggleTermToggleAll<CR>",
    { desc = "[Toggleterm] Toggle all terminals" }
)
keymap.set(
    "n",
    "<leader>tpy",
    ":lua _PYTHON_TOGGLE()<CR>",
    { desc = "[Toggleterm] Toggle Python floating terminal" }
)
keymap.set(
    "n",
    "<leader>tjs",
    ":lua _NODE_TOGGLE()<CR>",
    { desc = "[Toggleterm] Toggle NODE JS floating terminal" }
)
keymap.set("n", "<leader>fl", ":lua _FLOATING_TOGGLE()<CR>", { desc = "[Toggleterm] Toggle floating terminal" })
keymap.set("n", "<leader>htop", ":lua _HTOP_TOGGLE()<CR>", { desc = "[Toggleterm] Toggle floating HTOP terminal" })
keymap.set(
    "n",
    "<leader>lz",
    ":lua _LAZYGIT_TOGGLE()<CR>",
    { desc = "[Toggleterm] Toggle floating Lazygit terminal" }
)

-- docstrings
keymap.set(
    { "n" },
    "<leader>dpy",
    "<cmd>DogeGenerate google<CR>",
    { desc = "[Doge] Generate Python docs docstrings in google standard", noremap = true, silent = true }
)
keymap.set(
    { "n" },
    "<leader>djs",
    "<cmd>DogeGenerate jsdoc<CR>",
    { desc = "[Doge] Generate JSdoc docstrings", noremap = true, silent = true }
)

-- neoclip
keymap.set(
    "n",
    "<leader>nc",
    "<cmd>Telescope neoclip<CR>",
    { desc = "[Telescope] open neoclip clipboard manager", silent = true, noremap = true }
)

keymap.set(
    "n",
    "<leader>tmcr",
    "<cmd>lua require('telescope').extensions.macroscope.default()<CR>",
    { desc = "[Telescope] open neoclip macroscope for macro history", silent = true, noremap = true }
)

keymap.set(
    "n",
    "<leader>tnctog",
    "<cmd>lua require('neoclip').toggle()<CR>",
    { desc = "[Telescope] (toggle) start or stop neoclip", silent = true, noremap = true }
)

-- telescope repo
keymap.set("n", "<leader>trepo", "<cmd>Telescope repo<cr>", { desc = "[Telescope] browse your repositories" })
