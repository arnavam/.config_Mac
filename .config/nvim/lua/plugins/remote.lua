return {
  "amitds1997/remote-nvim.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("remote-nvim").setup({
      client_callback = function(port, workspace_config)
        local cmd

        if vim.env.TERM == "xterm-kitty" then
          cmd = ("kitty -e nvim --server localhost:%s --remote-ui"):format(port)
        elseif vim.env.GHOSTTY_BIN_DIR ~= nil or vim.env.TERM == "xterm-ghostty" then
          -- Ghostty command to open a new window/tab running the nvim remote client
          cmd = ("ghostty -e nvim --server localhost:%s --remote-ui"):format(port)
        else
          -- Default WezTerm logic
          cmd = ("wezterm cli set-tab-title --pane-id $(wezterm cli spawn nvim --server localhost:%s --remote-ui) %s"):format(
            port,
            ("'Remote: %s'"):format(workspace_config.host)
          )
        end

        vim.fn.jobstart(cmd, {
          detach = true,
          on_exit = function(job_id, exit_code, event_type)
            if exit_code ~= 0 then
              print("Client", job_id, "exited with code", exit_code)
            end
          end,
        })
      end,
    })
  end,
}
