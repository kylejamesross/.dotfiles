local keymap = vim.api.nvim_set_keymap
local term_opts = { silent = true }
local opts = { noremap = true, silent = true }

keymap("", "<Space>", "<Nop>", opts)

vim.g.mapleader = " "
vim.g.maplocallheader = " "

if vim.g.vscode then
  keymap("n", "<Leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g", opts)
else
  keymap("n", "<Leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>", opts)
end

-- editor
keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- easy window movement
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- easy executeable file
keymap("n", "<leader>x", ":!chmod +x %<CR>", opts);

-- paste enhancements
keymap("v", "<leader>p", '"_dP', opts);
keymap("v", "<leader>y", '"+y', opts);
keymap("n", "<leader>y", '"+y', opts);
keymap("v", "<leader>w", '"+p', opts);
keymap("n", "<leader>w", '"+p', opts);
keymap("v", "p", '"_dP', opts);

-- paste into system clipboard
keymap("n", "<leader>Y", 'gg"+yG', opts);

-- move select lines up down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts);
keymap("v", "K", ":m '<-2<CR>gv=gv", opts);

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- insert mode movements
keymap("i", "<Up>", "<Nop>", term_opts);
keymap("i", "<Down>", "<Nop>", term_opts);
keymap("i", "<Left>", "<Nop>", term_opts);
keymap("i", "<Right>", "<Nop>", term_opts);
keymap("i", "<C-k>", "<Up>", opts);
keymap("i", "<C-j>", "<Down>", opts);
keymap("i", "<C-l>", "<Right>", opts);
keymap("i", "<C-h>", "<Left>", opts);

-- tab enhancements
keymap("n", ">>", "<Nop>", term_opts);
keymap("n", "<<", "<Nop>", term_opts);
keymap("v", ">>", "<Nop>", term_opts);
keymap("v", "<<", "<Nop>", term_opts);
keymap("n", "<Tab>",">>", opts);
keymap("n", "<S-Tab>", "<<", opts);
keymap("v", "<Tab>", ">><Esc>gv", opts);
keymap("v", "<S-Tab>", "<<<Esc>gv", opts);

-- fix Y
keymap("n", "Y", "y$", opts);

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- easy motion
keymap("n", "s", "<Plug>(easymotion-s)", opts);
