return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Enable lua_ls
      vim.lsp.enable("lua_ls")

      -- Configure Python LSP servers
      vim.lsp.config("pyright", {
        settings = {
          pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
          },
        },
      })
      vim.lsp.enable("pyright")
      vim.lsp.enable("ruff")

      -- Enable GitHub Copilot LSP (provided by copilot.lua plugin)
      vim.lsp.enable("copilot")

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

          -- Disable hover for Ruff (let Pyright handle it)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
          end
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
