return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'ahmedkhalf/project.nvim', -- Add project.nvim as a dependency
    'nvim-telescope/telescope.nvim', -- Ensure Telescope is included if not already
  },
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    -- Custom Luffy ASCII header (unchanged)
    dashboard.section.header.val = {
      '⠀⠀⠀⠀⠀⠀⠀⢀⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⢀⡞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣶⣶⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⢠⠞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⡰⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⡿⠃⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⣠⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⣀⣴⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⡠⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⣄⣤⣤⣤⣤⣴⠖⠀⠀⠀⠀⠀⠀',
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

    -- Configure project.nvim
    require('project_nvim').setup {
      detection_methods = { 'pattern', 'lsp' }, -- Detect projects by patterns or LSP
      patterns = { '.git' }, -- Common project markers
      silent_chdir = true, -- Change directory silently when switching projects
    }

    -- Load Telescope projects extension
    require('telescope').load_extension 'projects'

    -- Menu configuration with recent projects added
    dashboard.section.buttons.val = {
      dashboard.button('f', '  Find file', ':Telescope find_files<CR>'),
      dashboard.button('e', '  New file', ':ene <BAR> startinsert<CR>'),
      dashboard.button('r', '  Recent files', ':Telescope oldfiles<CR>'),
      dashboard.button('p', '  Recent projects', ':Telescope projects<CR>'), -- New button for projects
      dashboard.button('t', '  Find text', ':Telescope live_grep<CR>'),
      dashboard.button('c', '  Configuration', ':e $MYVIMRC<CR>'),
      dashboard.button('q', '  Quit', ':qa<CR>'),
    }

    -- Footer (unchanged)
    local function footer()
      local stats = require('lazy').stats()
      return '⚡ ' .. stats.count .. ' plugins loaded in ' .. string.format('%.2f', stats.startuptime) .. 'ms'
    end

    dashboard.section.footer.val = footer()

    -- Layout (unchanged)
    dashboard.config.layout = {
      { type = 'padding', val = 1 },
      dashboard.section.header,
      { type = 'padding', val = 2 },
      dashboard.section.buttons,
      { type = 'padding', val = 1 },
      dashboard.section.footer,
    }

    -- Highlight groups (unchanged)
    dashboard.section.header.opts.hl = 'AlphaHeader'
    dashboard.section.buttons.opts.hl = 'AlphaButtons'
    dashboard.section.footer.opts.hl = 'AlphaFooter'

    alpha.setup(dashboard.config)

    -- Auto-open alpha when no other buffers are present (unchanged)
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
