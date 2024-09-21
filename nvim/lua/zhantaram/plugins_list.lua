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
        "latex",
        "rust",
      },
      sync_install = false,
      highlight = { enable = true },
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
  config = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
    vim.keymap.set("n", "<leader>ps", builtin.live_grep, {})
  end,
}

-- Quick navigaion
local harpoon = {
  "ThePrimeagen/harpoon",
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")
    vim.keymap.set("n", "<leader>a", mark.add_file)
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
    vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
    vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
    vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
    vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
  end,
}

-- Lsp configuration
local lspconfig = {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require('lspconfig')
    lspconfig.clangd.setup {
      cmd = { "/Users/zhantaram/Programming/thirdparty/install/bin/clangd" },
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "cppm" },
    }
    lspconfig.gopls.setup {
    }
    lspconfig.lua_ls.setup {
      cmd = { "/Users/zhantaram/.installer/lua-language-server/bin/lua-language-server" },
    }
    lspconfig.pylsp.setup {
    }
    lspconfig.texlab.setup {
      cmd = { "/Users/zhantaram/.installer/texlab/target/release/texlab" },
    }
    lspconfig.rust_analyzer.setup {
      cmd = { "/Users/zhantaram/.cargo/bin/rust-analyzer" },
    }
  end,
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

-- Fold
local fold = {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  opts = {
    provider_selector = function(bufnr, filetype, buftype)
      return { "lsp" }
    end,
  },
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
  fold,
}
