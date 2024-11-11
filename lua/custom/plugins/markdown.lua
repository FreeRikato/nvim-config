-- File: lua/custom/plugins/markdown.lua

return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- Required for markdown parsing
    'echasnovski/mini.nvim', -- For icons in code blocks
    '3rd/image.nvim', -- For image support
    {
      'ellisonleao/glow.nvim', -- For markdown preview
      config = true,
      cmd = 'Glow',
    },
  },
  config = function()
    -- Configure image.nvim first
    require('image').setup {
      backend = 'kitty', -- Use kitty for image rendering
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = true,
          filetypes = { 'markdown', 'vimwiki' }, -- Enable for these filetypes
        },
      },
      max_width = 100, -- Maximum image width
      max_height = 12, -- Maximum image height in lines
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      window_overlap_clear_enabled = false, -- Keep images visible when windows overlap
      window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
    }

    require('render-markdown').setup {
      -- Enable markdown rendering by default
      enabled = true,

      -- Maximum file size to render (in MB)
      max_file_size = 10.0,

      -- File types this plugin will run on
      file_types = { 'markdown', 'vimwiki' },

      -- Enable image support
      image_support = true, -- Enable image rendering features

      -- Configure headings
      heading = {
        enabled = true, -- Enable heading rendering
        sign = true, -- Show signs in sign column
        position = 'overlay', -- 'inline' or 'overlay' for heading icons
        icons = { -- Icons for different heading levels
          '󰲡 ', -- Level 1
          '󰲣 ', -- Level 2
          '󰲥 ', -- Level 3
          '󰲧 ', -- Level 4
          '󰲩 ', -- Level 5
          '󰲫 ', -- Level 6
        },
        width = 'full', -- 'full' for full width, 'block' for text width
        border = true, -- Show borders around headings
        border_virtual = true, -- Use virtual lines for borders
      },

      -- Configure code blocks
      code = {
        enabled = true, -- Enable code block rendering
        sign = true, -- Show language icons in sign column
        style = 'full', -- 'full' includes language name and icon
        position = 'left', -- Position of language indicator
        language_name = true, -- Show language name next to icon
        width = 'full', -- Width of code block background
        border = 'thin', -- Border style ('thin' or 'thick')
      },

      -- Configure lists and checkboxes
      bullet = {
        enabled = true,
        icons = { '●', '○', '◆', '◇' }, -- Icons for different nesting levels
        highlight = 'RenderMarkdownBullet',
      },

      checkbox = {
        enabled = true,
        position = 'inline',
        unchecked = {
          icon = '󰄱 ',
          highlight = 'RenderMarkdownUnchecked',
        },
        checked = {
          icon = '󰱒 ',
          highlight = 'RenderMarkdownChecked',
        },
        -- Custom checkbox states
        custom = {
          todo = {
            raw = '[-]',
            rendered = '󰥔 ',
            highlight = 'RenderMarkdownTodo',
          },
        },
      },

      -- Configure tables
      pipe_table = {
        enabled = true,
        style = 'full', -- Full table borders
        cell = 'padded', -- Padded cells for better readability
        padding = 1, -- Space between cell content and borders
        border = { -- Table border characters
          '┌',
          '┬',
          '┐', -- Top borders
          '├',
          '┼',
          '┤', -- Middle borders
          '└',
          '┴',
          '┘', -- Bottom borders
          '│',
          '─', -- Vertical and horizontal lines
        },
      },

      -- Configure callouts (admonitions)
      callout = {
        -- Default callouts
        note = { raw = '[!NOTE]', rendered = '󰋽 Note', highlight = 'RenderMarkdownInfo' },
        tip = { raw = '[!TIP]', rendered = '󰌶 Tip', highlight = 'RenderMarkdownSuccess' },
        warning = { raw = '[!WARNING]', rendered = '󰀪 Warning', highlight = 'RenderMarkdownWarn' },
        important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important', highlight = 'RenderMarkdownHint' },
        caution = { raw = '[!CAUTION]', rendered = '󰳦 Caution', highlight = 'RenderMarkdownError' },
      },

      -- Enhanced link configuration with image support
      link = {
        enabled = true,
        image = '󰥶 ', -- Icon for image links
        email = '󰀓 ', -- Icon for email links
        hyperlink = '󰌹 ', -- Icon for general hyperlinks
        wiki = {
          icon = '󱗖 ',
          highlight = 'RenderMarkdownWikiLink',
        },
        -- Custom patterns for special link handling
        custom = {
          -- Handle image files
          image = {
            pattern = '%.png$|%.jpg$|%.jpeg$|%.gif$|%.webp$',
            icon = '󰋩 ',
            highlight = 'RenderMarkdownImage',
          },
          -- Handle PDF files
          pdf = {
            pattern = '%.pdf$',
            icon = '󰈦 ',
            highlight = 'RenderMarkdownPDF',
          },
        },
      },

      -- LaTeX support configuration
      latex = {
        enabled = true, -- Enable LaTeX rendering
        converter = 'latex2text', -- LaTeX to Unicode converter
        highlight = 'RenderMarkdownMath',
      },

      -- Anti-conceal settings
      anti_conceal = {
        enabled = true, -- Hide added text on cursor line
        above = 1, -- Lines above cursor to show
        below = 1, -- Lines below cursor to show
      },

      -- Window options
      win_options = {
        -- Conceal settings
        conceallevel = {
          default = vim.o.conceallevel,
          rendered = 3,
        },
        concealcursor = {
          default = vim.o.concealcursor,
          rendered = '',
        },
      },
    }

    -- Register markdown parser for vimwiki if needed
    vim.treesitter.language.register('markdown', 'vimwiki')

    -- Set up additional keymaps for image handling
    local function setup_markdown_keymaps()
      -- Only set these keymaps for markdown files
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'markdown', 'vimwiki' },
        callback = function()
          local opts = { buffer = true, silent = true }

          -- Toggle image display
          vim.keymap.set('n', '<leader>mi', function()
            vim.cmd 'ImageToggle'
          end, vim.tbl_extend('force', opts, { desc = 'Toggle image display' }))

          -- Resize image
          vim.keymap.set('n', '<leader>mr', function()
            vim.cmd 'ImageResize'
          end, vim.tbl_extend('force', opts, { desc = 'Resize image' }))

          -- Center image
          vim.keymap.set('n', '<leader>mc', function()
            vim.cmd 'ImageCenter'
          end, vim.tbl_extend('force', opts, { desc = 'Center image' }))

          -- Preview markdown
          vim.keymap.set('n', '<leader>mp', ':Glow<CR>', vim.tbl_extend('force', opts, { desc = 'Preview markdown' }))
        end,
      })
    end

    setup_markdown_keymaps()
  end,

  -- Load on markdown file types
  ft = {
    'markdown',
    'vimwiki',
  },

  -- Commands for quick access
  cmd = {
    'RenderMarkdown',
    'RenderMarkdownToggle',
    'Glow',
  },

  -- Add keymaps for common operations
  keys = {
    { '<leader>mm', '<cmd>RenderMarkdown<CR>', desc = 'Toggle Markdown Rendering' },
    { '<leader>mt', '<cmd>RenderMarkdownToggle<CR>', desc = 'Toggle Markdown View' },
  },
}
