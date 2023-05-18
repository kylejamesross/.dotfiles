
local status_ok, typescript = pcall(require, "typescript")
if not status_ok then
	return
end

function PopulateQuickfixWithTypescriptErrors()
  local command_output = vim.fn.systemlist("tsc --noEmit --pretty false 2>&1 | grep '([^,]*,[^)]*)'")

  vim.fn.setqflist({}, 'r')

for _, line in ipairs(command_output) do
    local filename, lnum, col, text = line:match('(%S+)%((%d+),(%d+)%): error%s(.+)')
    if filename and lnum and col and text then
      local entry = {
        filename = filename,
        lnum = tonumber(lnum),
        col = tonumber(col),
        text = text,
      }
      vim.fn.setqflist({entry}, 'a')
    end
  end

  vim.cmd('copen')
end

typescript.setup({
  server = {
    on_attach = function(_, bufnr)
    vim.keymap.set("n", "<leader>l1", ":TypescriptAddMissingImports<CR>",
    { buffer = bufnr, remap = false, silent = true, desc = "Add missing imports" })
    vim.keymap.set("n", "<leader>l2", ":TypescriptRemoveUnused<CR>",
    { buffer = bufnr, remap = false, silent = true, desc = "Remove unused imports" })
    vim.keymap.set("n", "<leader>l3", ":TypescriptRenameFile<CR>",
    { buffer = bufnr, remap = false, silent = true, desc = "File rename" })
    vim.keymap.set("n", "<leader>l4", ":TypescriptFixAll<CR>",
    { buffer = bufnr, remap = false, silent = true, desc = "Typescript fix all" })
    vim.keymap.set("n", "<leader>l5", ":TypescriptOrganizeImports<CR>",
    { buffer = bufnr, remap = false, silent = true, desc = "Organize imports" })
    vim.keymap.set("n", "<Leader>qt", ':lua PopulateQuickfixWithTypescriptErrors()<CR>', { noremap = true, silent = true, desc = "Populate quickfix list with typescript errors" })
    end
  }
})
