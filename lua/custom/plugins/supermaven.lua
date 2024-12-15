-- ~/.config/nvim/lua/custom/plugins/supermaven.lua

return {
  'supermaven-inc/supermaven-nvim',
  config = function()
    require('supermaven-nvim').setup {
      keymaps = {
        -- accept_suggestion = '<C-;>', -- Accept a suggestion
        accept_suggestion = '<Tab>', -- Accept a suggestion
        clear_suggestion = '<C-]>', -- Clear the current suggestion
        accept_word = '<C-j>', -- Accept the next word in the suggestion
      },
      ignore_filetypes = {
        markdown = true,
      },
      color = {
        suggestion_color = '#ffffff', -- Set suggestion text color
        cterm = 244, -- Terminal color for suggestion text
      },
      log_level = 'info', -- Log level: "off", "error", "warn", "info", or "debug"
      disable_inline_completion = false, -- Enable inline completion
      disable_keymaps = false, -- Use built-in keymaps
      condition = function()
        return false -- Always enable Supermaven unless condition returns true
      end,
    }
  end,
}
