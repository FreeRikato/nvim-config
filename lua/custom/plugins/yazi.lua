return {
  'mikavilpas/yazi.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  event = 'VimEnter',
  priority = 1000, -- Ensure it loads early
  -- Keymaps that don't conflict with oil.nvim
  keys = {
    { '<leader>-', '<cmd>Yazi<cr>', desc = 'Open yazi at current file' },
    { '<leader>_', '<cmd>Yazi cwd<cr>', desc = 'Open yazi in working directory' },
    { '<leader>yt', '<cmd>Yazi toggle<cr>', desc = 'Toggle yazi session' },
  },
  opts = {
    -- Floating window configuration
    popup = {
      -- Size and position
      width = 0.85,
      height = 0.8,
      border = 'single',
      position = 'center',

      -- Appearance
      winblend = 0,
      hl = {
        border = 'FloatBorder',
        normal = 'Normal',
      },
    },

    -- Core behavior settings
    open_for_directories = true,
    auto_close = true,
    sync_cwd = true,
    prefer_current_window = false,

    -- Non-conflicting keymaps
    keymaps = {
      show_help = '<F1>',
      open_file_in_vertical_split = '<C-v>',
      open_file_in_horizontal_split = '<C-h>',
      open_file_in_tab = '<C-t>',
      grep_in_directory = '<C-f>',
      replace_in_directory = '<C-r>',
      cycle_open_buffers = '<C-b>',
      copy_relative_path_to_selected_files = '<C-y>',
      send_to_quickfix_list = '<C-q>',
      change_working_directory = '<C-d>',
    },
  },
}
