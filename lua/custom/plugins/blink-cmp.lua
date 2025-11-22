return {
  'saghen/blink.cmp',
  version = '1.*',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'L3MON4D3/LuaSnip',
    'onsails/lspkind.nvim',
    'nvim-tree/nvim-web-devicons',
    -- REMOVED: 'supermaven-inc/supermaven-nvim'
    -- We don't want to depend on it here; we want them running side-by-side.
  },
  opts = {
    enabled = function()
      return vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false
    end,

    keymap = {
      preset = 'default',

      -- Navigation
      ['<C-n>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback' },

      -- Selection
      ['<C-y>'] = { 'select_and_accept' },

      -- KEY OPTIMIZATION FOR SUPERMAVEN:
      -- We map Tab ONLY to snippet jumping.
      -- If we are not in a snippet, we 'fallback'.
      -- This passes the keystroke to Neovim, allowing Supermaven to catch it.
      ['<Tab>'] = { 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    },

    appearance = {
      nerd_font_variant = 'mono',
    },

    completion = {
      -- Disable Blink's ghost text completely.
      -- Supermaven will provide the ghost text.
      ghost_text = { enabled = false },

      keyword = { range = 'full' },

      list = {
        selection = {
          preselect = false,
          auto_insert = true
        }
      },

      menu = {
        auto_show = true,
        draw = {
          columns = {
            { 'item_idx' },
            { 'kind_icon', 'kind' },
            { 'label', 'label_description', gap = 1 },
          },
          components = {
            item_idx = {
              text = function(ctx) return tostring(ctx.idx) end,
              highlight = 'BlinkCmpItemIdx',
            },
            kind_icon = {
              text = function(ctx)
                local icon = ctx.kind_icon
                if ctx.source_name == 'Path' then
                  icon = require('nvim-web-devicons').get_icon(ctx.label) or ctx.kind_icon
                else
                  icon = require('lspkind').symbolic(ctx.kind, { mode = 'symbol' })
                end
                return icon .. ' '
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500, -- Wait 500ms so it doesn't cover Supermaven
        treesitter_highlighting = true,
        window = { border = 'rounded' },
      },
    },

    -- Command Line Configuration (The Fix)
    cmdline = {
      enabled = true,
      keymap = {
        preset = 'inherit', -- Inherits your C-n/C-p mappings defined above
      },
      sources = function()
        local type = vim.fn.getcmdtype()
        -- Search mode (/)
        if type == '/' or type == '?' then return { 'buffer' } end
        -- Command mode (:)
        if type == ':' then return { 'cmdline', 'path' } end
        return {}
      end,
      completion = {
        menu = { auto_show = true },
        ghost_text = { enabled = false },
      },
    },

    fuzzy = { implementation = 'prefer_rust_with_warning' },

    -- Sources
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        buffer = {
          opts = {
            get_bufnrs = function()
              return vim.tbl_filter(function(bufnr)
                return vim.bo[bufnr].buftype == ''
              end, vim.api.nvim_list_bufs())
            end,
          },
        },
        lsp = {
          transform_items = function(_, items)
            local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
            return vim.tbl_filter(function(item)
              -- Keep the menu clean, remove Keywords and Text
              return item.kind ~= CompletionItemKind.Keyword
                 and item.kind ~= CompletionItemKind.Text
            end, items)
          end,
        },
      },
    },

    snippets = {
      preset = 'luasnip',
    },

    signature = {
      enabled = true,
      window = { border = 'rounded' },
    },
  },
  opts_extend = { 'sources.default' },
}
