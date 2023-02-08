local ok, cybu = pcall(require, "cybu")
if not ok then
  return
end

cybu.setup({
  display_time = 1000,
  position = {
    relative_to = "win", -- win, editor, cursor
    anchor = "topcenter", -- topleft, topcenter, topright,
    -- centerleft, center, centerright,
    -- bottomleft, bottomcenter, bottomright
    vertical_offset = -1, -- vertical offset from anchor in lines
    horizontal_offset = -1, -- vertical offset from anchor in columns
    max_win_height = 5, -- height of cybu window in lines
    max_win_width = 0.5, -- integer for absolute in columns
    -- float for relative width to win/editor
  },
  behavior = { -- set behavior for different modes
    mode = {
      default = {
        switch = "on_close", -- immediate, on_close
        view = "rolling", -- paging, rolling
      },
      last_used = {
        switch = "immediate", -- immediate, on_close
        view = "rolling", -- paging, rolling
      },
      auto = {
        view = "rolling", -- paging, rolling
      },
    },
    show_on_autocmd = false, -- event to trigger cybu (eg. "BufEnter")
  },
})
