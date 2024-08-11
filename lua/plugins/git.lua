return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      local icons = require('config.icons')
      require("gitsigns").setup {
        vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'GitSignsAdd' }),
        vim.api.nvim_set_hl(0, 'GitSignsAddLn', { link = 'GitSignsAddLn' }),
        vim.api.nvim_set_hl(0, 'GitSignsAddNr', { link = 'GitSignsAddNr' }),
        vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'GitSignsChange' }),
        vim.api.nvim_set_hl(0, 'GitSignsChangeLn', { link = 'GitSignsChangeLn' }),
        vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { link = 'GitSignsChangeNr' }),
        vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { link = 'GitSignsChange' }),
        vim.api.nvim_set_hl(0, 'GitSignsChangedeleteLn', { link = 'GitSignsChangeLn' }),
        vim.api.nvim_set_hl(0, 'GitSignsChangedeleteNr', { link = 'GitSignsChangeNr' }),
        vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'GitSignsDelete' }),
        vim.api.nvim_set_hl(0, 'GitSignsDeleteLn', { link = 'GitSignsDeleteLn' }),
        vim.api.nvim_set_hl(0, 'GitSignsDeleteNr', { link = 'GitSignsDeleteNr' }),
        vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { link = 'GitSignsDelete' }),
        vim.api.nvim_set_hl(0, 'GitSignsTopdeleteLn', { link = 'GitSignsDeleteLn' }),
        vim.api.nvim_set_hl(0, 'GitSignsTopdeleteNr', { link = 'GitSignsDeleteNr' }),
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

        on_attach = function(bufnr)
          vim.keymap.set('n', '<leader>H', require('gitsigns').preview_hunk,
            { buffer = bufnr, desc = 'Preview git hunk' })
        end,
      }
    end
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
  "mbbill/undotree",
}
