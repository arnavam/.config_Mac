return {
  'tadaa/vimade',
  opts = {
    recipe = { 'default', { animate = true } },
    fadelevel = 0.4,
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
          -- 'fterm_side',
        },
        buf_opts = { buftype = { 'prompt' } },
      },
      default_block_floats = function(win, active)
        return win.win_config.relative ~= '' and (win ~= active or win.buf_opts.buftype == 'terminal') and true or false
      end,
    },
  },
}
