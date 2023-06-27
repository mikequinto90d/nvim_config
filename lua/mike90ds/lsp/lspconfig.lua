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

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- -- configure html server
-- lspconfig.html.setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
--     filetypes = {
--         "html",
--         -- "typescriptreact",
--         -- "javascriptreact",
--     },
-- })

-- -- configure css server
-- lspconfig.cssls.setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
--     filetypes = {
--         "html",
--         -- "typescriptreact",
--         -- "javascriptreact",
--         "css",
--     },
-- })

-- -- python
-- lspconfig["pyright"].setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
-- })

-- lspconfig["bashls"].setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
-- })

-- lspconfig["jsonls"].setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
-- })

-- configure tailwindcss server
-- https://github.com/tailwindlabs/tailwindcss/discussions/5258#discussioncomment-1979394
lspconfig.tailwindcss.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
	-- https://github.com/tailwindlabs/tailwindcss-intellisense/issues/188#issuecomment-906917241
	root_dir = lspconfig.util.root_pattern("tailwind.config.cjs", "tailwind.config.js", "tailwind.config.ts"),
	settings = {
		tailwindCSS = {
			validate = true,
		},
	},
	-- flags = { debounce_text_changes = 150 },
})

-- lspconfig.tsserver.setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
-- })

-- note: this is a plugin
typescript.setup({
	disable_commands = false, -- prevent the plugin from creating Vim commands
	debug = false, -- enable debug logging for commands
	go_to_source_definition = {
		fallback = true, -- fall back to standard LSP definition on failure
	},
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = {
			-- "html",
			"typescriptreact",
			"javascriptreact",
			"typescript",
			"javascript",
			"svelte",
		},
	},
})

-- local util = require("lspconfig.util")
-- local function get_typescript_server_path(root_dir)
--     -- local global_ts = "/home/[yourusernamehere]/.npm/lib/node_modules/typescript/lib"
--     local global_ts = "/home/lemongrass/.local/share/pnpm/global/5/node_modules/typescript/lib"
--     -- Alternative location if installed as root:
--     -- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
--     local found_ts = ""
--     local function check_dir(path)
--         found_ts = util.path.join(path, "node_modules", "typescript", "lib")
--         if util.path.exists(found_ts) then
--             return path
--         end
--     end
--     if util.search_ancestors(root_dir, check_dir) then
--         return found_ts
--     else
--         return global_ts
--     end
-- end

-- -- to prevent typescript errors within vue, enable takeover mode
-- -- https://github.com/garcia5/dotfiles/blob/master/files/nvim/lua/ag/lsp_config.lua#L243
-- -- https://www.reddit.com/r/neovim/comments/v4mhsv/neovim_setup_for_fullstack_web_development_with/
-- -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#volar
-- -- NOTE: in order for `take over mode` to work, you have to enable the filetypes table (for ts and vue)
-- -- in addition to the other configs below
-- -- also, disable your other TS servers
-- lspconfig.volar.setup({
--     filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
--     capabilities = capabilities,
--     on_new_config = function(new_config, new_root_dir)
--         new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
--         -- print(get_typescript_server_path(new_root_dir)) -- for debugging TS server path
--     end,
--     on_attach = on_attach,
-- })

-- -- configure emmet language server
-- lspconfig["emmet_ls"].setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
--     filetypes = { "html", "typescriptreact", "javascriptreact", "vue" },
-- })

-- -- configure lua server (with special settings)
-- lspconfig.lua_ls.setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
--     settings = { -- custom settings for lua
--         Lua = {
--             -- make the language server recognize "vim" global
--             diagnostics = {
--                 globals = { "vim" },
--             },
--             workspace = {
--                 -- make language server aware of runtime files
--                 library = {
--                     [vim.fn.expand("$VIMRUNTIME/lua")] = true,
--                     [vim.fn.stdpath("config") .. "/lua"] = true,
--                 },
--             },
--         },
--     },
-- })
