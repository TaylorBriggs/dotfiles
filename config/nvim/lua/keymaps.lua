vim.keymap.set({ "n", "v" }, "<leader>", "<nop>", { silent = true })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

vim.keymap.set("n", "<leader><leader>", "<C-^>")

vim.keymap.set("n", "Y", "y$")
