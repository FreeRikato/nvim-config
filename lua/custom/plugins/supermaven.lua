-- supermaven.lua

return {
  'supermaven-inc/supermaven-nvim',
  config = function()
    require('supermaven-nvim').setup {
      keymaps = {
        accept_suggestion = '<Tab>', -- Accept the suggestion
        clear_suggestion = '<C-]>', -- Clear the suggestion
        accept_word = '<C-j>', -- Accept the suggestion up to the end of the next word
      },
      ignore_filetypes = {
        cpp = true, -- Ignore suggestions for C++ files
        -- Add other filetypes you want to ignore here
      },
      color = {
        suggestion_color = '#ffffff', -- Set the suggestion color
        cterm = 244, -- Set the cterm color
      },
      log_level = 'info', -- Set the log level to "info"
      disable_inline_completion = false, -- Enable inline completion
      disable_keymaps = false, -- Enable built-in keymaps
      condition = function() end,
    }

    -- Optional: Highlight for Supermaven in nvim-cmp
    vim.api.nvim_set_hl(0, 'CmpItemKindSupermaven', { fg = '#6CC644' })
  end,
}
