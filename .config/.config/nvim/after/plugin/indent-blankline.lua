local status_ok, indentBlankline = pcall(require, "indent_blankline")

if not status_ok then
  return
end

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#585c74 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineSpaceChar guifg=#585c74 gui=nocombine]]

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

indentBlankline.setup {
  show_end_of_line = true,
  show_current_context_start = true,
  space_char_blankline = " ",
  char_highlight_list = {
    "IndentBlanklineIndent1",
  },
}
