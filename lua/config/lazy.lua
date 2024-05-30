local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({import = "plugins"}, {
  install = {
    missing = true,
    colorscheme = { "catppuccin", "habamax" }
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  ui = {
    border = "rounded"
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })

-- vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
-- vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

-- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
-- vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
-- vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
-- vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

-- vim.keymap.set("n", "<Space>ca", function() harpoon:list():append() end)
-- vim.keymap.set("n", "<Space>ce", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
--
-- vim.keymap.set("n", "<Space>ch", function() harpoon:list():select(1) end)
-- vim.keymap.set("n", "<Space>ct", function() harpoon:list():select(2) end)
-- vim.keymap.set("n", "<C-n", function() harpoon:list():select(3) end)
-- vim.keymap.set("n", "<Space>cs", function() harpoon:list():select(4) end)
--
-- -- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "<Space>cP", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<Space>cN", function() harpoon:list():next() end)

-- configure the litee.nvim library 
require('litee.lib').setup({})
-- configure litee-calltree.nvim
require('litee.calltree').setup({})

require('nvim-treesitter.configs').setup {
    endwise = {
        enable = true,
    },
}
