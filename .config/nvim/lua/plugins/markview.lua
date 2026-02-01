return {
  'OXY2DEV/markview.nvim',
  lazy = false,

  -- Completion for `blink.cmp`
  dependencies = { 'saghen/blink.cmp' },
markdown= {  headings = {
    heading_1 = { icon_hl = '@markup.link', icon = '[%d] ' },
    heading_2 = { icon_hl = '@markup.link', icon = '[%d.%d] ' },
    heading_3 = { icon_hl = '@markup.link', icon = '[%d.%d.%d] ' },
  },}
}
