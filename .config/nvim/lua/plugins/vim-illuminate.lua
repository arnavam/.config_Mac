return {
  "RRethy/vim-illuminate",
  config = function()
    require('illuminate').configure({
      providers = {
        'lsp',
        'treesitter',
        'regex',
      },
      delay = 100,
      filetypes_denylist = {
        'dirbuf',
        'dirvish',
        'fugitive',
      },
      under_cursor = true,
      large_file_cutoff = 10000,
      min_count_to_highlight = 1,
    })
  end,
}
