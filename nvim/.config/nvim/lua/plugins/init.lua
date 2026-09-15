return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
	  -- for tmux
    "christoomey/vim-tmux-navigator",
	lazy = false,
  },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
        "html", "css", "c", "cpp", "python", "javascript", "asm"
  		},
  	},
  },

  -- nvim-tree
  {
  "nvim-tree/nvim-tree.lua",
  opts = require("configs.nvimtree"),
  },
  
  --[[
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<C-l>",
          accept_word = false,
          accept_line = false,
          next = "<C-j>",
          prev = "<C-k>",
          dismiss = "<C-h>",
        },
      },
    },
  },
  ]]
 
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    -- FIX: Use a shell command instead of the Vimscript function
    build = "cd app && npm install", 
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  }, 

  {
    "nvim-telescope/telescope.nvim",
    opts = require "configs.telescope",
  },



    {
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      event = "BufReadPost",
      config = function()
        require("todo-comments").setup({
          keywords = {
            TODO = { icon = " ", color = "info" },
          },

          highlight = {
            keyword = "bg",
            comments_only = true,
            -- FIX: Removed \s* to prevent the "out of range" EOL bug!
            pattern = [[.*<(KEYWORDS)]], 
          },

          search = {
            pattern = [[\b(KEYWORDS)\b]],
          },
        })
      end,
    },

    {
      "3rd/image.nvim",
      build = false,
      ft = { "markdown", "vimwiki" },
      opts = {
        processor = "magick_cli",
      },
      config = function(_, opts)
        require("image").setup(opts)

        -- Use :ImageToggle to enable or disable inline image rendering.
        vim.api.nvim_create_user_command("ImageToggle", function()
          local image = require("image")
          if image.is_enabled() then
            image.disable()
          else
            image.enable()
          end
        end, { desc = "Toggle image.nvim rendering" })
      end,
    },

    {
      "OXY2DEV/markview.nvim",
      lazy = false,
    },

    -- don't close the menu
    

   }
