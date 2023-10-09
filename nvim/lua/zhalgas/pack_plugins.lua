-- Parser for LSP
local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "cpp",
        "python",
        "go",
        "rust",
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}

-- Colorscheme
local folke = {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
}

local rose_pine = {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  opts = {},
}

-- Code search
local telescope = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "BurntSushi/ripgrep",
  },
}

-- Quick navigaion
local harpoon = {
  "ThePrimeagen/harpoon"
}

-- Lsp configuration
local lspconfig = {
  "neovim/nvim-lspconfig",
}

-- Lsp autocomplete
local cmp = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup {
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
        ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
      },
      sources = {
        { name = "nvim_lsp", },
        { name = "luasnip", }
      }
    }
  end,
}

-- Commenter
local comment = {
  "numToStr/Comment.nvim",
  lazy = false,
  opts = {}
}

return {
  treesitter,
  folke,
  rose_pine,
  telescope,
  harpoon,
  lspconfig,
  cmp,
  comment,
}
