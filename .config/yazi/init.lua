
require("full-border"):setup {
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
}

require("mactag"):setup({
	-- Keys used to add or remove tags
	keys = {
		r = "Red",
		o = "Orange",
		y = "Yellow",
		g = "Green",
		b = "Blue",
		p = "Purple",
	},
	-- Colors used to display tags
	colors = {
		Red = "#ee7b70",
		Orange = "#f5bd5c",
		Yellow = "#fbe764",
		Green = "#91fc87",
		Blue = "#5fa3f8",
		Purple = "#cb88f8",
	},
})
-- require("eza-preview"):setup()
-- require("no-status"):setup()

-- DuckDB plugin configuration
require("duckdb"):setup(
  {
	mode = "summarized", -- Default: "summarized"
	cache_size = 1000, -- Default: 500
	row_id = "dynamic", -- Default: false
	minmax_column_width = 21, -- Default: 21
	column_fit_factor = 10.0, -- Default: 10.0
}
)

-- ~/.config/yazi/init.lua
require("relative-motions"):setup({ show_numbers = "relative", show_motion = true, enter_mode = "cache" })
require("mux"):setup({
	aliases = {
		eza_tree_1 = {
			previewer = "piper",
			args = {
				'cd "$1" && LS_COLORS="ex=32" eza --oneline --tree --level 1 --color=always --icons=always --group-directories-first --no-quotes .',
			},
		},
		eza_tree_2 = {
			previewer = "piper",
			args = {
				'cd "$1" && LS_COLORS="ex=32" eza --oneline --tree --level 2 --color=always --icons=always --group-directories-first --no-quotes .',
			},
		},
		eza_tree_3 = {
			previewer = "piper",
			args = {
				'cd "$1" && LS_COLORS="ex=32" eza --oneline --tree --level 3 --color=always --icons=always --group-directories-first --no-quotes .',
			},
		},
		eza_tree_4 = {
			previewer = "piper",
			args = {
				'cd "$1" && LS_COLORS="ex=32" eza --oneline --tree --level 4 --color=always --icons=always --group-directories-first --no-quotes .',
			},
		},
	},
})

th.git = th.git or {}
th.git.modified = ui.Style():fg("#E2C08D")
th.git.added = ui.Style():fg("#81B88B")
th.git.untracked = ui.Style():fg("#73C991")
th.git.deleted = ui.Style():fg("#C74E39")
th.git.updated = ui.Style():fg("#E4676B")
th.git.ignored = ui.Style():fg("#8C8C8C")
th.git.clean = ui.Style()
th.git.unknown = ui.Style():fg("#8C8C8C")

th.git.modified_sign = "M "
th.git.added_sign = "A "
th.git.untracked_sign = "U "
th.git.deleted_sign = "D "
th.git.updated_sign = "M "
th.git.ignored_sign = "I "
th.git.clean_sign = ""
th.git.unknown_sign = ""

require("git"):setup {
	-- Order of status signs showing in the linemode
	order = 1500,
}
