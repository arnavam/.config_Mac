return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  version = '*',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    -- require('mini.diff').setup()
--     require 'mini.surround'.setup {
--   -- Add custom surroundings to be used on top of builtin ones. For more
--   -- information with examples, see `:h MiniSurround.config`.
--   custom_surroundings = nil,
--
--   -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
--   highlight_duration = 500,
--
--   -- Module mappings. Use `''` (empty string) to disable one.
--   mappings = {
--     add = 'fa', -- Add surrounding in Normal and Visual modes
--     delete = 'fd', -- Delete surrounding
--     find = 'ff', -- Find surrounding (to the right)
--     find_left = 'fF', -- Find surrounding (to the left)
--     highlight = 'fh', -- Highlight surrounding
--     replace = 'fr', -- Replace surrounding
--
--     suffix_last = 'l', -- Suffix to search with "prev" method
--     suffix_next = 'n', -- Suffix to search with "next" method
--   },
--
--   -- Number of lines within which surrounding is searched
--   n_lines = 20,
--
--   -- Whether to respect selection type:
--   -- - Place surroundings on separate lines in linewise mode.
--   -- - Place surroundings on each line in blockwise mode.
--   respect_selection_type = false,
--
--   -- How to search for surrounding (first inside current line, then inside
--   -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
--   -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
--   -- see `:h MiniSurround.config`.
--   search_method = 'cover',
--
--   -- Whether to disable showing non-error feedback
--   -- This also affects (purely informational) helper messages shown after
--   -- idle time if user input is required.
--   silent = false,
-- }
    require 'mini.pairs'
    --   require('mini.misc').setup {
    --   auto_root = { enabled = true },
    -- 		restore_cursor = { enabled = true },
    -- 	-- termbg_sync ={enabled =true}
    -- }

    -- require('mini.indentscope').setup {
    --   options = {
    --     -- Type of scope'f border: which line(s) with smaller indent to
    --     -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
    --     border = 'both',
    --
    --     -- Whether to use cursor column when computing reference indent.
    --     -- Useful to see incremental scopes with horizontal cursor movements.
    --     indent_at_cursor = true,
    --
    --     -- Maximum number of lines above or below within which scope is computed
    --     n_lines = 10000,
    --
    --     -- Whether to first check input line to be a border of adjacent scope.
    --     -- Use it if you want to place cursor on function header to get scope of
    --     -- its body.
    --     try_as_border = true,
    --   },
    -- }
    require('mini.comment').setup {
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Toggle comment (like `gcip` - comment inner paragraph) for both
        -- Normal and Visual modes
        comment = 'gc',

        -- Toggle comment on current line
        comment_line = 'gcc',

        -- Toggle comment on visual selection
        comment_visual = '/',

        -- Define 'comment' textobject (like `dgc` - delete whole comment block)
        -- Works also in Visual mode if mapping differs from `comment_visual`
        textobject = '/',
      },
    }

    require('mini.statusline').setup {
      theme = 'nil', -- or any built-in theme
      content = {
        -- Replace default section separator with ">"
        separators = { section = ' > ' },
      },
      use_icons = vim.g.have_nerd_font,
    }
    local hipatterns = require 'mini.hipatterns'
    hipatterns.setup {
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    }
    -- You can configukkkkre sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    -- ---@diagnostic disable-next-line: duplicate-set-field
    -- statusline.section_location = function()
    --   return '%2l:%-2v'
    -- end

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
