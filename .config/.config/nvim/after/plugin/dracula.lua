local status_ok, dracula = pcall(require, "dracula")
if not status_ok then
  return
end

dracula.setup({
  colors = {
    bg = "#22212c",
    fg = "#f8f8f2",
    selection = "#454158",
    comment = "#7470a9",
    purple = "#9580ff",
    green = "#8aff80",
    red = "#ff9580",
    pink = "#ff80bf",
    yellow = "#ffff80",
    orange = "#ff9580",
    cyan = "#80ffea",
    bright_purple = "#9b87ff",
    bright_green = "#8fff8f",
    bright_red = "#ffb094",
    bright_pink = "#ff8ec3",
    bright_yellow = "#ffff94",
    bright_orange = "#ffb094",
    bright_cyan = "#85ffe9",
    menu = "#22212c",
    visual = "#3D4453",
    gutter_fg = "#766FAA",
    nontext = "#3A4049",
  },
  lualine_bg_color = "#22212c",
  italic_comment = true,
})

vim.cmd("colorscheme dracula")
