return {
  'tadaa/vimade',
  config = function()
    vim.keymap.set('n', '<leader>uv', '<Cmd>VimadeToggle<CR>', { desc = 'Toggle vimade' })

    require('vimade').setup {
      recipe = { 'minimalist', { animate = true } },
      -- ncmode = 'windows',
      --
      fadelevel = 0.7,
      tint = {
        bg = { rgb = { 0, 0, 0 }, intensity = 0.5 },
        fg = { rgb = { 255, 255, 255 }, intensity = 0.2 },
      },
      blocklist = {
        default = {
          highlights = {
            laststatus_3 = function(win, active)
              if vim.go.laststatus == 3 then
                return 'StatusLine'
              end
            end,
            'TabLineSel',
            'Pmenu',
            'PmenuSel',
            'PmenuKind',
            'PmenuKindSel',
            'PmenuExtra',
            'PmenuExtraSel',
            'PmenuSbar',
            'PmenuThumb',
            'fterm_side',
            'sidekick',
          },
          buf_opts = { buftype = { 'prompt' } },
          buf_name = { 'neo-tree', 'sidekick' },
        },
      },
    }
  end,
}
