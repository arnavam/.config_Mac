-- debug.lua

return {
	'mfussenegger/nvim-dap',
	dependencies = {
		'rcarriga/nvim-dap-ui',  -- Creates a beautiful debugger UI
		'nvim-neotest/nvim-nio', -- Required dependency for nvim-dap-ui
		'mason-org/mason.nvim',  -- Installs the debug adapters for you
		'jay-babu/mason-nvim-dap.nvim',
		"mfussenegger/nvim-dap-python",
		"theHamsta/nvim-dap-virtual-text",
	},
	keys = {
		{
			"<A-r>",
			function() require("dap").repl.toggle(nil, "tab split") end,
			desc = "Toggle DAP REPL",
		},

		-- Basic debugging keymaps, feel free to change to your liking!
		{ '<F5>',       function() require('dap').continue() end,                                            desc = 'Debug: Start/Continue' },
		{ '<F10>',      function() require('dap').step_over() end,                                           desc = 'Debug: Step Over' },
		{ '<F11>',      function() require('dap').step_into() end,                                           desc = 'Debug: Step Into' },
		{ '<F12>',      function() require('dap').step_out() end,                                            desc = 'Debug: Step Out' },
		-- { '<leader>du', function() require('dapui').toggle() end, desc = 'Toggle Debug UI' },
		{ '<F7>',       function() require('dapui').toggle() end,                                            desc = 'Debug: See last session result.' },
		-- Breakpoints
		{ '<leader>db', function() require('dap').toggle_breakpoint() end,                                   desc = 'Toggle Breakpoint' },
		{ '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input 'Condition: ') end,            desc = 'Conditional Breakpoint' },
		{ '<leader>dL', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point: ')) end, desc = 'Log Point' },
		{ '<leader>dD', function() require('dap').clear_breakpoints() end,                                   desc = 'Clear All Breakpoints' },

		-- Evaluation and Watches
		{ '<leader>de', function() require('dapui').eval() end,                                              desc = 'Evaluate Expression',             mode = { 'n', 'v' } },
		{ '<leader>dE', function() require('dapui').eval(vim.fn.expand('<cword>')) end,                      desc = 'Evaluate Word Under Cursor' },
		-- { '<leader>dw', function()
		--     local expr = vim.fn.input('Watch expression: ')
		--     if expr and expr ~= '' then
		--       require('dapui').watch(expr)
		--     end
		--   end, desc = 'Add Watch Expression' },
		-- { '<leader>dW', function() require('dapui').watch(vim.fn.expand('<cword>')) end, desc = 'Watch Word Under Cursor' },
		-- Sessions and UI
		{ '<F7>',       function() require('dapui').toggle() end,                                            desc = 'Toggle Full-screen Debug Console' },
		{ '<leader>du', function() require('dapui').toggle() end,                                            desc = 'Toggle Debug UI' },
		{ '<leader>dU', function() require('dapui').toggle({ reset = true }) end,                            desc = 'Reset Debug UI' },
		-- Session control
		{ '<leader>dc', function() require('dap').close() end,                                               desc = 'Close Debug Session' },
		{ '<leader>dC', function() require('dap').run_to_cursor() end,                                       desc = 'Run to Cursor' },
		{ '<leader>dl', function() require('dap').run_last() end,                                            desc = 'Run Last Configuration' },
		{ '<leader>di', function() require('dap').repl.open() end,                                           desc = 'Open Interactive REPL' },
		{ '<leader>dp', function() require('dap').pause() end,                                               desc = 'Pause Debug Session' },
		-- Navigation
		{ '<leader>dn', function() require('dap').down() end,                                                desc = 'Down Stack Frame' },
		{ '<leader>dN', function() require('dap').up() end,                                                  desc = 'Up Stack Frame' },

	},
	config = function()
		local dap = require 'dap'
		local dapui = require 'dapui'
		local dap_python = require "dap-python"


		require("nvim-dap-virtual-text").setup({
			commented = true,   -- Show virtual text alongside comment
			all_frames = true,  -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
			virt_lines = true,  -- show virtual lines instead of virtual text (will flicker!)
			virt_text_win_col = nil
		})
		require('mason-nvim-dap').setup {
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_installation = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			-- You'll need to check that you have the required things installed
			-- online, please don't ask me how to install them :)
			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
				'python'

			},
		}

		---@diagnostic disable-next-line: missing-fields
		require("dapui").setup({
			icons = { expanded = "", collapsed = "", current_frame = "" },
			mappings = {
				-- Use a table to apply multiple mappings
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				edit = "e",
				repl = "r",
				toggle = "t",
			},
			-- Use this to override mappings for specific elements
			element_mappings = {},
			expand_lines = vim.fn.has("nvim-0.7") == 1,
			layouts = {
				-- {
				--   elements = {
				--     -- Stack vertically for narrow sidebar
				--   --  { id = "scopes", size = 0.35 },      -- Variables and state
				--     { id = "breakpoints", size = 0.25 }, -- Breakpoints list
				--     { id = "stacks", size = 0.20 },      -- Call stack
				--     { id = "watches", size = 0.20 },     -- Watch expressions
				--   },
				--   size = 5, -- Narrow but readable
				--   position = "left",
				-- },
				{
					elements = {
						{ id = "repl",    size = 0.8 }, -- REPL gets most space
						{ id = "console", size = 0.2 }, -- Console minimal
					},
					size = 10,                        -- Short height
					position = "bottom",
				},
			},

			controls = {
				enabled = vim.fn.has("nvim-0.5") == 1,
				-- Display controls in this element
				element = "repl",
				icons = {
					pause = "",
					play = "",
					step_into = "",
					step_over = "",
					step_out = "",
					step_back = "",
					run_last = "",
					terminate = "",
				},
			},
			floating = {
				max_height = nil,
				max_width = nil,
				border = "single",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			windows = { indent = 1 },
			render = {
				max_type_length = nil,
				max_value_lines = 100,
				indent = 1,
			},
		})
		dap_python.setup("python3")

		-- Change breakpoint icons
		vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
		vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
		local breakpoint_icons = vim.g.have_nerd_font
				and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
				or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
		for type, icon in pairs(breakpoint_icons) do
			local tp = 'Dap' .. type
			local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
			vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
		end

		-- Track debug session state

		-- Modified listeners with messages
		dap.listeners.after.event_initialized['dapui_config'] = function()
			vim.notify("🔴 Debug session started - Press F7 to show debugger", vim.log.levels.INFO)
			-- Don't auto-open UI, wait for F7
		end

		dap.listeners.before.event_terminated['dapui_config'] = function()
			vim.notify("🟢 Debug session ended", vim.log.levels.INFO)
		end

		dap.listeners.before.event_exited['dapui_config'] = function()
			vim.notify("🟢 Debug session exited", vim.log.levels.INFO)
		end

		dap.listeners.after.event_initialized['dapui_config'] = nil
		dap.listeners.before.event_terminated['dapui_config'] = nil
		dap.listeners.before.event_exited['dapui_config'] = nil

		-- Simple F7 toggle - works regardless of debug session state
		vim.keymap.set('n', '<F7>', function()
			require('dapui').toggle()
		end, { desc = 'Toggle Debug UI' })

		vim.keymap.set({ 'n', 'v' }, '<leader>ds', function()
				-- First open the clean dapui version
				require('dapui').float_element('scopes', {
					width = 150,
					height = 30,
					enter = true,   -- Enter the window so you can interact
					position = "center",
					border = "rounded",
					title = 'Scopes'
				})

				-- Add some helpful keymaps to the floating window
				vim.keymap.set('n', 'e', function()
					-- Simple evaluation of the variable under cursor
					require('dapui').eval(vim.fn.expand('<cword>'))
				end, { buffer = true, desc = 'Evaluate variable' })

				vim.keymap.set('n', 'E', function()
					local word = vim.fn.input('Expression: ')
					require('dapui').eval(word)
				end, { buffer = true, desc = 'Evaluate expression' })
			end,
			{ desc = 'Float Scopes (Variables)' })
		vim.keymap.set('n', '<leader>dt', function()
			require('dapui').float_element('stacks', {
				width = 70,
				height = 15,
				enter = true
				,
				position = 'center',
				border = 'rounded'
				,
				title = 'Stacks'
			})
		end, { desc = 'Float Call Stack' })


		vim.keymap.set('n', '<leader>dbp', function()
			require('dapui').float_element('breakpoints', {
				width = 70,
				height = 15,
				enter = true
				,
				position = 'center',
				border = 'rounded'
				,
				title = 'BreakPoints'
			})
		end, { desc = 'Float Breakpoints' })

		vim.keymap.set('n', '<leader>dw', function()
			require('dapui').float_element('watches', {
				width = 70,
				height = 15,
				enter = true
				,
				position = 'center',
				border = 'rounded'
				,
				title = 'Watches'
			})
		end, { desc = 'Float Watches' })

		vim.keymap.set('n', '<leader>drp', function()
			require('dapui').float_element('repl', {
				width = 70,
				height = 15,
				enter = true
				,
				position = 'center',
				border = 'rounded'
				,
				title = 'RepL'
			})
		end, { desc = 'Float REPL' })

		vim.keymap.set('n', '<leader>dcl', function()
			require('dapui').float_element('console', {
				width = 140,
				height = 30,
				enter = true
				,
				position = 'center',
				border = 'rounded'
				,
				title = 'Console'
			})
		end, { desc = 'Float Console' })

		table.insert(dap.configurations.python, {
			type = 'python',
			request = 'launch',
			name = 'Launch with ',
			program = '${file}',
			console = 'External Terminal',
			justMyCode = false,
		})
		table.insert(dap.configurations.python, {
			type = 'python',
			request = 'launch',
			name = 'Integrated Terminal',
			program = '${file}',
			console = 'integratedTerminal',
		})
		vim.api.nvim_create_autocmd('VimLeave', {
  callback = function()
    if dap.session() then
      dapui.close()
      dap.terminate()
      vim.wait(150)
    end
  end,
})

	end,
}
