return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Enable lua_ls
      vim.lsp.enable("lua_ls")

      -- LSP Keymaps (only set when LSP attaches)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
          end

          -- Essential LSP mappings
          map("gd", vim.lsp.buf.definition, "Go to Definition")
          map("gr", vim.lsp.buf.references, "Go to References")
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("<leader>f", vim.lsp.buf.format, "Format Document")
        end,
      })
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      integrations = {
        blink = true,
      },
    },
  },
}
