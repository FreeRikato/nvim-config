return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    -- Custom Luffy ASCII header
    dashboard.section.header.val = {
      '⠀⠀⠀⠀⠀⠀⠀⢀⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⢀⡞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣶⣶⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⢠⠞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⡰⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⡿⠃⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⣠⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⣀⣴⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⡠⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⣄⣠⣤⣤⣤⣴⠖⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣶⣤⣄⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠓⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣏⡏⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣤⣤⣀⣀⣀⣀⠀',
      '⣄⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣧⣼⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⠁⠀',
      '⣿⣷⣦⠀⠀⠀⠀⠀⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠀⢹⣿⣿⣿⣿⣿⡟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀',
      '⣜⣻⣿⣷⡀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⠈⣿⣿⣿⣿⣿⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀',
      '⣿⣿⣿⣿⣷⡠⣤⠾⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⠀⠸⡇⢹⣿⣿⠀⠀⢹⣿⣿⣿⣿⣿⣿⣿⣿⠿⠆',
      '⣿⣿⣿⣿⣿⣧⠤⢤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠈⠓⠤⣀⠀⠀⠈⠀⢿⣿⠀⠀⠈⡿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀',
      '⣿⣿⣿⣿⣿⣿⡆⣼⣿⣿⡿⢹⠛⡝⣿⣿⡏⣼⠃⠀⠀⠀⠀⠀⠈⠙⠀⠀⠀⠈⠛⠀⠀⠀⠃⢻⣿⣿⣿⣿⣿⣿⡀⠀',
      '⣿⣿⣿⣿⣿⣿⡿⠟⢻⣿⡇⠈⣉⣻⠾⡿⠀⠃⠀⣤⡶⠾⠿⣶⣄⠀⠀⠀⠀⠀⢀⠄⠲⠞⠉⢹⡟⢹⣿⣿⣿⡟⠿⠧⠀',
      '⣿⣻⣿⣿⣿⣿⣿⡀⠺⣿⣿⡄⢧⣼⢀⡇⠀⠀⠀⠉⠁⠀⠀⠀⠉⠀⠀⠀⠀⠀⡏⠀⣀⣀⣀⠈⠀⢸⣿⣿⣿⡇⠀⠀⠀',
      '⣵⣿⣿⣿⣿⣿⡿⣿⣆⣿⠿⣿⣮⡙⢿⡃⠀⢠⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡷⠀⠉⠉⠹⠇⠀⣾⣿⠛⢿⣷⠀⠀⠀',
      '⣿⣿⣿⣿⣿⣿⡇⢻⣿⣆⢀⡿⠋⠙⢺⡇⠀⠀⣿⠉⠛⠓⠒⠤⠤⣀⣀⡀⠀⠊⠀⠉⠛⠓⠒⠒⣼⣿⠇⠀⠀⠈⠃⠀⠀',
      '⣿⣿⣿⣿⣿⣿⣇⣿⣿⣿⡉⠀⠀⠀⠈⣿⡄⠀⠹⣦⣼⠤⠤⠄⣀⣀⠀⠈⠉⠉⠙⠲⢶⠆⠀⣼⠗⠁⠀⠀⠀⠀⠀⠀⠀',
      '⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⣿⣻⣦⡀⠙⠣⣄⠀⠀⠀⠀⠉⠙⠒⢶⣼⣴⣯⣤⣼⣍⣀⣀⣀⣀⠀⠀⠀⠀⠀',
      '⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠸⣿⣿⣿⣦⣀⠈⠓⠦⣄⣀⡀⠀⢀⣠⠿⠃⣠⠞⠁⠀⠀⠀⠉⠉⠀⠀⠀⠀⠀',
      '⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠸⣿⣿⣿⣿⣿⣷⣦⣄⡀⠀⠉⣉⣡⠤⠖⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⣿⣿⣿⣿⣿⣿⣿⣿⡟⣿⣿⣿⣧⡀⠀⠈⢿⣿⣿⣿⡟⠉⠀⠀⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⣿⣿⣿⣿⣿⣿⣿⣿⣹⣿⣿⣿⡿⢿⣄⠀⠈⢻⣾⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⣿⣿⣿⣿⣿⣿⡟⢻⠛⣿⣿⣿⣿⡀⠻⣷⣴⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
    }

    -- Menu configuration
    dashboard.section.buttons.val = {
      dashboard.button('f', '  Find file', ':Telescope find_files<CR>'),
      dashboard.button('e', '  New file', ':ene <BAR> startinsert<CR>'),
      dashboard.button('r', '  Recent files', ':Telescope oldfiles<CR>'),
      dashboard.button('t', '  Find text', ':Telescope live_grep<CR>'),
      dashboard.button('c', '  Configuration', ':e $MYVIMRC<CR>'),
      dashboard.button('q', '  Quit', ':qa<CR>'),
    }

    -- Footer
    local function footer()
      local stats = require('lazy').stats()
      return '⚡ ' .. stats.count .. ' plugins loaded in ' .. string.format('%.2f', stats.startuptime) .. 'ms'
    end

    dashboard.section.footer.val = footer()

    -- Layout
    dashboard.config.layout = {
      { type = 'padding', val = 1 },
      dashboard.section.header,
      { type = 'padding', val = 2 },
      dashboard.section.buttons,
      { type = 'padding', val = 1 },
      dashboard.section.footer,
    }

    -- Highlight groups
    dashboard.section.header.opts.hl = 'AlphaHeader'
    dashboard.section.buttons.opts.hl = 'AlphaButtons'
    dashboard.section.footer.opts.hl = 'AlphaFooter'

    alpha.setup(dashboard.config)

    -- Auto-open alpha when no other buffers are present
    vim.api.nvim_create_autocmd('User', {
      pattern = 'BDeletePost*',
      callback = function(event)
        local fallback_name = vim.api.nvim_buf_get_name(event.buf)
        local fallback_ft = vim.api.nvim_buf_get_option(event.buf, 'filetype')
        local fallback_on_empty = fallback_name == '' and fallback_ft == ''

        if fallback_on_empty then
          vim.cmd 'Alpha'
        end
      end,
    })
  end,
}
