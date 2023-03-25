local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

local plugins = {

  -- Regular
  {
    "phaazon/hop.nvim",
  },
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "numToStr/Comment.nvim",
  "lewis6991/impatient.nvim",
  "lukas-reineke/indent-blankline.nvim",
  {
    "goolord/alpha-nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },
  "windwp/nvim-autopairs",

  -- Tree
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
  },

  -- Snippets
  "kylejamesross/snippets",

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    cmd = "TSUpdate",
  },
  "JoosepAlviste/nvim-ts-context-commentstring",
  "p00f/nvim-ts-rainbow",
  "windwp/nvim-ts-autotag",
  -- Utilities
  "rstacruz/vim-xtract",
  "tpope/vim-surround",
  "NvChad/nvim-colorizer.lua",
  {
    "ghillb/cybu.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons", "nvim-lua/plenary.nvim" },
  },

  -- Telescope
  "nvim-telescope/telescope.nvim",
  "nvim-telescope/telescope-fzy-native.nvim",
  "nvim-telescope/telescope-media-files.nvim",

  -- Color schemes
  "Mofiqul/dracula.nvim",

  -- Git
  "lewis6991/gitsigns.nvim",

  -- Lines
  { "akinsho/bufferline.nvim", dependencies = { "kyazdani42/nvim-web-devicons" } },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },

  -- Scrollbar
  "petertriho/nvim-scrollbar",

  -- LSP
  "mbbill/undotree",
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v1.x",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "L3MON4D3/LuaSnip" },
    },
  },
  "jose-elias-alvarez/typescript.nvim",
  "RRethy/vim-illuminate",
}

lazy.setup(plugins)
