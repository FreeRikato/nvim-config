return {
  'stevearc/oil.nvim',
  dependencies = {
    'echasnovski/mini.icons',
    opts = {},
  },
  config = function()
    require('oil').setup {
      -- File Explorer Settings
      default_file_explorer = false,
      columns = {
        'icon',
      },
      view_options = {
        show_hidden = true,
        natural_order = 'fast',
      },
      -- Keymaps with Descriptions
      keymaps = {
        -- Normal Mode Keymaps
        ['g?'] = {
          desc = 'Show Help',
          'actions.show_help',
        },
        ['<CR>'] = {
          desc = 'Open File/Directory',
          'actions.select',
        },
        ['-'] = {
          desc = 'Navigate Up Directory',
          'actions.parent',
        },
        ['<Esc>'] = {
          desc = 'Close Oil Buffer',
          callback = 'actions.close',
          mode = 'n',
        },
        -- Visual Mode Keymaps
        ['mv'] = {
          desc = 'Multi-Select Files',
          mode = 'v',
          'actions.select_vsplit',
        },
      },
      -- Window and Buffer Options
      buf_options = {
        buflisted = false,
        bufhidden = 'hide',
      },
      win_options = {
        wrap = false,
        signcolumn = 'yes:2', -- Changed from 'no' to 'yes:2' for git status
        cursorcolumn = false,
      },
      -- Advanced Configuration
      constrain_cursor = 'editable',
      watch_for_changes = true,
      -- Floating Window Configuration
      float = {
        padding = 2,
        border = 'rounded',
        max_width = 80,
        max_height = 20,
      },
    }
  end,
  -- Lazy Loading and Keybindings
  keys = {
    {
      '-',
      ':Oil<cr>',
      desc = 'Open parent directory',
    },
    {
      '<leader>e',
      ':Oil --float<cr>',
      desc = 'Open Oil in Floating Window',
    },
  },
}
