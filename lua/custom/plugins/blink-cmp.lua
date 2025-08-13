return {
  'saghen/blink.cmp',
  version = '1.*',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'L3MON4D3/LuaSnip', -- or mini.snippets if you prefer
    'onsails/lspkind.nvim',
    'nvim-tree/nvim-web-devicons',
    'supermaven-inc/supermaven-nvim',
    opts = {
      keymaps = {
        accept_suggestion = nil,
      },
      disable_inline_completion = true,
    },
  },
  opts = {
    enabled = function()
      return vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false
    end,

    keymap = {
      preset = 'default',
      ['<C-n>'] = { 'snippet_forward', 'select_next', 'fallback' },
      ['<C-p>'] = { 'snippet_backward', 'select_prev', 'fallback' },
      ['<C-y>'] = { 'select_and_accept' },
    },

    appearance = {
      nerd_font_variant = 'mono',
    },

    completion = {
      keyword = { range = 'full' },
      trigger = {
        show_on_keyword = true,
        show_on_trigger_character = true,
        show_on_accept_on_trigger_character = true,
        show_on_insert_on_trigger_character = true,
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
        cycle = {
          from_top = true,
          from_bottom = true,
        },
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
              text = function(ctx)
                return tostring(ctx.idx)
              end,
              highlight = 'BlinkCmpItemIdx',
            },
            kind_icon = {
              text = function(ctx)
                local icon
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
        auto_show_delay_ms = 500,
      },
      ghost_text = {
        enabled = true,
        show_with_selection = true,
        show_without_selection = false,
        show_with_menu = false,
        show_without_menu = true,
      },
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
    },

    fuzzy = {
      implementation = 'prefer_rust_with_warning',
      sorts = {
        'exact',
        'score',
        'sort_text',
      },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      compat = { 'supermaven' },
      windows = {
        autocomplete = {
          selection = 'auto_insert',
        },
      },
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
            local kind = require('blink.cmp.types').CompletionItemKind
            return vim.tbl_filter(function(item)
              return item.kind ~= kind.Keyword -- filter out language keywords
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
      window = {
        border = 'rounded',
        winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
      },
    },

    cmdline = {
      enabled = true,
      keymap = { preset = 'inherit' },
      sources = { 'buffer', 'cmdline' },
      completion = {
        menu = { auto_show = true },
        ghost_text = { enabled = true },
      },
    },
  },
  opts_extend = { 'sources.default' },
}
