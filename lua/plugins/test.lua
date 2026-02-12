return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          runner = "pytest",
          env = {
            "POWERTOOLS_LOG_LEVEL=DEBUG",
            "POWERTOOLS_DEV=true",
          },
          args = {
            "-vv",
            "-s",
            "--log-cli-level=DEBUG",
            "--log-level=DEBUG",
          },
        }),
      },
    })
  end,
  keys = {
    { "<leader>tr", function() require("neotest").run.run() end,                     desc = "Run Nearest Test" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,   desc = "Run File Tests" },
    { "<leader>ts", function() require("neotest").summary.toggle() end,              desc = "Toggle Test Summary" },
    { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Open Test Output" },
  },
}
