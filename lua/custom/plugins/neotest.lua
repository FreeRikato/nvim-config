return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- Adapters
    'nvim-neotest/neotest-python',
    'nvim-neotest/neotest-go',
    'nvim-neotest/neotest-jest',
  },
  config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-python'),
        require('neotest-go'),
        require('neotest-jest')({
          jestCommand = "npm test --",
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
      },
    })
  end,
  keys = {
    { '<leader>tr', function() require('neotest').run.run() end, desc = 'Run Nearest Test' },
    { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Run File Tests' },
    { '<leader>to', function() require('neotest').output.open({ enter = true }) end, desc = 'Show Test Output' },
    { '<leader>ts', function() require('neotest').summary.toggle() end, desc = 'Toggle Test Summary' },
  },
}