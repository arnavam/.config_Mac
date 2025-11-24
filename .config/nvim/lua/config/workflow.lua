
--------------
-- obsidian --
--------------
--
-- >>> oo # from shell, navigate to vault (optional)
--
-- # NEW NOTE
-- >>> on "Note Name" # call my "obsidian new note" shell script (~/bin/on)
-- >>>
-- >>> ))) <leader>on # inside vim now, format note as template
-- >>> ))) # add tag, e.g. fact / blog / video / etc..
-- >>> ))) # add hubs, e.g. [[python]], [[machine-learning]], etc...
-- >>> ))) <leader>of # format title
--
-- # END OF DAY/WEEK REVIEW
-- >>> or # review notes in inbox
-- >>>
-- >>> ))) <leader>ok # inside vim now, move to zettelkasten
-- >>> ))) <leader>odd # or delete
-- >>>
-- >>> og # organize saved notes from zettelkasten into notes/[tag] folders
-- >>> ou # sync local with Notion
--
-- folder = '/Users/arnav/Library/Mobile Documents/iCloud~md~obsidian/Documents/ML'
-- navigate to vault
--
local library_path = "~/Library/Mobile\\ Documents/iCloud~md~obsidian/Documents/ML"
vim.keymap.set("n", "<leader>oo", ":cd " .. library_path .. "<cr>")
-- convert note to template and remove leading white space
vim.keymap.set("n", "<leader>on", ":ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>")

-- strip date from note title and replace dashes with spaces
vim.keymap.set("n", "<leader>of", ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>")
--
-- search for files in full vault
-- vim.keymap.set("n", "<leader>os", ":Telescope find_files search_dirs={\" ..library_path .. \"}<cr>")
-- vim.keymap.set("n", "<leader>oz", ":Telescope live_grep search_dirs={\"/Users/arnav/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/ML\"}<cr>")

--
-- search for files in notes (ignore zettelkasten)
-- vim.keymap.set("n", "<leader>ois", ":Telescope find_files search_dirs={\"/Users/alex/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/ZazenCodes/notes\"}<cr>")
-- vim.keymap.set("n", "<leader>oiz", ":Telescope live_grep search_dirs={\"/Users/alex/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/ZazenCodes/notes\"}<cr>")
--
-- for review workflow
-- move file in current buffer to zettelkasten folder
-- delete file in current buffer
vim.keymap.set("n", "<leader>ok", function()
  vim.cmd(string.format([[:!mv '%s' '%s']], vim.fn.expand('%:p'), library_path))
  vim.cmd(":bd")
end)

vim.keymap.set("n", "<leader>od", ":!rm '%:p'<cr>:bd<cr>")




