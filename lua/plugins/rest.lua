return {
  "mistweaverco/kulala.nvim",
  config = function()
    require("kulala").setup({
      -- It detects JSON and formats it by default
      format_on_save = false,
    })
  end,
  keys = {
    { "<leader>rr", function() require("kulala").run() end,         desc = "Run Request" },
    { "<leader>rt", function() require("kulala").toggle_view() end, desc = "Toggle Headers/Body" },
  },
}
