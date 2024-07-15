return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function(_, opts)
        require("nvim-autopairs").setup(opts)
    end,
    opts = {
        fastwrap = {},
        disable_filetype = { "TelescopePrompt", "vim" }
    }
}
