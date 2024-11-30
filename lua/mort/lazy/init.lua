local all = {
}

if not vim.g.vscode then
    local vim_only = {
        "danilamihailov/beacon.nvim",
        {
            "lukas-reineke/indent-blankline.nvim",
            main = "ibl",
            ---@module "ibl"
            ---@type ibl.config
            opts = {},
        }
    }
    for k, v in pairs(vim_only) do all[k] = v end
end

return all


