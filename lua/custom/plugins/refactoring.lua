return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('refactoring').setup({})
    vim.keymap.set('x', '<leader>re', ':Refactor extract ', { desc = 'Refactor Extract' })
    vim.keymap.set('x', '<leader>rf', ':Refactor extract_to_file ', { desc = 'Refactor Extract to File' })
    vim.keymap.set('x', '<leader>rv', ':Refactor extract_var ', { desc = 'Refactor Extract Var' })
    vim.keymap.set('n', '<leader>ri', ':Refactor inline_var', { desc = 'Refactor Inline Var' })
  end,
}