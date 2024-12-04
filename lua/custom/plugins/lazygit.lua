return {
  'kdheepak/lazygit.nvim',
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    -- Custom keymap to open lazygit with current file highlighted
    vim.keymap.set('n', '<leader>lg', function()
      local file = vim.fn.expand '%:t'
      vim.cmd 'LazyGit'
      -- Wait for LazyGit to load then search for current file
      vim.defer_fn(function()
        vim.api.nvim_feedkeys('/' .. file, 't', true)
        vim.api.nvim_input '<CR>'
        vim.api.nvim_input '<ESC>'
      end, 150)
    end, { desc = 'Open LazyGit' })

    -- Additional keymaps for git operations
    vim.keymap.set('n', '<leader>gc', '<cmd>LazyGitCurrentFile<cr>', { desc = 'LazyGit Current File' })
    vim.keymap.set('n', '<leader>gf', '<cmd>LazyGitFilter<cr>', { desc = 'LazyGit Filter' })
  end,
}
