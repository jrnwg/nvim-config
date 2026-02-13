local M = {}

local defaults = {
  sync_status_line = false,
  tmux_colors_path = "~/.config/tmux/colors.conf",
}

M.config = vim.deepcopy(defaults)

M.setup = function(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})

  vim.api.nvim_create_user_command("TmuxSync", function()
    if M.config.sync_status_line then
      M.sync_status_line()
    end
  end, {})
end

M.sync_status_line = function()
  local path = vim.fn.expand(M.config.tmux_colors_path)

  local status_ok, lualine = pcall(require, "lualine")
  if not status_ok then
    print("Lualine is not installed, cannot sync tmux status line colors.")
    return
  end

  lualine.refresh()

  local theme_name = lualine.get_config().options.theme
  local theme = require("lualine.utils.loader").load_theme(theme_name)
  if not theme then
    print("Could not load theme table for: " .. theme_name)
    return
  end

  local tmux_lines = {
    string.format('set -g @theme_bg "%s"', theme.normal.c.bg),
    string.format('set -g @theme_status_bg "%s"', theme.normal.a.bg),
    string.format('set -g @theme_status_fg "%s"', theme.normal.a.fg),
    string.format('set -g @theme_window_bg "%s"', theme.normal.c.bg),
    string.format('set -g @theme_window_fg "%s"', theme.normal.b.fg),
    string.format('set -g @theme_window_current_bg "%s"', theme.normal.b.bg),
    string.format('set -g @theme_window_current_fg "%s"', theme.normal.b.fg),
  }

  local file = io.open(path, "w")
  if file then
    file:write(table.concat(tmux_lines, "\n"))
    file:close()

    vim.fn.jobstart({ "tmux", "source-file", path })
  end
end

return M
