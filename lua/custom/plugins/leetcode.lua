-- lua/plugins/leetcode.lua
return {
  'kawre/leetcode.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim', -- for problem selection
    'nvim-lua/plenary.nvim', -- required dependency
    'MunifTanjim/nui.nvim', -- UI components
  },
  build = ':TSUpdate html', -- update treesitter for problem description
  opts = {
    -- Default programming language for problems
    lang = 'python3', -- available: cpp, python3, java, javascript, ruby, swift, golang

    -- Leetcode.cn (China) configuration
    cn = {
      enabled = false, -- enable leetcode.cn
      translator = false, -- enable translator
      translate_problems = false, -- translate problem description
    },

    -- Storage configuration for caching and session management
    storage = {
      -- Directory to store problem cache and session data
      home = vim.fn.stdpath 'data' .. '/leetcode',
      cache = vim.fn.stdpath 'cache' .. '/leetcode',
    },

    -- Plugin behavior configuration
    plugins = {
      non_standalone = true, -- allows using within existing session
    },

    -- Enable debug logging
    logging = true,

    -- Console configuration for running and testing code
    console = {
      open_on_runcode = true, -- auto-open console on code execution
      dir = 'row', -- console split direction ("row" or "col")
      size = {
        width = '90%', -- console window width
        height = '75%', -- console window height
      },
      result = {
        size = '60%', -- result window size ratio
      },
    },

    -- Problem description display settings
    description = {
      position = 'left', -- description window position
      width = '40%', -- description window width
      show_stats = true, -- show problem statistics
    },

    image_support = false, -- disable image support for lighter load
  },

  -- Lazy load on specific commands
  cmd = {
    'LeetCode',
    'LeetCodeTest',
    'LeetCodeSubmit',
    'LeetCodeList',
  },

  keys = {
    -- Menu navigation
    { '<leader>lm', '<cmd>LeetCode<cr>', desc = 'LeetCode Menu' },
    { '<leader>ll', '<cmd>LeetCodeList<cr>', desc = 'Problem List' },

    -- Problem interaction
    { '<leader>lt', '<cmd>LeetCodeTest<cr>', desc = 'Run Test Cases' },
    { '<leader>ls', '<cmd>LeetCodeSubmit<cr>', desc = 'Submit Solution' },
    { '<leader>ld', '<cmd>LeetCodeDesc<cr>', desc = 'Problem Description' },

    -- Session management
    { '<leader>lr', '<cmd>LeetCodeReset<cr>', desc = 'Reset Code' },
    { '<leader>lx', '<cmd>LeetCodeExit<cr>', desc = 'Exit LeetCode' },

    -- Console controls
    { '<leader>lc', '<cmd>LeetCodeConsole<cr>', desc = 'Toggle Console' },
  },

  config = function(_, opts)
    vim.keymap.set('n', '<leader>lp', function()
      vim.ui.select({
        'Easy',
        'Medium',
        'Hard',
      }, {
        prompt = 'Select difficulty:',
      }, function(selected)
        if selected then
          vim.cmd('LeetCodeList ' .. selected)
        end
      end)
    end, { desc = 'List by Difficulty' })

    require('leetcode').setup(opts)

    -- Additional autocommands for LeetCode buffer
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'leetcode.nvim',
      callback = function()
        -- Enable wrapping in problem description
        vim.opt_local.wrap = true
        -- Enable spell checking
        vim.opt_local.spell = true
      end,
    })
  end,
}
