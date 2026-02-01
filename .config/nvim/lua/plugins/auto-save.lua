
return {
  "okuuva/auto-save.nvim",
  event = { "InsertLeave", "TextChanged" },
  opts = {
    enabled = true,
    execution_message = {
      message = function() return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S")) end
    },
    trigger_events = {
      immediate_save = { "BufLeave", "FocusLost" },
      defer_save = { "InsertLeave", "TextChanged" }
    },
    debounce_delay = 135,  -- ms delay after typing
    write_all_buffers = false
  }
}
