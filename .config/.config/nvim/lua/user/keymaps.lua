local keymap = vim.api.nvim_set_keymap

-- leader key
keymap("", "<Space>", "<Nop>", { noremap = true, silent = true, desc = "[LEADER]" })
vim.g.mapleader = " "
vim.g.maplocallheader = " "

-- vscode mapping for file navigation
keymap("n", "<Tab>", "<C-6>", { noremap = true, silent = true, desc = "Switch to previous buffer" })

-- recenter after page up / page down / searching
keymap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true, desc = "Move down half a page" })
keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true, desc = "Move up half a page" })
keymap("n", "n", "nzzzv", { noremap = true, silent = true, desc = "Repeat search in same direction" })
keymap("n", "N", "Nzzzv", { noremap = true, silent = true, desc = "Repeat search in opposite direction" })

-- easy window movements
keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Go to the left window" })
keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Go to the bottom window" })
keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Go to the up window" })
keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Go to the right window" })

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", { noremap = true, silent = true, desc = "Increase window size vertically" })
keymap("n", "<C-Down>", ":resize -2<CR>", { noremap = true, silent = true, desc = "Descrease window size vertically" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true, desc = "Descrease window size horizontally" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true, desc = "Increase window size horizontally" })

-- Navigate buffers
keymap("n", "<M-l>", ":bnext<CR>", { noremap = true, silent = true, desc = "Go to next buffer" })
keymap("n", "<M-h>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Go to previous buffer" })

keymap("n", "<Leader>b", ":w | %bd | e# | bd#<CR>", { noremap = true, silent = true, desc = "Delete all buffers except the active one" })
keymap("n", "<Leader>qq", ":cclose<CR>", { noremap = true, silent = true, desc = "Open quickfix list" })
keymap("n", "<Leader>qo", ":copen<CR>", { noremap = true, silent = true, desc = "Close quickfix list" })
keymap("n", "<Leader>ll", ":lclose<CR>", { noremap = true, silent = true, desc = "Close location list" })
keymap("n", "<Leader>lo", ":lopen<CR>", { noremap = true, silent = true, desc = "Open location list" })
keymap("n", "]q", ":cnext<CR>", { noremap = true, silent = true, desc = "Next quickfix list item" })
keymap("n", "[q", ":cprev<CR>", { noremap = true, silent = true, desc = "Previous quickfix list item" })
keymap("n", "]l", ":lnext<CR>", { noremap = true, silent = true, desc = "Next location list item" })
keymap("n", "[l", ":lprev<CR>", { noremap = true, silent = true, desc = "Previous location list item" })

-- easy executeable file
keymap("n", "<Leader>x", ":!chmod +x %<CR>", { noremap = true, silent = true, desc = "Make file executeable" })

-- paste enhancements
keymap("n", "<Leader>p", '"_dP', { noremap = true, silent = true, desc = "Paste without replacing register" })
keymap("v", "<Leader>p", '"_dP', { noremap = true, silent = true, desc = "Paste without replacing register" })
keymap("v", "<Leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to system clipboard" })
keymap("n", "<Leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to system clipboard" })
keymap("v", "<Leader>w", '"+p', { noremap = true, silent = true, desc = "Paste from system clipboard" })
keymap("n", "<Leader>w", '"+p', { noremap = true, silent = true, desc = "Paste from system clipboard" })
keymap("v", "p", '"_dP', { noremap = true, silent = true, desc = "Paste" })

-- paste into system clipboard
keymap("n", "<Leader>Y", 'gg"+yG', { noremap = true, silent = true, desc = "Yank entire buffer to system clipboard" })

-- move select lines up down
keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move line down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move line up" })

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", { noremap = true, silent = true, desc = "Move line down" })
keymap("x", "K", ":move '<-2<CR>gv-gv", { noremap = true, silent = true, desc = "Move line up" })

