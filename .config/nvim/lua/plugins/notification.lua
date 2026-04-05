return {
  'ObserverOfTime/notifications.nvim',
  opts = {
    override_notify = true,
    hist_command = 'Notifications',
    -- or set `icons = false` to disable all icons
    icons = {
      TRACE = '', -- '🔍',
      DEBUG = '󰠭', -- '🐞',
      INFO  = '', -- '📣',
      WARN  = '', -- '⚠️ ',
      ERROR = '', -- '🚨',
      OFF   = '', -- '⛔',
    },
    hl_groups = {
      TRACE = 'DiagnosticFloatingHint',
      DEBUG = 'DiagnosticFloatingHint',
      INFO = 'DiagnosticFloatingInfo',
      WARN = 'DiagnosticFloatingWarn',
      ERROR = 'DiagnosticFloatingError',
      OFF = 'DiagnosticFloatingOk',
    }
  },
  -- to use OSC 777/99/9:
  --[[
  config = function(_, opts)
    vim.g.notifications_use_osc = '777'
    require('notifications').setup(opts)
  end
  --]]
}
