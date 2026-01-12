return {
  "folke/zen-mode.nvim",
  opts = {
    window = {
      backdrop = 0.95,
      width = 120,
      height = 1,
      options = {
        signcolumn = "no",
        number = false,
        relativenumber = false,
        cursorline = false,
        cursorcolumn = false,
        foldcolumn = "0",
        list = false,
        showtabline = 0,
      },
    },
    plugins = {
      options = {
        enabled = true,
        ruler = false,
        showcmd = false,
        laststatus = 0,
      },
      twilight = { enabled = false },
      gitsigns = { enabled = false },
      tmux = { enabled = true },
      kitty = { enabled = false },
      alacritty = { enabled = false },
      wezterm = { enabled = false },
      neovide = { enabled = false },
    },
    on_open = function(_)
    end,
    on_close = function()
    end,
  },
}
