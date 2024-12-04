return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.nvim',
      '3rd/image.nvim',
      'iamcco/markdown-preview.nvim',
      'tadmccorkle/markdown.nvim',
      'lukas-reineke/headlines.nvim',
    },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    config = function()
      -- Image rendering setup
      require('image').setup {
        backend = 'kitty', -- Updated for WezTerm
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { 'markdown', 'vimwiki' },
          },
        },
        kitty_method = 'normal', -- Corrected field for WezTerm
        max_width_window_percentage = 50,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = true,
      }

      -- Headlines setup for better heading appearance
      require('headlines').setup {
        markdown = {
          headline_highlights = {
            'Headline1',
            'Headline2',
            'Headline3',
            'Headline4',
            'Headline5',
            'Headline6',
          },
          codeblock_highlight = 'CodeBlock',
          dash_highlight = 'Dash',
          quote_highlight = 'Quote',
        },
      }

      -- Markdown specific settings and keymaps
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'markdown',
        callback = function()
          local opts = { noremap = true, silent = true, buffer = true }

          -- Text formatting
          vim.keymap.set('i', '<C-b>', '****<Left><Left>', { desc = 'Bold text', buffer = true })
          vim.keymap.set('i', '<C-i>', '__<Left>', { desc = 'Italic text', buffer = true })
          vim.keymap.set('i', '<C-k>', '``<Left>', { desc = 'Inline code', buffer = true })
          vim.keymap.set('i', '<C-l>', '[]()<Left><Left><Left>', { desc = 'Create link', buffer = true })

          -- Headings
          vim.keymap.set('n', '<leader>h1', 'I# <Esc>', { desc = 'Heading 1', buffer = true })
          vim.keymap.set('n', '<leader>h2', 'I## <Esc>', { desc = 'Heading 2', buffer = true })
          vim.keymap.set('n', '<leader>h3', 'I### <Esc>', { desc = 'Heading 3', buffer = true })

          -- Task management
          vim.keymap.set('n', '<leader>tc', 'i- [ ] ', { desc = 'Create task', buffer = true })
          vim.keymap.set('n', '<leader>tx', function()
            local line = vim.api.nvim_get_current_line()
            local new_line = line:gsub('%[(%s?)%]', function(c)
              return c == ' ' and '[x]' or '[ ]'
            end)
            vim.api.nvim_set_current_line(new_line)
          end, { desc = 'Toggle task', buffer = true })

          -- Image handling
          vim.keymap.set('n', '<leader>ip', ':lua require("image").from_clipboard()<CR>', { desc = 'Paste image', buffer = true })
          vim.keymap.set('n', '<leader>ic', ':lua require("image").clear()<CR>', { desc = 'Clear images', buffer = true })

          -- Preview controls
          vim.keymap.set('n', '<leader>mp', ':MarkdownPreview<CR>', { desc = 'Start preview', buffer = true })
          vim.keymap.set('n', '<leader>ms', ':MarkdownPreviewStop<CR>', { desc = 'Stop preview', buffer = true })

          -- Folding
          vim.keymap.set('n', '<leader>zf', 'zM', { desc = 'Fold all', buffer = true })
          vim.keymap.set('n', '<leader>zo', 'zR', { desc = 'Open all folds', buffer = true })

          -- Local settings
          local opt = vim.opt_local
          opt.spell = true
          opt.spelllang = 'en_us'
          opt.wrap = true
          opt.linebreak = true
          opt.conceallevel = 2
          opt.foldenable = true
          opt.foldmethod = 'expr'
          opt.foldexpr = 'nvim_treesitter#foldexpr()'
          opt.textwidth = 80
          opt.formatoptions = opt.formatoptions
            + 't' -- Auto-wrap text using textwidth
            + 'n' -- Recognize numbered lists
            + 'j' -- Remove comment leader when joining lines
            - 'o' -- Don't continue comments with o/O

          -- Enable treesitter syntax highlighting
          vim.treesitter.start()
        end,
      })

      -- Markdown preview settings
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_refresh_slow = 1
      vim.g.mkdp_browser = 'google-chrome' -- Updated for Google Chrome
      vim.g.mkdp_preview_options = {
        disable_sync_scroll = 0,
        disable_filename = 1,
      }
    end,
  },
}