-- insert mode movements
keymap("i", "<C-k>", "<Up>", { noremap = true, silent = true, desc = "Move up" })
keymap("i", "<C-j>", "<Down>", { noremap = true, silent = true, desc = "Move down" })
keymap("i", "<C-l>", "<Right>", { noremap = true, silent = true, desc = "Move right" })
keymap("i", "<C-h>", "<Left>", { noremap = true, silent = true, desc = "Move left" })

-- tab enhancements
keymap("v", "<Tab>", ">><Esc>gv", { noremap = true, silent = true, desc = "Increase Indent" })
keymap("v", "<S-Tab>", "<<<Esc>gv", { noremap = true, silent = true, desc = "Descrease Indent" })

-- fix Y
keymap("n", "Y", "y$", { noremap = true, silent = true, desc = "Yank Line" })

-- editor
keymap("n", "<Leader>e", ":NvimTreeFindFileToggle<CR>", { noremap = true, silent = true, desc = "Explorer" })

-- easy motion
keymap("", "<c-s>", "<cmd>:HopChar1<cr>", { noremap = true, desc = "Search for character" })

-- telescope
keymap("n", "<c-t>", "<cmd>Telescope live_grep<cr>",
  { noremap = true, silent = true, desc = "Search for string in all files" })

function ProjectFiles()
  local ok = pcall(require("telescope.builtin").git_files, { show_untracked = true })
  if not ok then
    require("telescope.builtin").find_files({ hidden = true })
  end
end

keymap("n", "<c-p>", "<CMD>lua ProjectFiles()<CR>", { noremap = true, silent = true, desc = "Search for file" })

-- markdown
keymap("n", "<leader>mc", "0ci]x<Esc>j", { noremap = true, silent = true, desc = "Complete markdown list item" })
keymap("n", "<leader>mu", "0ci]<Space><Esc>j", { noremap = true, silent = true, desc = "Uncomplete markdown list item" })

-- git
keymap("n", "<leader>vf", ":Gllog %<CR>", { noremap = true, silent = true, desc = "Display commits for current file" })
keymap("n", "<leader>vm", ":Gvdiffsplit!<CR>",
{ noremap = true, silent = true, desc = "Display side-by-side merge tool" })
keymap("n", "<leader>vh", "<cmd>diffget //2<CR>",
  { noremap = true, silent = true, desc = "Accept code changes left side" })
keymap("n", "<leader>vl", "<cmd>diffget //3<CR>",
  { noremap = true, silent = true, desc = "Accept code changes right side" })

-- refactoring  
keymap("v", "<leader>rx", ":Xtract<Space>", { noremap = true, desc = "Extract code to file" })
keymap("n", "<Leader>s", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>",
  { noremap = true, silent = true, desc = "Replace all occurances of word under cursor in buffer" })
function AutoIndent()
  local save_cursor = vim.fn.winsaveview()
  vim.cmd("%normal! =G")
  vim.fn.winrestview(save_cursor)
end

keymap("n", "<Leader>r=", ":lua AutoIndent()<CR>", { noremap = true, silent = true, desc = "Indent all lines in buffer" })

-- undo
keymap("n", "<leader>u", ":UndotreeToggle<CR>", { noremap = true, silent = true, desc = "Open undo tree" })

-- AI
vim.keymap.set("n", "<leader>aa", "<cmd>:NeoAI<CR>", { noremap = true, silent = true, desc = "Open editor" })
vim.keymap.set("n", "<leader>ac", "<cmd>:NeoAIContext<CR>", { noremap = true, silent = true, desc = "Open editor with context" })
vim.keymap.set("v", "<leader>ac", "<cmd>:'<,'>NeoAIContext<CR>", { noremap = true, silent = true, desc = "Open editor with context" })
vim.keymap.set("n", "<leader>ai", ":NeoAIInjectContext ", { noremap = true, desc = "AI Command with context" })
vim.keymap.set("v", "<leader>ai", ":'<,'>NeoAIInjectContext ", { noremap = true, desc = "AI Command with context" })
vim.keymap.set("n", "<leader>ae", ":Chat", { noremap = true, desc = "AI Text Edit" })
vim.keymap.set("v", "<leader>ae", ":'<,'>Chat ", { noremap = true, desc = "AI Text Edit" })
