return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme tokyonight")
    end,
  },
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   vim.g.zenbones_darkness = "warm"
    --   vim.cmd.colorscheme('zenbones')
    -- end
  },
}
