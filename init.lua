require("config.globals")
require("config.options")
require("config.keymaps")
require("core.lazy")
require("config.autocmds")

require("core.tmux").setup({
  sync_status_line = true,
  tmux_colors_path = "~/.config/tmux/colors.conf",
})
