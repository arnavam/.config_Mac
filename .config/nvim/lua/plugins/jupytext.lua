return {
  'goerz/jupytext.nvim',
  lazy = false,
--   opts = {
--      format = "py:percent",  -- Valid: creates #%% cells },
-- }
opts = {
  jupytext = 'jupytext',
     format = "markdown",  --markdown Valid: creates #%% cells },
  update = true,
  -- filetype = require("jupytext").get_filetype,
  -- new_template = require("jupytext").default_new_template(),
  -- sync_patterns = { '*.md', '*.py', '*.jl', '*.R', '*.Rmd', '*.qmd' },
  autosync = true,
  handle_url_schemes = true,
}
}
