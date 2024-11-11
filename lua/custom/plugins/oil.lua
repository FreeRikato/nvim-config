-- File: lua/custom/plugins/oil.lua

return {
  'stevearc/oil.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- File icons
    'folke/which-key.nvim', -- For keymap documentation
  },
  config = function()
    local oil = require 'oil'

    oil.setup {
      -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
      default_file_explorer = false,

      -- Display options
      columns = {
        'icon', -- File/directory icons
        -- 'permissions', -- File permissions
        'size', -- File size
        -- 'mtime', -- Last modified time
      },

      -- Buffer-local options
      buf_options = {
        buflisted = false, -- Don't list oil buffers
        bufhidden = 'hide', -- Hide buffer when not displayed
      },

      -- Window-local options
      win_options = {
        wrap = true, -- Don't wrap lines
        signcolumn = 'yes', -- Disable sign column
        cursorcolumn = false, -- Disable cursor column
        foldcolumn = '0', -- Disable fold column
        spell = false, -- Disable spell check
        list = false, -- Disable list mode
        conceallevel = 3, -- Maximum concealment
        concealcursor = 'nvic', -- Conceal cursor in all modes
      },

      -- File system options
      delete_to_trash = true, -- Move deleted files to trash
      skip_confirm_for_simple_edits = false, -- Show confirmation dialog
      prompt_save_on_select_new_entry = true, -- Prompt for save when selecting new/moved/renamed file
      cleanup_delay_ms = 2000, -- Cleanup hidden buffers after 2000ms

      -- Keymaps in oil buffer with detailed descriptions
      keymaps = {
        ['g?'] = {
          callback = 'actions.show_help',
          desc = 'Show Oil help menu with all keybindings and actions',
        },
        ['<CR>'] = {
          callback = 'actions.select',
          desc = 'Open the selected file/directory',
        },
        ['<C-s>'] = {
          callback = 'actions.select',
          desc = 'Open file/directory in vertical split',
          opts = { vertical = true },
        },
        ['<C-h>'] = {
          callback = 'actions.select',
          desc = 'Open file/directory in horizontal split',
          opts = { horizontal = true },
        },
        ['<C-t>'] = {
          callback = 'actions.select',
          desc = 'Open file/directory in new tab',
          opts = { tab = true },
        },
        ['<C-p>'] = {
          callback = 'actions.preview',
          desc = 'Preview file content or directory structure',
        },
        ['<C-c>'] = {
          callback = 'actions.close',
          desc = 'Close oil window and return to previous buffer',
        },
        ['<C-l>'] = {
          callback = 'actions.refresh',
          desc = 'Refresh directory listing',
        },
        ['-'] = {
          callback = 'actions.parent',
          desc = 'Navigate to parent directory',
        },
        ['_'] = {
          callback = 'actions.open_cwd',
          desc = 'Open current working directory',
        },
        ['`'] = {
          callback = 'actions.cd',
          desc = "Change Neovim's current directory to selected directory",
        },
        ['~'] = {
          callback = 'actions.cd',
          desc = "Change current tab's directory to selected directory",
          opts = { scope = 'tab' },
        },
        ['gs'] = {
          callback = 'actions.change_sort',
          desc = 'Change sort order of directory listing',
        },
        ['gx'] = {
          callback = 'actions.open_external',
          desc = 'Open file using external program',
        },
        ['g.'] = {
          callback = 'actions.toggle_hidden',
          desc = 'Toggle visibility of hidden files',
        },
        ['g\\'] = {
          callback = 'actions.toggle_trash',
          desc = 'Toggle visibility of trash files',
        },
      },

      -- Use default keymaps as base
      use_default_keymaps = true,

      -- View options
      view_options = {
        show_hidden = false, -- Hide dotfiles by default
        -- Natural order sorting for better human readability
        natural_order = true,
        sort = {
          -- Sort order: "asc" or "desc"
          { 'type', 'asc' }, -- First sort by type
          { 'name', 'asc' }, -- Then by name
        },
      },

      -- Float window options
      float = {
        padding = 2, -- Padding around float window
        max_width = 0, -- Maximum width (0 for auto)
        max_height = 0, -- Maximum height (0 for auto)
        border = 'rounded', -- Border style
        win_options = {
          winblend = 0, -- No transparency
        },
      },

      -- Preview window options
      preview = {
        max_width = 0.9, -- 90% of screen width
        min_width = { 40, 0.4 }, -- Minimum of 40 columns or 40% of screen
        max_height = 0.9, -- 90% of screen height
        min_height = { 5, 0.1 }, -- Minimum of 5 lines or 10% of screen
        border = 'rounded', -- Border style
        win_options = {
          winblend = 0, -- No transparency
        },
        update_on_cursor_moved = true, -- Live preview update
      },

      -- Progress window options
      progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = 'rounded',
        minimized_border = 'none',
        win_options = {
          winblend = 0,
        },
      },
    }
  end,

  -- Load oil plugin on these events
  event = {
    'BufReadPre /home/*', -- Load when reading any home directory
    'BufReadPre /Users/*', -- For macOS users
  },

  -- Add global keymaps
  keys = {
    {
      '-',
      function()
        require('oil').open()
      end,
      desc = 'Open parent directory in oil',
    },
    {
      '<leader>o',
      function()
        require('oil').open()
      end,
      desc = 'Open Oil file explorer',
    },
    {
      '<leader>O',
      function()
        require('oil').open_float()
      end,
      desc = 'Open Oil in float window',
    },
  },

  lazy = false, -- Don't lazy load
}
