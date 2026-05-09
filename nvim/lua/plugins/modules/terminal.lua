local M = {}

local state = {
	bufnr = nil,
	winid = nil,
	last_size = "small",
}

local function term_height(mode)
	if mode == "full" then
		return math.max(vim.o.lines - 2, 1)
	end

	return 15
end

local function is_valid_buf(bufnr)
	return bufnr and vim.api.nvim_buf_is_valid(bufnr)
end

local function is_valid_win(winid)
	return winid and vim.api.nvim_win_is_valid(winid)
end

local function focus_terminal_window()
	if is_valid_win(state.winid) then
		vim.api.nvim_set_current_win(state.winid)
		return true
	end

	return false
end

local function create_terminal_window(mode)
	local current_win = vim.api.nvim_get_current_win()

	vim.cmd("botright split")
	state.winid = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_height(state.winid, term_height(mode))

	if is_valid_buf(state.bufnr) then
		vim.api.nvim_win_set_buf(state.winid, state.bufnr)
	else
		vim.cmd("terminal")
		state.bufnr = vim.api.nvim_get_current_buf()
	end

	vim.bo[state.bufnr].buflisted = false
	vim.bo[state.bufnr].bufhidden = "hide"
	vim.bo[state.bufnr].filetype = "terminal"

	vim.api.nvim_set_current_win(state.winid)
	vim.cmd("startinsert")
	vim.api.nvim_set_current_win(current_win)
end

local function ensure_terminal(mode)
	state.last_size = mode or state.last_size

	if focus_terminal_window() then
		vim.api.nvim_win_set_height(state.winid, term_height(state.last_size))
		vim.cmd("startinsert")
		return
	end

	create_terminal_window(state.last_size)
end

function M.open_small()
	ensure_terminal("small")
end

function M.open_full()
	ensure_terminal("full")
end

function M.toggle_size()
	if not is_valid_win(state.winid) then
		ensure_terminal(state.last_size == "full" and "small" or "full")
		return
	end

	if vim.api.nvim_win_get_height(state.winid) <= 15 then
		state.last_size = "full"
	else
		state.last_size = "small"
	end

	vim.api.nvim_win_set_height(state.winid, term_height(state.last_size))
	vim.api.nvim_set_current_win(state.winid)
	vim.cmd("startinsert")
end

function M.kill_current()
	if is_valid_buf(state.bufnr) then
		vim.api.nvim_buf_delete(state.bufnr, { force = true })
	end

	state.bufnr = nil
	state.winid = nil
end

function M.close_without_killing()
	if is_valid_win(state.winid) then
		vim.api.nvim_win_close(state.winid, true)
		state.winid = nil
	end
end

function M.toggle_hide()
	if is_valid_win(state.winid) then
		vim.api.nvim_win_close(state.winid, true)
		state.winid = nil
		return
	end

	ensure_terminal(state.last_size)
	if is_valid_win(state.winid) then
		vim.api.nvim_set_current_win(state.winid)
		vim.cmd("startinsert")
	end
end

return M
