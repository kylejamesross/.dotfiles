local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

vim.o.timeout = true
vim.o.timeoutlen = 300
require("which-key").setup({})

which_key.register({
  v = {
    name = "[VERSION_CONTROL]"
  }
}, { prefix = "<leader>" })

which_key.register({
  m = {
    name = "[MARKDOWN]"
  }
}, { prefix = "<leader>" })

which_key.register({
  l = {
    name = "[LSP]",
    t = {
      name = "[TYPESCRIPT]",
    }
  }
}, { prefix = "<leader>" })

which_key.register({
  t = {
    name = "[TYPESCRIPT]",
  }
}, { prefix = "<leader>" })

which_key.register({
  a = {
    name = "[AI]"
  }
}, { prefix = "<leader>" })

which_key.register({
  q = {
    name = "[QUICK_FIX_LIST]"
  }
}, { prefix = "<leader>" })

which_key.register({
  l = {
    name = "[LOCATION_LIST]"
  }
}, { prefix = "<leader>" })

which_key.register({
  r = {
    name = "[REFACTORING]"
  }
}, { prefix = "<leader>" })

which_key.register({
  r = {
    name = "[REFACTORING]"
  }
}, { mode = "v", prefix = "<leader>" })

which_key.register({
  h = {
    name = "[HUNKS]"
  }
}, { prefix = "<leader>" })

which_key.register({
  h = {
    name = "[HUNKS]"
  }
}, { mode = "v", prefix = "<leader>" })
