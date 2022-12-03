local keymap = vim.api.nvim_set_keymap
local term_opts = { silent = true }
local opts = { noremap = true, silent = true }

keymap("", "<Space>", "<Nop>", opts)

vim.g.mapleader = " "
vim.g.maplocallheader = " "

if vim.g.vscode then
	keymap("n", "<Leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g", opts)
else
	keymap("n", "<Leader>s", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>", opts)
end

-- vscode mapping
keymap("n", "<Leader><Tab>", "<C-6>", opts)

-- editor
keymap("n", "<Leader>e", ":NvimTreeFindFileToggle<CR>", opts)

-- recenter after page up / page down / searching
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- easy window movements
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-s>", "s", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<M-l>", ":bnext<CR>", opts)
keymap("n", "<M-h>", ":bprevious<CR>", opts)
keymap("n", "<Leader>bd", ":%bd|e#|bd#<CR>", opts)
keymap("n", "<Leader>cc", ":cclose<CR>", opts)
keymap("n", "<Leader>co", ":copen<CR>", opts)
keymap("n", "<M-j>", ":cnext<CR>", opts)
keymap("n", "<M-k>", ":cprev<CR>", opts)

-- easy executeable file
keymap("n", "<Leader>x", ":!chmod +x %<CR>", opts)

-- git actions
keymap("n", "<Leader>ga", ":!git add --all<CR>", opts)

-- paste enhancements
keymap("v", "<Leader>p", '"_dP', opts)
keymap("v", "<Leader>y", '"+y', opts)
keymap("n", "<Leader>y", '"+y', opts)
keymap("v", "<Leader>w", '"+p', opts)
keymap("n", "<Leader>w", '"+p', opts)
keymap("v", "p", '"_dP', opts)

-- paste into system clipboard
keymap("n", "<Leader>Y", 'gg"+yG', opts)

-- move select lines up down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
keymap("v", "<M-k>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<M-j>", ":m '<-2<CR>gv=gv", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- insert mode movements
keymap("i", "<C-k>", "<Up>", opts)
keymap("i", "<C-j>", "<Down>", opts)
keymap("i", "<C-l>", "<Right>", opts)
keymap("i", "<C-h>", "<Left>", opts)

-- tab enhancements
keymap("n", ">>", "<Nop>", term_opts)
keymap("n", "<<", "<Nop>", term_opts)
keymap("v", ">>", "<Nop>", term_opts)
keymap("v", "<<", "<Nop>", term_opts)
--[[ keymap("n", "<Tab>",">>", opts); ]]
keymap("n", "<S-Tab>", "<<", opts)
keymap("v", "<Tab>", ">><Esc>gv", opts)
keymap("v", "<S-Tab>", "<<<Esc>gv", opts)

-- fix Y
keymap("n", "Y", "y$", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- easy motion
keymap("", "s", "<cmd>:HopChar1<cr>", {})
-- telescope
keymap("n", "<c-t>", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<c-p>", "<cmd>Telescope git_files<cr>", opts)
keymap("n", "<c-p>", "<CMD>lua require'user.telescope-config'.project_files()<CR>", opts)

-- git
keymap("n", "<leader>vf", ":terminal git log -p %<CR>", opts)
keymap("n", "<leader>mc", "0ci]x<Esc>", opts)
keymap("n", "<leader>mu", "0ci]<Space><Esc>", opts)
keymap("n", "<leader>vf", ":terminal git log -p %<CR>", opts)
keymap("v", "gx", ":Xtract<Space>", opts)
