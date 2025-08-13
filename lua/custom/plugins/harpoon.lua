return {
  -- Plugin specification
  'ThePrimeagen/harpoon',
  branch = 'harpoon2', -- Specifically use Harpoon 2
  dependencies = {
    'nvim-lua/plenary.nvim', -- Required dependency for Harpoon
  },
  config = function()
    -- Initialize harpoon
    local harpoon = require 'harpoon'

    -- REQUIRED SETUP
    harpoon:setup {
      -- Configure the menu width to be dynamic based on window size
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4, -- Window width minus 4 for padding
      },
      settings = {
        save_on_toggle = true, -- Automatically save marks when toggling the menu
      },
    }

    -------------------
    -- BASIC MAPPINGS
    -------------------

    -- Add current file to harpoon marks
    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Add file to Harpoon' })

    -- Toggle the harpoon quick menu with enhanced UI
    vim.keymap.set('n', '<leader>H', function()
      harpoon.ui:toggle_quick_menu(harpoon:list(), {
        border = 'rounded', -- Add rounded borders to the menu
        title = 'Harpoon', -- Add a title to the menu
        title_pos = 'center', -- Center the title
      })
    end, { desc = 'Show Harpoon menu' })

    ------------------------
    -- NUMERICAL NAVIGATION
    ------------------------

    -- Create mappings for the first 5 marks (leader + number)
    -- This allows quick jumping to marks using <leader>1 through <leader>5
    for i = 1, 5 do
      vim.keymap.set('n', '<leader>' .. i, function()
        harpoon:list():select(i)
      end, { desc = '󱡅 Harpoon buffer ' .. i })
    end

    ------------------------
    -- SEQUENTIAL NAVIGATION
    ------------------------

    -- Navigate through marks sequentially with wrap-around
    -- When you reach the end, it wraps to the beginning and vice versa
    vim.keymap.set('n', '<C-p>', function()
      harpoon:list():prev { ui_nav_wrap = true }
    end, { desc = 'Harpoon: Prev buffer' })

    vim.keymap.set('n', '<C-n>', function()
      harpoon:list():next { ui_nav_wrap = true }
    end, { desc = 'Harpoon: Next buffer' })

    ------------------------
    -- CHORD STYLE NAVIGATION
    ------------------------

    -- Alternative navigation using double key combinations
    -- Press Ctrl-h followed by another key to jump to specific marks
    vim.keymap.set('n', '<S-h>', function()
      harpoon:list():select(1)
    end, { desc = 'Harpoon: Chord to buffer 1' })

    vim.keymap.set('n', '<S-j>', function()
      harpoon:list():select(2)
    end, { desc = 'Harpoon: Chord to buffer 2' })

    vim.keymap.set('n', '<S-k>', function()
      harpoon:list():select(3)
    end, { desc = 'Harpoon: Chord to buffer 3' })
    vim.keymap.set('n', '<S-l>', function()
      harpoon:list():select(4)
    end, { desc = 'Harpoon: Chord to buffer 4' })

    ------------------------
    -- ADDITIONAL FUNCTIONALITY
    ------------------------

    -- Remove current file from harpoon list
    vim.keymap.set('n', '<leader>hr', function()
      harpoon:list():remove()
    end, { desc = 'Remove file from Harpoon' })

    -- Clear all marks
    vim.keymap.set('n', '<leader>hc', function()
      harpoon:list():clear()
    end, { desc = 'Clear all Harpoon marks' })

    -- Show harpoon marks in Telescope
    vim.keymap.set('n', '<leader>hf', function()
      require('telescope').extensions.harpoon.marks()
    end, { desc = 'Show Harpoon marks in Telescope' })
  end,
}
