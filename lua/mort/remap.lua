vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- This is bound to K by default
-- vim.keymap.set("n", "<C-i>", vim.lsp.buf.hover)

-- https://github.com/neovim/neovim/pull/28650/files
-- https://neovim.io/doc/user/lsp.html#lsp-config
-- At the time of writing these were just added back to neovim
vim.keymap.set("n", "grn", vim.lsp.buf.rename)
vim.keymap.set("n", "gra", vim.lsp.buf.code_action)
vim.keymap.set("n", "grr", vim.lsp.buf.references)
vim.keymap.set("n", "<leader>ff", function() vim.lsp.buf.format({ async = true }) end)
-- vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help)

-- Move lines around while highlighted
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep things centered
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Do things without removing from the register
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Windowing
-- Actually just use built-in keys like C-W s, C-W v C-W q, C-W o
-- vim.keymap.set("n", "<leader>wh", "<cmd>split<CR>")
-- vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<CR>")
-- vim.keymap.set("n", "<leader>wx", "<cmd>close<CR>")

vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

vim.keymap.set(
    "v",
    "<leader>y",
    '"+y'
)

vim.keymap.set(
    "n",
    "<leader>cfg",
    function()
        local config_path = vim.fn.stdpath("config")
        vim.cmd("edit " .. config_path)
    end

)

