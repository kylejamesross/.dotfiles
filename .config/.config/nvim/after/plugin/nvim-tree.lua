local status_ok, nvimTree = pcall(require, "nvim-tree")

if not status_ok then
  return
end

nvimTree.setup({
  view = {
    adaptive_size = true,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
})
