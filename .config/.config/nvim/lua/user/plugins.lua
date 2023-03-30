local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.env.GIT_DIR = nil
  vim.env.GIT_WORK_TREE = nil
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
  "tpope/vim-sleuth",
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
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
  },
  "JoosepAlviste/nvim-ts-context-commentstring",
  "p00f/nvim-ts-rainbow",
  "windwp/nvim-ts-autotag",

  -- Utilities
  "rstacruz/vim-xtract",
  "tpope/vim-surround",
  { 'j-hui/fidget.nvim',       opts = {} },
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
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },         -- Required
      { 'hrsh7th/cmp-nvim-lsp' },     -- Required
      { 'hrsh7th/cmp-buffer' },       -- Optional
      { 'hrsh7th/cmp-path' },         -- Optional
      { 'saadparwaiz1/cmp_luasnip' }, -- Optional
      { 'hrsh7th/cmp-nvim-lua' },     -- Optional

      -- Snippets
      { 'L3MON4D3/LuaSnip' },             -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional
    }
  },
  "jose-elias-alvarez/typescript.nvim",
  "RRethy/vim-illuminate",
}

lazy.setup(plugins)
