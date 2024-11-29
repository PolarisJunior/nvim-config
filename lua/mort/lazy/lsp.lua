return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "hrsh7th/cmp-nvim-lsp",
        { "j-hui/fidget.nvim", opts = {} },
        -- "hrsh7th/cmp-buffer",
        -- "hrsh7th/cmp-path",
        -- "hrsh7th/cmp-cmdline",
        -- "hrsh7th/nvim-cmp",
        -- "L3MON4D3/LuaSnip",
        -- "saadparwaiz1/cmp_luasnip",
        -- "ray-x/lsp_signature.nvim",
        -- "nvimdev/lspsaga.nvim"

        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    { path = "luvit-meta/library", words = { "vim%.uv"} }
                }
            }
        },
        { "Bilal2453/luvit-meta", lazy = true }
    },

    config = function()
        if vim.g.vscode then
            return
        end

        local lspconfig = require("lspconfig")
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local default_capabilities = vim.lsp.protocol.make_client_capabilities()
        default_capabilities = vim.tbl_deep_extend(
            "force",
            default_capabilities,
            cmp_nvim_lsp.default_capabilities()
        )

        local server_configs = {
            lua_ls = {
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace"
                        },
                        diagnostics = {
                            disable = {
                                "missing-fields"
                            }
                        }
                    }
                }
            },
            tsserver = {}
        }

        mason.setup()
        local mason_ensure_installed = vim.tbl_keys(server_configs or {})
        vim.list_extend(
            mason_ensure_installed,
            {
                "stylua"
            }
        )

        mason_tool_installer.setup({
            ensure_installed = mason_ensure_installed
        })

        mason_lspconfig.setup({
            handlers = {
                function(server_name)
                    local server_config = server_configs[server_name] or {}
                    server_config.capabilities = vim.tbl_deep_extend(
                        "force",
                        default_capabilities,
                        server_config.capabilities or {}
                    )
                    lspconfig[server_name].setup(server_config)
                end
            }
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach-keybinds", { clear = true}),
            callback = function(e)
                local keymap = function(keys, func)
                    vim.keymap.set("n", keys, func, { buffer = e.buf })
                end

                keymap("gD", vim.lsp.buf.declaration)
            end
        })

        -- local cmp = require('cmp')
        -- local cmp_lsp = require("cmp_nvim_lsp")
        -- local capabilities = vim.tbl_deep_extend(
        --     "force",
        --     {},
        --     vim.lsp.protocol.make_client_capabilities(),
        --     cmp_lsp.default_capabilities())
        --
        -- require("fidget").setup({})
        -- require("mason").setup()
        -- require("mason-lspconfig").setup({
        --     ensure_installed = {
        --         "lua_ls",
        --         "rust_analyzer",
        --         "gopls",
        --         "pyright",
        --         "elixirls"
        --     },
        --     handlers = {
        --         function(server_name) -- default handler (optional)
        --             require("lspconfig")[server_name].setup {
        --                 capabilities = capabilities
        --             }
        --         end,
        --         ["lua_ls"] = function()
        --             local lspconfig = require("lspconfig")
        --             lspconfig.lua_ls.setup {
        --                 capabilities = capabilities,
        --                 settings = {
        --                     Lua = {
        --                         -- runtime = { version = "Lua 5.1" },
        --                         diagnostics = {
        --                             globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
        --                         }
        --                     }
        --                 }
        --             }
        --         end
        --         -- ["pyright"] = function()
        --         --     local lspconfig = require("lspconfig")
        --         --     lspconfig.pyright.setup {
        --         --         capabilities = capabilities,
        --         --         root_dir = lspconfig.util.root_pattern(".git"),
        --         --         settings = {
        --         --             python = {
        --         --             }
        --         --         }
        --         --
        --         --     }
        --         -- end
        --     }
        -- })
        --
        -- -- require("lspsaga").setup({})
        -- -- require("lsp_signature").setup({})
        --
        -- local cmp_select = { behavior = cmp.SelectBehavior.Select }
        --
        -- cmp.setup({
        --     snippet = {
        --         expand = function(args)
        --             require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        --         end,
        --     },
        --     mapping = cmp.mapping.preset.insert({
        --         ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        --         ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        --         ['<enter>'] = cmp.mapping.confirm({ select = true }),
        --         ["<C-Space>"] = cmp.mapping.complete(),
        --     }),
        --     sources = cmp.config.sources(
        --         {
        --             { name = 'nvim_lsp' },
        --             { name = 'luasnip'}
        --         },
        --         {
        --             { name = 'buffer' },
        --         }
        --     ),
        -- })
        --
        -- vim.diagnostic.config({
        --     -- update_in_insert = true,
        --     float = {
        --         focusable = false,
        --         style = "minimal",
        --         border = "rounded",
        --         source = "always",
        --         header = "",
        --         prefix = "",
        --     },
        -- })
    end
}
