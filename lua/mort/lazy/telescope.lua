return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require("telescope").setup({})

        local builtin = require("telescope.builtin")

        if vim.g.vscode then
            vim.keymap.set("n", "<leader>pf", "<cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>", {})
            vim.keymap.set("n", "<leader>pg", builtin.git_files, {})
            vim.keymap.set("n", "<C-x><C-f>",  "<cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>", {})
            vim.keymap.set("n", "<leader>ps", "<cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>", {})
        else
            vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
            vim.keymap.set("n", "<leader>pg", builtin.git_files, {})
            vim.keymap.set("n", "<C-x><C-f>", builtin.find_files, {})
            vim.keymap.set("n", "<leader>ps", "<cmd>Telescope live_grep<CR>", {})
        end
    end
}

