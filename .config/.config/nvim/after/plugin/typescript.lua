
local status_ok, typescript = pcall(require, "typescript")
if not status_ok then
	return
end

function PopulateQuickfixWithTypescriptErrors()
  local command_output = vim.fn.systemlist("tsc --noEmit 2>&1 | grep '(*,*):' | cut -d '(' -f 1 | uniq")

  vim.fn.setqflist({}, 'r')

  for _, line in ipairs(command_output) do
    local entry = {
      filename = line,
      lnum = 0,
      col = 0,
    }
    vim.fn.setqflist({entry}, 'a')
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
    vim.keymap.set("n", "<Leader>qt", ':lua PopulateQuickfix()<CR>', { noremap = true, silent = true, desc = "Populate quickfix list with typescript errors" })
    end
  }
})
