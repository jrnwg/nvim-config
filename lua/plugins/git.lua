return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs_staged_enable = true,
      current_line_blame = true,
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next", { target = "all" })
          end
        end)

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev", { target = "all" })
          end
        end)

        -- Actions
        map("n", "<leader>hp", gitsigns.preview_hunk_inline)
      end,
    },
  },
}
