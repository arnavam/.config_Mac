return {
	'nvim-neo-tree/neo-tree.nvim',
	version = '*',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-tree/nvim-web-devicons',
		'MunifTanjim/nui.nvim',
	},
	lazy = false,
	enable_cursor_hijack = true,

	keys = {
		{ 's',         ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true, nowait = true },
		-- { '<leader>e', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true, nowait = true },
		-- Ctrl + Enter to open Neo-tree in horizontal split
	},

	opts = {
		filesystem = {
			window = {
				position = 'float',
				popup = { size = { height = '70%', width = '60%' }, border = 'rounded' },
				layout = { filter_position = 'top' },
				mappings = {
					['s'] = 'close_window',
					-- ['<leader>e'] = 'close_window',
					['..'] = 'navigate_up',
					['<leader>o'] = 'set_root', -- Set selected dir as root
					['<C-CR>'] = 'open_vsplit',
				},
			},
			-- Custom trash commands inside filesystem.commands
			commands = {
				delete = function(state)
					local inputs = require 'neo-tree.ui.inputs'
					local path = state.tree:get_node().path
					local msg = 'Are you sure you want to move to trash: ' .. path
					inputs.confirm(msg, function(confirmed)
						if not confirmed then
							return
						end

						-- Call your shell program like this
						vim.fn.system { '.move-to-dust-bin.sh', vim.fn.fnameescape(path) }
						require('neo-tree.sources.manager').refresh(state.name)
					end)
				end,
				delete_visual = function(state, selected_nodes)
					local inputs = require 'neo-tree.ui.inputs'
					local count = #selected_nodes
					local msg = 'Are you sure you want to move to trash ' .. count .. ' files?'
					inputs.confirm(msg, function(confirmed)
						if not confirmed then
							return
						end

						for _, node in ipairs(selected_nodes) do
							vim.fn.system { '.move-to-dust-bin.sh', vim.fn.fnameescape(node.path) }
						end

						require('neo-tree.sources.manager').refresh(state.name)
					end)
				end,
			},
    },
  },
}
