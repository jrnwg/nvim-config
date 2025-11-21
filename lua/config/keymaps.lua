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
