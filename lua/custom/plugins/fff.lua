return {
  'dmtrKovalenko/fff.nvim',
  -- This is required to download or build the native Rust binary
  build = function()
    -- This will download prebuild binary or try to use existing rustup toolchain to build from source
    require('fff.download').download_or_build_binary()
  end,
  -- Clean configuration without debug features
  opts = {
    -- Use standard layout proportions
    layout = {
      height = 0.8,
      width = 0.8,
    },
    -- Use keymaps that are standard for pickers (Up/Down, C-p/C-n)
    keymaps = {
      move_up = { '<Up>', '<C-p>' },
      move_down = { '<Down>', '<C-n>' },
    },
  },
  -- No need to set lazy = false, as the plugin initializes itself lazily.
  -- Add a keybinding to open the file finder
  keys = {
    {
      'ff', -- The suggested keybinding from the documentation
      function()
        require('fff').find_files()
      end,
      desc = 'FFFind files',
    },
  },
}
