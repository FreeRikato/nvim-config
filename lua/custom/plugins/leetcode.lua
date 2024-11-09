return {
  'kawre/leetcode.nvim',
  build = ':TSUpdate html',
  dependencies = {
    -- Required dependencies
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim', -- required by telescope
    'MunifTanjim/nui.nvim',

    -- Optional but recommended
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
    'rcarriga/nvim-notify',
  },
  opts = {
    -- Set leetcode.nvim as the first and only argument to start it
    arg = 'leetcode.nvim',

    -- Default coding language
    lang = 'python3',

    -- CN settings (leetcode.cn)
    cn = {
      enabled = false, -- Set to true if you want to use leetcode.cn
      translator = true,
      translate_problems = true,
    },

    -- Directory settings for storage and cache
    storage = {
      home = vim.fn.stdpath 'data' .. '/leetcode',
      cache = vim.fn.stdpath 'cache' .. '/leetcode',
    },

    -- Logging and plugins configuration
    logging = true,
    plugins = {
      non_standalone = false, -- Set to true if you want to run leetcode.nvim within your existing session
    },

    -- Console configuration
    console = {
      open_on_runcode = true, -- Auto-open console when running code
      dir = 'row', -- Console layout direction
      size = { -- Console window size
        width = '90%',
        height = '75%',
      },
      result = {
        size = '60%',
      },
      testcase = {
        virt_text = true,
        size = '40%',
      },
    },

    -- Description window configuration
    description = {
      position = 'left',
      width = '40%',
      show_stats = true,
    },

    -- Image support (requires image.nvim)
    image_support = false,

    -- Code injection configuration
    injector = {
      ['python3'] = {
        before = true, -- Inject default Python imports
      },
      ['cpp'] = {
        before = {
          '#include <bits/stdc++.h>',
          'using namespace std;',
        },
        after = 'int main() {}',
      },
      ['java'] = {
        before = 'import java.util.*;',
      },
    },

    -- Hook functions for various events
    hooks = {
      ['enter'] = {}, -- Functions to run when entering leetcode.nvim
      ['question_enter'] = {}, -- Functions to run when entering a question
      ['leave'] = {}, -- Functions to run when leaving leetcode.nvim
    },

    -- Keybindings configuration
    keys = {
      toggle = { 'q' }, -- Toggle/exit
      confirm = { '<CR>' }, -- Confirm selection
      reset_testcases = 'r', -- Reset testcases
      use_testcase = 'U', -- Use testcase
      focus_testcases = 'H', -- Focus on testcases
      focus_result = 'L', -- Focus on result
    },

    -- Custom theme configuration (optional)
    theme = {
      ['alt'] = {
        bg = '#282828', -- Alternative background color
      },
      ['normal'] = {
        fg = '#d4d4d4', -- Normal text color
      },
    },

    -- Cache update interval
    cache = {
      update_interval = 60 * 60 * 24 * 7, -- Update cache every 7 days
    },
  },

  -- Lazy loading configuration
  lazy = false, -- Set to true if you want to lazy load
  -- Alternative lazy loading based on argument:
  -- lazy = "leetcode.nvim" ~= vim.fn.argv()[1],

  -- Priority (optional)
  priority = 1000,
}
