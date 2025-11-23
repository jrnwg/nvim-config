return {
  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      keymap = {
        preset = "default",
        ["<Tab>"] = {
          function(cmp)
            -- First: Try sidekick next edit suggestion
            if require("sidekick").nes_jump_or_apply() then
              return true
            end
          end,
          "snippet_forward", -- Second: Snippet navigation
          "fallback", -- Third: Normal tab
        },
      },
      sources = {
        default = { "lsp", "path", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
      completion = {
        accept = {
          auto_brackets = { enabled = true },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },
      signature = { enabled = true },
    },
  },
}
