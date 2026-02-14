local M = {}

M.config = {
  sync_status_line = false,
  tmux_colors_path = "~/.config/tmux/colors.conf",
}

function M.setup(options)
  M.config = vim.tbl_deep_extend("force", M.config, options or {})

  vim.api.nvim_create_user_command("TmuxSync", function()
    if M.config.sync_status_line then
      M.sync_status_line()
    end
  end, {})
end

function M.sync_status_line()
  local path = vim.fn.expand(M.config.tmux_colors_path)

  local status_ok, lualine = pcall(require, "lualine")
  if not status_ok then
    vim.notify("Lualine is not installed, doing nothing.", vim.log.levels.DEBUG)
    return
  end

  lualine.refresh()

  local theme_name = lualine.get_config().options.theme
  local theme = require("lualine.utils.loader").load_theme(theme_name)
  if not theme then
    vim.notify("Could not load lualine theme: " .. theme_name, vim.log.levels.ERROR)
    return
  end

  local tmux_lines = {
    string.format('set -g @normal_a_bg "%s"', theme.normal.a.bg),
    string.format('set -g @normal_a_fg "%s"', theme.normal.a.fg),
    string.format('set -g @normal_b_bg "%s"', theme.normal.b.bg),
    string.format('set -g @normal_b_fg "%s"', theme.normal.b.fg),
    string.format('set -g @normal_c_bg "%s"', theme.normal.c.bg),
    string.format('set -g @normal_c_fg "%s"', theme.normal.c.fg),
    string.format('set -g @insert_bg "%s"', theme.insert.a.bg),
    string.format('set -g @insert_fg "%s"', theme.insert.a.fg),
    string.format('set -g @command_bg "%s"', theme.command.a.bg),
    string.format('set -g @command_fg "%s"', theme.command.a.fg),
    string.format('set -g @visual_bg "%s"', theme.visual.a.bg),
    string.format('set -g @visual_fg "%s"', theme.visual.a.fg),
  }

  local file = io.open(path, "w")
  if not file then
    vim.notify("Could not open tmux colors file: " .. path, vim.log.levels.ERROR)
    return
  end

  file:write(table.concat(tmux_lines, "\n"))
  file:close()

  vim.fn.jobstart({ "tmux", "source-file", path })
  vim.notify("Tmux status line synced with lualine theme: " .. theme_name, vim.log.levels.INFO)
end

return M
