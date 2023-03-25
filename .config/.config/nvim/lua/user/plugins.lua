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
  "kyazdani42/nvim-web-devicons",
  {
    "phaazon/hop.nvim",
    branch = "v2",
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
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
  },
  "kylejamesross/snippets",
  {
    "nvim-treesitter/nvim-treesitter",
    cmd = "TSUpdate",
  },
  "JoosepAlviste/nvim-ts-context-commentstring",
  "p00f/nvim-ts-rainbow",
  "windwp/nvim-ts-autotag",
  "rstacruz/vim-xtract",
  "tpope/vim-surround",
  "NvChad/nvim-colorizer.lua",
  "nvim-telescope/telescope.nvim",
  "nvim-telescope/telescope-fzy-native.nvim",
  "nvim-telescope/telescope-media-files.nvim",
  "Mofiqul/dracula.nvim",
  "lewis6991/gitsigns.nvim",
  { "akinsho/bufferline.nvim", tag = "v3.*", dependencies = { "kyazdani42/nvim-web-devicons" } },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },
  "petertriho/nvim-scrollbar",
  "mbbill/undotree",
  {
    "VonHeikemen/lsp-zero.nvim",
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
  "RRethy/vim-illuminate",
  "jose-elias-alvarez/typescript.nvim",
  {
    "ghillb/cybu.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons", "nvim-lua/plenary.nvim" },
  }
}

lazy.setup(plugins)
