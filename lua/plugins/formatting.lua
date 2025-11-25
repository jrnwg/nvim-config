return {
  "tpope/vim-sleuth",
  {
    "stevearc/conform.nvim",
    opts = {
      -- Disable conform's automatic format-on-save so we use LSP formatting on save
      format_on_save = false,
      formatters_by_ft = {
        lua = { "stylua" },
        python = {
          "ruff_fix",
          "ruff_format",
          "ruff_organize_imports",
        },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        markdown = { "prettier" },
      },
    },
  },
}
