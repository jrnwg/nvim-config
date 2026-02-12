return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = { "lua", "vim", "vimdoc", "python", "rust", "toml" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
