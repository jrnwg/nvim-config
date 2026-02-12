return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require "lint"
      lint.linters_by_ft = {
        python = { "mypy" },
        javascript = { "eslint" },
        javascriptreact = { "eslint" },
        typescript = { "eslint" },
        typescriptreact = { "eslint" },
        rust = { "clippy" },
      }

      -- Resolve the correct project root
      local root_markers = {
        python = { ".venv" },
        javascript = { "tsconfig.base.json", "nx.json", "package.json" },
        javascriptreact = { "tsconfig.base.json", "nx.json", "package.json" },
        typescript = { "tsconfig.base.json", "nx.json", "package.json" },
        typescriptreact = { "tsconfig.base.json", "nx.json", "package.json" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          if vim.bo.modifiable then
            local markers = root_markers[vim.bo.filetype]
            local cwd = markers and vim.fs.root(0, markers) or nil
            lint.try_lint(nil, { cwd = cwd })
          end
        end,
      })
    end,
  },
}
