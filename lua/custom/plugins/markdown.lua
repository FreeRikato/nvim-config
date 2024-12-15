-- ~/.config/nvim/lua/custom/plugins/markdown.lua

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

          -- Function to safely delete a keymap
          local function safe_del_keymap(mode, key)
            local status, err = pcall(vim.api.nvim_buf_del_keymap, 0, mode, key)
            if not status then
              -- Optionally log the error for debugging
              -- print(string.format("Keymap deletion failed for %s in mode %s: %s", key, mode, err))
            end
          end

          -- Safely delete any existing mappings for <C-i>
          safe_del_keymap('i', '<C-i>')
          safe_del_keymap('n', '<C-i>')

          -- Ensure <Tab> behaves as default (inserts a tab character)
          vim.keymap.set('i', '<Tab>', '<Tab>', { desc = 'Insert Tab', buffer = true })
          vim.keymap.set('i', '<S-Tab>', '<C-d>', { desc = 'Shift-Tab (Unindent)', buffer = true })

          -- Text formatting
          vim.keymap.set('i', '<C-b>', '****<Left><Left>', { desc = 'Bold text', buffer = true })
          -- Removed the conflicting <C-i> mapping
          -- Added a new mapping for Italic text using <leader>i in Normal Mode
          vim.keymap.set('n', '<leader>i', function()
            -- Insert '__' and move cursor between them in Insert Mode
            vim.api.nvim_put({ '__' }, 'c', true, true)
            vim.api.nvim_feedkeys('<Left>', 'n', true)
            vim.cmd 'startinsert'
          end, { desc = 'Insert Italic Markdown', buffer = true })

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
          local opt_local = vim.opt_local
          opt_local.spell = true
          opt_local.spelllang = 'en_us'
          opt_local.wrap = true
          opt_local.linebreak = true
          opt_local.conceallevel = 2
          opt_local.foldenable = true
          opt_local.foldmethod = 'expr'
          opt_local.foldexpr = 'nvim_treesitter#foldexpr()'
          opt_local.textwidth = 80

          -- Ensure all folds are open by default for Markdown files
          opt_local.foldlevelstart = 99

          opt_local.formatoptions:append {
            t = true, -- Auto-wrap text using textwidth
            n = true,
            j = true,
          }

          opt_local.formatoptions:remove { 'o' }
        end,
      })

      -- Markdown preview settings (if any additional configurations are needed, add them here)
    end,
  },
}
