local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.format_on_save({
    servers = {
        ['lua_ls'] = { 'lua' },
        ['gopls'] = { 'go' },
        ['bashls'] = { 'sh' },
        ['buf_ls'] = { 'proto' },
        ['ruff'] = { 'python' },
    }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'buffer',  keyword_length = 3 },
    },
    formatting = lsp.cmp_format({ details = false }),
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)
--
-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
local lsp_config = require("lspconfig")
local util = require("lspconfig/util")

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- For gopls
lsp.configure('gopls', {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gosum", "gowork", "gotmpl" },
    root_dir = require("lspconfig/util").root_pattern("go.mod", ".git", "go.work"),
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            semanticTokens = true,
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            gofumpt = true,
            staticcheck = true,
        }
    }
})

-- Configure Mason-LSPCONFIG through lsp-zero's interface
lsp.setup_servers({
    "rust_analyzer", "gopls", "bashls",
    "buf_ls", "lua_ls", "pyright",
})

-- You can provide custom settings for each server using lsp.configure
-- Remove the `require("mason-lspconfig").setup` block with handlers.
-- Instead, use lsp.configure for each server where you need custom settings.

-- For gopls
lsp.configure('gopls', {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gosum", "gowork", "gotmpl" },
    root_dir = require("lspconfig/util").root_pattern("go.mod", ".git", "go.work"),
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            semanticTokens = true,
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            gofumpt = true,
            staticcheck = true,
        }
    }
})

-- For pyright
lsp.configure('pyright', {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_dir = require("lspconfig/util").root_pattern("pyproject.toml", "setup.py", ".git"),
    settings = {
        python = {
            disableLanguageServices = false,
            disableOrganizeImports = false,
            analysis = {
                typeCheckingMode = "basic",
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
                autoImportCompletions = true,
                autoSearchPaths = true,
            }
        }
    }
})

-- For buf_ls
lsp.configure('buf_ls', {
    cmd = { "buf", "beta", "lsp" },
    filetypes = { "proto" },
    root_dir = require("lspconfig/util").root_pattern("buf.yaml", ".git"),
})

-- For lua_ls, lsp-zero has a dedicated function
-- You can use lsp.nvim_lua_ls() if you want the default lua_ls setup from lsp-zero
-- Or configure it manually if you have specific needs beyond `lsp.nvim_lua_ls()`
lsp.configure('lua_ls', lsp.nvim_lua_ls())

-- `lsp.setup()` needs to be called after all configurations.
-- This function calls `mason-lspconfig.setup` and `lspconfig.<server>.setup` internally
-- based on what you've configured with `lsp.setup_servers` and `lsp.configure`.
lsp.setup()

-- *** END OF MODIFICATIONS ***

vim.diagnostic.config({
    virtual_text = true
})
