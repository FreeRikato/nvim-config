return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  config = function()
    require('noice').setup {
      cmdline = {
        enabled = true,
        view = 'cmdline', -- change to "cmdline_popup" to float it
      },
      views = {
        cmdline_popup = {
          position = {
            row = 1,
            col = '50%',
          },
          size = {
            width = 60,
            height = 'auto',
          },
        },
      },
    }
  end,
}
