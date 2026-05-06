return {
  'ggml-org/llama.vim',
  init = function()
    vim.g.llama_config = {
      auto_fim = true,
      keymap_fim_accept_full = '<C-S>',
      keymap_fim_trigger = '<C-F>',
      keymap_fim_accept_line = '<C-G>',
      keymap_fim_accept_word = '<C-D>',
      enable_at_startup = true,
    }
  end,
}
