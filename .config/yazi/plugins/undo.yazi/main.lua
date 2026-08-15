local M = {}
local shell = os.getenv("SHELL") or ""
local PackageName = "Undo"

---@class TrashItem
---@field trash_info Url
---@field trash_file Url

---@class Theme
---@field title? any
---@field header? any
---@field header_warning? any
---@field list_item? {odd?: any, even?: any}

---@class SetupOptions
---@field position? AsPos
---@field show_confirm? boolean
---@field theme? Theme
---@field suppress_success_notification? boolean

---@enum File_Type
local File_Type = {
	File = "file",
	Dir = "dir_all",
	None_Exist = "unknown",
}

local set_state = ya.sync(function(state, key, value)
	if not state then
		state = {}
	end
	state[key] = value
end)

local get_state = ya.sync(function(state, key)
	return state and state[key]
end)

---@enum STATE
local STATE = {
	POSITION = "position",
	SHOW_CONFIRM = "show_confirm",
	SUPPRESS_SUCCESS_NOTIFICATION = "suppress_success_notification",
	THEME = "theme",
	INITIALIZED = "initialized",
}

local home = os.getenv("HOME")
local TRASH_INFO = home .. "/.local/share/Trash/info"
local TRASH_FILES = home .. "/.local/share/Trash/files"
local HISTORY_FILE = home .. "/.yazi_history"

-- Split string by delimiter
---@param s string
---@param delim string
---@return string[]
local function split(s, delim)
	local t = {}
	for part in s:gmatch("[^" .. delim .. "]+") do
		t[#t + 1] = part
	end
	return t
end

local function shell_execute(cmd)
	local handle = assert(io.popen(cmd, "r"))
	local output = handle:read("*a")
	handle:close()
	return output
end

local function error(s, ...)
	ya.notify({ title = PackageName, content = string.format(s, ...), timeout = 5, level = "error" })
end

---@param path string  -- absolute original path
---@return TrashItem|nil
-- local function get_trash_info(path)
-- 	local trash_info = Url(shell_execute('rg "^Path=' .. path .. '$" ' .. TRASH_INFO .. ' -l | head -n 1 | tr -d "\n"'))
--
-- 	if not trash_info then
-- 		return
-- 	end
--
-- 	local trash_file = Url(TRASH_FILES .. "/" .. trash_info.stem)
--
-- 	-- @type trash_item TrashItem
-- 	local trash_item = {
-- 		trash_info = trash_info,
-- 		trash_file = trash_file,
-- 	}
--
-- 	return trash_item
-- end

local function hist_push(text)
	local file = assert(io.open(HISTORY_FILE, "a"))
	file:write(text, "\n")
	file:close()
end

local function hist_pop()
	local file = assert(io.open(HISTORY_FILE, "r"))

	--- @type string[]
	local lines = {}
	for line in file:lines() do
		table.insert(lines, line)
	end

	file:close()

	if #lines == 0 then
		return
	end

	--- @type string
	local top = table.remove(lines, #lines)

	file = assert(io.open(HISTORY_FILE, "w"))
	for _, line in ipairs(lines) do
		file:write(line, "\n")
	end
	file:close()

	return top
end

local function hist_clear()
	assert(io.open(HISTORY_FILE, "w")):close()
end

local function hist_top()
	local file = assert(io.open(HISTORY_FILE, "r"))

	local lines = {}
	for line in file:lines() do
		table.insert(lines, line)
	end

	file:close()

	if #lines == 0 then
		return
	end

	return lines[#lines]
end

--- Setup plugin, add it to yazi/init.lua file
---@param opts? SetupOptions
function M:setup(opts)
	local f = io.open(HISTORY_FILE, "a")
	if f then
		f:close()
	end

	if opts and type(opts) ~= "table" then
		return
	end
	set_state(
		STATE.POSITION,
		(opts and type(opts.position) == "table") and opts.position or { "center", w = 70, h = 40 }
	)
	set_state(STATE.SHOW_CONFIRM, opts == nil or opts.show_confirm ~= false)
	set_state(STATE.THEME, (opts and type(opts.theme) == "table") and opts.theme or {})
	set_state(STATE.SUPPRESS_SUCCESS_NOTIFICATION, opts and opts.suppress_success_notification)
	set_state(STATE.INITIALIZED, true)

	ps.sub("trash", function(body)
		local history_line = { "trash" }

		for _, url in ipairs(body.urls) do
			local trash_list = shell_execute('trash-list | tac | grep "' .. url .. '"')
			local trash_item = table.unpack(split(trash_list, "\n"))
			local _, _, item_path = table.unpack(split(trash_item, " "))

			table.insert(history_line, item_path)
		end

		hist_push(table.concat(history_line, " "))
	end)

	ps.sub("move", function(body)
		for _, item in ipairs(body.items) do
			--- @type Url, Url
			local from, to = item.from, item.to

			ya.dbg("New move: " .. tostring(item.from) .. " -> " .. tostring(item.to))
		end
	end)

	ps.sub("rename", function(body)
		ya.dbg("New rename: " .. tostring(body.from) .. " -> " .. tostring(body.to))
	end)
end

local function get_latest_trash_item_by_path(path)
	local trash_list, _ = Command(shell)
		:arg({
			"-c",
			'echo | trash-restore "/" | tac | grep "' .. path .. '"',
		})
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:output()

	if not trash_list then
		return
	end

	local trash_item = table.unpack(split(trash_list.stdout, "\n"))

	if not trash_item then
		return
	end

	return table.unpack(split(trash_item, " "))
end

--- Restore items from trash by their restore index
--- @param ids string[]  -- list of restore ids
local function restore_items(ids)
	local restored_status, _ = Command(shell)
		:arg({
			"-c",
			"echo " .. table.concat(ids, ",") .. ' | trash-restore --overwrite "/"',
		})
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:output()

	if not restored_status then
		error("Failed to restore items from trash.")
		return false
	end

	return true
end

local function undo_trash(args)
	if #args == 0 then
		error("No items to restore from trash.")
		return
	end

	local ids_to_restore = {}

	for _, path in ipairs(args) do
		local id = get_latest_trash_item_by_path(path)
		if id then
			table.insert(ids_to_restore, id)
		else
			ya.dbg("No trash item found for path: " .. path)
		end
	end

	if #ids_to_restore == 0 then
		error("Trash items not found.")
		return
	end

	local did_restore = restore_items(ids_to_restore)

	if not did_restore then
		return
	end

	local nb_restored = #ids_to_restore
	local plural = nb_restored > 1 and "s" or ""
	ya.notify({
		title = PackageName,
		content = "Restored " .. nb_restored .. " item" .. plural .. " from trash.",
		timeout = 5,
		level = "info",
	})
end

function M:entry(job)
	if not get_state(STATE.INITIALIZED) then
		M:setup()
	end

	local history_line = hist_pop()

	if not history_line then
		ya.notify({ title = PackageName, content = "No more undo entries.", timeout = 5, level = "info" })
		return
	end

	local parts = split(history_line, " ")
	local command = parts[1]
	local args = { table.unpack(parts, 2) }

	if command == "trash" then
		undo_trash(args)
	else
		error("Unknown undo command: %s", command)
	end
end

return M
