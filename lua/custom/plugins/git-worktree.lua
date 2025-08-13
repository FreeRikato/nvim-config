return {
  {
    'ThePrimeagen/git-worktree.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local Worktree = require 'git-worktree'

      -- Setup configuration
      Worktree.setup {
        change_directory_command = 'cd',
        update_on_change = true,
        update_on_change_command = 'e .',
        clearjumps_on_change = true,
        autopush = false,
      }

      -- Optional: Hook to show worktree switch in status
      Worktree.on_tree_change(function(op, metadata)
        if op == Worktree.Operations.Switch then
          vim.notify('Switched from ' .. metadata.prev_path .. ' → ' .. metadata.path, vim.log.levels.INFO)
        end
      end)

      -- Load telescope extension
      require('telescope').load_extension 'git_worktree'
    end,
  },
}
