-- lua/custom/plugins/harpoon.lua

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim', -- Optional: If you want Telescope integration
  },
  config = function()
    local harpoon = require 'harpoon'

    -- REQUIRED: Basic harpoon setup
    harpoon:setup {
      settings = {
        save_on_toggle = true, -- Save all changes when UI is toggled
        sync_on_ui_close = true, -- Save all changes when UI is closed
        key = function() -- How the harpoon list key is looked up
          return vim.loop.cwd() -- Use current working directory
        end,
      },
    }

    -- Telescope configuration for Harpoon (Optional)
    local function toggle_telescope(harpoon_files)
      local conf = require('telescope.config').values
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    -- Add current file to Harpoon list
    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Add file to harpoon' })

    -- Toggle Harpoon quick menu
    vim.keymap.set('n', '<leader>H', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    -- Toggle Telescope menu (Optional)
    vim.keymap.set('n', '<leader>he', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Open harpoon window in Telescope' })

    -- Quick navigation to files in Harpoon list
    vim.keymap.set('n', '<C-h>', function()
      harpoon:list():select(1)
    end)
    vim.keymap.set('n', '<C-j>', function()
      harpoon:list():select(2)
    end)
    vim.keymap.set('n', '<C-k>', function()
      harpoon:list():select(3)
    end)
    vim.keymap.set('n', '<C-l>', function()
      harpoon:list():select(4)
    end)

    -- Navigate through Harpoon list sequentially
    vim.keymap.set('n', '<C-M-P>', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<C-M-N>', function()
      harpoon:list():next()
    end)
  end,
}
