
local status_ok, typescript = pcall(require, "typescript")
if not status_ok then
	return
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
    end
  }
})
