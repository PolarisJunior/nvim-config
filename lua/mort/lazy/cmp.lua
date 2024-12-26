if vim.g.vscode then
    return
end

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-path"
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        luasnip.config.setup({})

        cmp.setup({
            completion = {},
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                -- ["<C-Space>"] = cmp.mapping.complete(),
                -- ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true
                }),
                ["<C-l>"] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { "i", "s" }),
                ["<C-h>"] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end)
            }),
            sources = cmp.config.sources({
                { name = "luasnip" },
                { name = "nvim_lsp" },
                { name = "path" }
            }),
            window = {
                completion = cmp.config.window.bordered({
                    max_height = 10,
                    max_width = 50
                }),
                documentation = cmp.config.window.bordered(),
            }
        })

    end
}
