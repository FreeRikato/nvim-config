return {
  'supermaven-inc/supermaven-nvim',
  config = function()
    require('supermaven-nvim').setup {
      keymaps = {
        accept_suggestion = '<Tab>',
        clear_suggestion = '<C-]>',
        accept_word = '<C-j>',
      },
      color = {
        suggestion_color = '#88ccff', -- A subtle blue/cyan hint
        cterm = 244,
      },
      -- Ensure inline completion is enabled so you see the ghost text
      disable_inline_completion = false,
      -- specific filetypes to ignore if needed
      ignore_filetypes = { cpp = true },
    }
  end,
}
