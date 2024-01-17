local set = vim.opt
set.encoding = "UTF-8"
set.number = true
set.relativenumber = true
set.autoindent = true
set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.smartindent = true
set.softtabstop = 2
set.clipboard = "unnamedplus"
-- Change leader key
vim.keymap.set("n", " ", "<nop>", { silent = true, remap = false })
vim.g.mapleader = ' '
-- vim.keymap.set('n', ' ', '<nop>')
-- Remove arrow keys
for _, mode in pairs({ 'n', 'i', 'v', 'x' }) do
    for _, key in pairs({ '<Up>', '<Down>', '<Left>', '<Right>' }) do
        vim.keymap.set(mode, key, '<nop>')
    end
end


