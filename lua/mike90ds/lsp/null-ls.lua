-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
    return
end

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local function num_to_bool(num)
    if num == 0 then
        return false
    elseif num == 1 then
        return true
    end
end

-- https://youtu.be/b7OguLuaYvE?list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ&t=632
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
-- :NullLsInfo in you particular language file to check what it's using and what's available
null_ls.setup({
    sources = {
        --  to disable file types use
        --  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
        formatting.prettierd, -- js/ts formatter
        formatting.stylua, -- lua formatter
        formatting.black,
        formatting.isort,
        diagnostics.pylint,
        -- diagnostics.eslint_d,
        diagnostics.eslint_d.with({ -- js/ts linter
            -- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
            condition = function(utils)
                local has_eslint_file = utils.root_has_file(".eslintrc.cjs")
                    or utils.root_has_file(".eslintrc")
                    or utils.root_has_file(".eslintrc.json")
                    or num_to_bool(vim.fn.filereadable(vim.fn.getcwd() .. "/backend/.eslintrc.cjs"))
                    or num_to_bool(vim.fn.filereadable(vim.fn.getcwd() .. "/.eslintrc.cjs"))
                    or num_to_bool(vim.fn.filereadable(vim.fn.getcwd() .. "/.eslintrc.json"))
                    or num_to_bool(vim.fn.filereadable(vim.fn.getcwd() .. "/backend/.eslintrc.json"))
                    or num_to_bool(vim.fn.filereadable(vim.fn.getcwd() .. "/backend/.eslintrc"))
                    or num_to_bool(vim.fn.filereadable(vim.fn.getcwd() .. "/frontend/.eslintrc.cjs"))
                    or num_to_bool(vim.fn.filereadable(vim.fn.getcwd() .. "/frontend/.eslintrc"))
                -- print(not not has_eslint_file)
                return not not has_eslint_file -- change file extension if you use something else
            end,
        }),
    },
    -- configure format on save
    on_attach = function(current_client, bufnr)
        if current_client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        filter = function(client)
                            --  only use null-ls for formatting instead of lsp server
                            return client.name == "null-ls"
                        end,
                        bufnr = bufnr,
                    })
                end,
            })
        end
    end,
})
