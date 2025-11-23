local map = vim.keymap.set

-- Terminal escape
map("t", "<Esc><Esc>", "<C-\\><C-n>", { silent = true })

-- Clear search highlights
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Clipboard
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

-- Buffer navigation
map("n", "<leader><tab>", "<cmd>b#<CR>")

-- Diagnostics
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic list" })
