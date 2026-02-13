return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        section_separators = "",
        component_separators = "│",
        globalstatus = true,
      },
      sections = {
        lualine_c = {
          {
            "filename",
            file_status = true,
            newfile_status = false,
            path = 1,
            shorting_target = 40,
          },
        },
      },
    },
    config = function(_, opts)
      require("lualine").setup(opts)
      require("core.tmux").setup({
        sync_status_line = true,
        tmux_colors_path = "~/.config/tmux/colors.conf",
      })
    end,
  },
}
