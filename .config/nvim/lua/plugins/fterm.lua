return {
	'numToStr/FTerm.nvim',
	lazy = false, -- Enable immediately
	config = function()
		local fterm = require 'FTerm'

		-- Main terminal instance
		local main_term = fterm:new({
			border = 'rounded',
			dimensions = {
				height = 0.4,
				width = 0.4,
				x = 0.5,
				y = 0.5,
			},
			cmd = vim.o.shell,
		})

		-- Side terminal instance
		local side_term = fterm:new({
			ft = "fterm_side",
			dimensions = { height = 1.0, width = 0.4 },
			position = 'right',
			border = 'single',
			cmd = vim.o.shell,
		})

		-- Llama terminal instance
		local llama = fterm:new({
			ft = "fterm_llama",
			cmd = [[llama-server \
				--hf-repo ggml-org/Qwen2.5-Coder-1.5B-Q8_0-GGUF \
				--hf-file qwen2.5-coder-1.5b-q8_0.gguf \
				--port 8012 -ngl 99 --flash-attn on \
				--ubatch-size 512 --batch-size 1024 --cache-reuse 256]],
		})

		-- Keymaps
		vim.keymap.set('n', 't', function() main_term:toggle() end, { desc = 'Toggle main terminal' })
		vim.keymap.set('n', 'T', function() side_term:toggle() end, { desc = 'Toggle side terminal' })
		vim.keymap.set('n', '<leader>ls', function() llama:toggle() end, { desc = 'Toggle llama server' })

		-- Terminal mode escape to normal mode
		vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

		-- Close terminal in normal mode
		vim.api.nvim_create_autocmd('FileType', {
			pattern = 'FTerm',
			callback = function()
				local buf = vim.api.nvim_get_current_buf()
				vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = buf, silent = true })
			end,
		})
	end,
}
