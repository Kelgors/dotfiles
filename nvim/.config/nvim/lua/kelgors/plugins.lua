local function lsp_on_attach(client)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = 0,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end

  require("lsp-inlayhints").on_attach(client, vim.api.nvim_get_current_buf())

  require("kelgors.mappings").setup_lsp()
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function ()
      require("kelgors.plugins/nvim-treesitter").setup()
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    "williamboman/mason.nvim",
    priority = 89,
    version = '1.8.3',
    config = function()
      require("mason").setup()
    end,
  },
  { 
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    priority = 78,
    tag = 'v0.1.7',
    config = function ()
      require('kelgors.plugins.lspconfig').setup({ on_attach = lsp_on_attach })
    end,
  },
  { 
    'hrsh7th/nvim-cmp',
    version = '*',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip'
    },
    config = function ()
      require("kelgors.plugins.cmp").setup()
    end,
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    config = function()
      require("lsp-inlayhints").setup()
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function ()
      require('kelgors.plugins.telescope').setup()
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
      require('lualine').setup()
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
    config = function ()
      require("ibl").setup()
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function ()
      require('gitsigns').setup()
    end,
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function ()
      require('Comment').setup()
    end,
  },
  {
    'numToStr/Comment.nvim',
    lazy = false,
  },
--  {
--    'kylechui/nvim-surround',
--    version = '*',
--    event = 'VeryLazy',
--    config = function ()
--      require("nvim-surround").setup()
--    end,
--  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function ()
      require("catppuccin").setup({ flavour = "mocha" })
    end
  },
}
