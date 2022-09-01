
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local M = {}

M.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require"telescope.builtin".git_files, { show_untracked = true })
  if not ok then require"telescope.builtin".find_files(opts) end
end

return M
