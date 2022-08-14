
local options = {
    number = true,
    relativenumber = true,
    signcolumn = "number",
    swapfile = false,
    backup = false,
    hlsearch = false,
    ignorecase = true,
    history = 1000,
    ruler = true,
    showcmd = true,
    wildmenu = true,
    scrolloff = 8,
    incsearch = true,
    expandtab  = true,
    wrap = false,
    shiftwidth = 2,
    tabstop = 2,
    softtabstop = 2,
    hidden = true,
    autoindent = true,
    smartindent = true,
    updatetime = 250,
    fileencoding = "UTF-8",
    updatetime= 250,
--    clipboard = "unnamedplus",
    cmdheight = 2,
    conceallevel = 0,
    showtabline = 2,
    splitbelow = true,
    splitright = true,
    completeopt = { "menuone", "noselect" },
    timeoutlen = 1000,
    undofile = true,
    numberwidth = 2,
    guifont = "monospace:h17",
}

-- set all options
for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "let g:EasyMotion_smartcase = 1"
