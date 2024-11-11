return {
  'mikavilpas/yazi.nvim',
  -- Change from VeryLazy to ensure it loads earlier
  event = 'VimEnter',
  keys = {
    {
      '<leader>-',
      '<cmd>Yazi<cr>',
      desc = 'Open yazi at the current file',
    },
    {
      '<leader>cw',
      '<cmd>Yazi cwd<cr>',
      desc = "Open the file manager in nvim's working directory",
    },
    {
      '<c-up>',
      '<cmd>Yazi toggle<cr>',
      desc = 'Resume the last yazi session',
    },
  },
  opts = {
    open_for_directories = true,
    floating_window_scaling_factor = 0.9,
    keymaps = {
      show_help = '<f1>',
    },
  },
  -- Add init function to disable netrw immediately
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
}
