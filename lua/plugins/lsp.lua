return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- Configure LSP floating windows with rounded borders
      -- Use init instead of config to run before plugin loads
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "rounded" }
      )

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = "rounded" }
      )
    end,
    config = function()
      -- Enable lua_ls
      vim.lsp.enable("lua_ls")

      -- Configure Python LSP servers
      vim.lsp.config("pyright", {
        root_markers = { ".venv" },
        settings = {
          pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              extraPaths = { "src", "libs" },
              dignostics = "workspace",
            },
          },
        },
      })
      vim.lsp.enable("pyright")

      vim.lsp.config("ruff", {
        root_markers = { ".venv" },
      })
      vim.lsp.enable("ruff")

      -- Configure TypeScript/JavaScript LSP
      vim.lsp.config("ts_ls", {
        root_markers = { "tsconfig.base.json", "nx.json", "package.json" },
      })
      vim.lsp.enable("ts_ls")

      -- Configure Rust LSP
      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
            },
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      })
      vim.lsp.enable("rust_analyzer")

      -- Enable GitHub Copilot LSP (provided by copilot.lua plugin)
      vim.lsp.enable("copilot")

      -- LSP Keymaps (only set when LSP attaches)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
          end

          -- Essential LSP mappings
          -- map("gd", vim.lsp.buf.definition, "Go to Definition")
          -- map("gr", vim.lsp.buf.references, "Go to References")
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          -- map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
          -- map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("grn", vim.lsp.buf.rename, "Rename")
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
      library = {
        { path = "snacks.nvim", words = { "Snacks" } },
      },
      integrations = {
        blink = true,
      },
    },
  },
}
