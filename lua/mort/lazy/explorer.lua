return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        require("nvim-tree").setup({})
        vim.keymap.set("n","<leader>te", "<cmd>NvimTreeToggle<CR>")
    end
}
