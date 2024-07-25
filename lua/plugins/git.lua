return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      -- local icons = require('config.icons')
      require("gitsigns").setup {
        -- signs = {
        --   add = {
        --     hl = "GitSignsAdd",
        --     text = icons.ui.BoldLineLeft,
        --     numhl = "GitSignsAddNr",
        --     linehl = "GitSignsAddLn",
        --   },
        --   change = {
        --     hl = "GitSignsChange",
        --     text = icons.ui.BoldLineLeft,
        --     numhl = "GitSignsChangeNr",
        --     linehl = "GitSignsChangeLn",
        --   },
        --   delete = {
        --     hl = "GitSignsDelete",
        --     text = icons.ui.TriangleShortArrowRight,
        --     numhl = "GitSignsDeleteNr",
        --     linehl = "GitSignsDeleteLn",
        --   },
        --   topdelete = {
        --     hl = "GitSignsDelete",
        --     text = icons.ui.TriangleShortArrowRight,
        --     numhl = "GitSignsDeleteNr",
        --     linehl = "GitSignsDeleteLn",
        --   },
        --   changedelete = {
        --     hl = "GitSignsChange",
        --     text = icons.ui.BoldLineLeft,
        --     numhl = "GitSignsChangeNr",
        --     linehl = "GitSignsChangeLn",
        --   },
        -- },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        status_formatter = nil,
        update_debounce = 200,
        max_file_length = 40000,
        preview_config = {
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        -- yadm = { enable = false },

        on_attach = function(bufnr)
          vim.keymap.set('n', '<leader>H', require('gitsigns').preview_hunk,
            { buffer = bufnr, desc = 'Preview git hunk' })

          vim.keymap.set('n', ']]', require('gitsigns').next_hunk,
            { buffer = bufnr, desc = 'Next git hunk' })

          vim.keymap.set('n', '[[', require('gitsigns').prev_hunk,
            { buffer = bufnr, desc = 'Previous git hunk' })
        end,
      }
    end,
    keys = {
      {
        "<leader>gk",
        function()
          require("gitsigns").prev_hunk({ navigation_message = false })
        end,
        desc = "Prev Hunk"
      },
      {
        "<leader>gl", function()
          require("gitsigns").blame_line()
        end,
        desc = "Blame"
      },
      {
        "<leader>gp", function()
          require("gitsigns").preview_hunk()
        end,
        desc = "Preview Hunk"
      },
      {
        "<leader>gr", function()
          require("gitsigns").reset_hunk()
        end,
        desc = "Reset Hunk"
      },
      {
        "<leader>gR", function()
          require("gitsigns").reset_buffer()
        end,
        desc = "Reset Buffer"
      },
      {
        "<leader>gj", function()
          require("gitsigns").next_hunk({ navigation_message = false })
        end,
        desc = "Next Hunk"
      },
      {
        "<leader>gs", function()
          require("gitsigns").stage_hunk()
        end,
        desc = "Stage Hunk"
      },
      {
        "<leader>gu", function()
          require("gitsigns").undo_stage_hunk()
        end,
        desc = "Undo Stage Hunk"
      },
      {
        "<leader>go", require("telescope.builtin").git_status,
        desc = "Open changed file"
      },
      {
        "<leader>gS", require("telescope.builtin").git_stash,
        desc = "Stash"
      },
      {
        "<leader>gP", require("telescope.builtin").git_patches,
        desc = "Patches"
      },
      {
        "<leader>gB", require("telescope.builtin").git_bcommits,
        desc = "Commits(for current file)"
      },
        "<leader>gb", require("telescope.builtin").git_branches,
        desc = "Checkout branch"
      },
      {
        "<leader>gc", require("telescope.builtin").git_commits,
        desc = "Checkout commit"
      },
      {
        "<leader>gC", require("telescope.builtin").git_bcommits,
        desc = "Checkout commit(for current file)"
      },
      {
        "<leader>gd", function()
          vim.cmd("Gitsigns diffthis HEAD")
        end,
        desc = "Git Diff HEAD"
      },
      {
        "<leader>gg", function() vim.cmd("lazygit") end,
        desc = "LazyGit"
      },
      {
        "<leader>gf", function() vim.cmd("Easypick changed_files") end,
        desc = "Show changed files"
      },
    },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  },
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- not git, but it's okay
  {
    "mbbill/undotree",
    keys = {
      {
        "<leader>gU",
        ":UndotreeToggle<CR>",
        desc = "Toggle UndoTree"
      },
    }
  }
}
