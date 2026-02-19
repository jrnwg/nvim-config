return {
  {
    "folke/sidekick.nvim",
    dependencies = {
      "zbirenbaum/copilot.lua",
    },
    opts = {
      nes = { enabled = false },
    },
    keys = {
      -- stylua: ignore start

      { "<leader>aa", function() require("sidekick.cli").select() end, desc = "Select CLI", },
      { "<leader>ad", function() require("sidekick.cli").close() end, desc = "Detach a CLI Session" },
      { "<leader>at", function() require("sidekick.cli").send({ msg = "{this}" }) end, mode = { "x", "n" }, desc = "Send This" },
      { "<leader>af", function() require("sidekick.cli").send({ msg = "{file}" }) end, desc = "Send File" },
      { "<leader>av", function() require("sidekick.cli").send({ msg = "{selection}" }) end, mode = { "x" }, desc = "Send Visual Selection" },
      { "<leader>ap", function() require("sidekick.cli").prompt() end, mode = { "n", "x" }, desc = "Sidekick Select Prompt" },

      --stylua ignore end
    },
  },
}
