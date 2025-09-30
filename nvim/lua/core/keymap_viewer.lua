-- Custom keymap viewer - displays all keymaps in a popup like NvChad
local M = {}

-- Define all keymaps organized by category
M.keymaps = {
	{
		title = "🔍 Search & Find",
		keymaps = {
			{ key = "<leader>sf", desc = "Search files" },
			{ key = "<leader>sg", desc = "Live grep" },
			{ key = "<leader>sw", desc = "Search word under cursor" },
			{ key = "<leader>sb", desc = "Search buffers" },
			{ key = "<leader>sh", desc = "Search help" },
			{ key = "<leader>so", desc = "Search old files" },
			{ key = "<leader>sm", desc = "Search marks" },
			{ key = "<leader>sd", desc = "Search diagnostics" },
			{ key = "<leader>sr", desc = "Resume search" },
			{ key = "<leader>sds", desc = "Document symbols" },
			{ key = "<leader>s/", desc = "Search in open files" },
			{ key = "<leader>/", desc = "Search current buffer" },
		},
	},
	{
		title = "📁 File & Buffer",
		keymaps = {
			{ key = "<C-s>", desc = "Save file" },
			{ key = "<C-q>", desc = "Quit window" },
			{ key = "<Tab>", desc = "Next buffer" },
			{ key = "<S-Tab>", desc = "Previous buffer" },
			{ key = "<leader>xx", desc = "Close buffer" },
			{ key = "<leader>nn", desc = "New buffer" },
			{ key = "\\", desc = "Toggle file explorer" },
		},
	},
	{
		title = "🌿 Git Operations",
		keymaps = {
			{ key = "<leader>gf", desc = "Git files" },
			{ key = "<leader>gc", desc = "Git commits" },
			{ key = "<leader>gcf", desc = "Git commits (file)" },
			{ key = "<leader>gb", desc = "Git branches" },
			{ key = "<leader>gs", desc = "Git status" },
		},
	},
	{
		title = "💻 Code & LSP",
		keymaps = {
			{ key = "gd", desc = "Go to definition" },
			{ key = "gr", desc = "Go to references" },
			{ key = "gI", desc = "Go to implementation" },
			{ key = "gD", desc = "Go to declaration" },
			{ key = "K", desc = "Hover documentation" },
			{ key = "<leader>ca", desc = "Code action" },
			{ key = "<leader>rn", desc = "Rename symbol" },
			{ key = "<leader>D", desc = "Type definition" },
			{ key = "<leader>ds", desc = "Document symbols" },
			{ key = "<leader>ws", desc = "Workspace symbols" },
		},
	},
	{
		title = "⚠️ Diagnostics",
		keymaps = {
			{ key = "[d", desc = "Previous diagnostic" },
			{ key = "]d", desc = "Next diagnostic" },
			{ key = "<leader>d", desc = "Show diagnostic" },
			{ key = "<leader>q", desc = "Diagnostics list" },
			{ key = "<leader>do", desc = "Toggle diagnostics" },
		},
	},
	{
		title = "🪟 Window & Splits",
		keymaps = {
			{ key = "<leader>v", desc = "Split vertically" },
			{ key = "<leader>h", desc = "Split horizontally" },
			{ key = "<leader>se", desc = "Equal splits" },
			{ key = "<leader>xs", desc = "Close split" },
			{ key = "<C-h/j/k/l>", desc = "Navigate splits" },
			{ key = "Arrow Keys", desc = "Resize windows" },
		},
	},
	{
		title = "📑 Tabs",
		keymaps = {
			{ key = "<leader>to", desc = "Open new tab" },
			{ key = "<leader>tx", desc = "Close tab" },
			{ key = "<leader>tn", desc = "Next tab" },
			{ key = "<leader>tp", desc = "Previous tab" },
		},
	},
	{
		title = "📝 Text Editing",
		keymaps = {
			{ key = "<C-_>/<C-c>", desc = "Toggle comment" },
			{ key = "</>", desc = "Indent left/right" },
			{ key = "<M-j>/<M-k>", desc = "Move line up/down" },
			{ key = "<leader>y", desc = "Yank to clipboard" },
			{ key = "<leader>lw", desc = "Toggle line wrap" },
		},
	},
	{
		title = "🤖 AI Agent",
		keymaps = {
			{ key = "<leader>aig", desc = "Toggle Gemini CLI" },
			{ key = "<leader>aix", desc = "Close Gemini CLI" },
			{ key = "<leader>aia", desc = "Accept suggestions" },
			{ key = "<leader>aii", desc = "Reject suggestions" },
			{ key = "<leader>aidf", desc = "Send file diagnostics" },
			{ key = "<leader>aidl", desc = "Send line diagnostics" },
			{ key = "<leader>aif", desc = "Switch sidebar style" },
		},
	},
	{
		title = "🔧 Utilities",
		keymaps = {
			{ key = "<Esc>", desc = "Clear highlights" },
			{ key = "<leader>bg", desc = "Toggle theme" },
			{ key = "<leader>ss", desc = "Save session" },
			{ key = "<leader>sl", desc = "Load session" },
			{ key = "<leader>?", desc = "Cheatsheet" },
			{ key = "<leader>km", desc = "Keymap reference" },
		},
	},
}

-- Create the popup display
function M.show_keymaps()
	local buf = vim.api.nvim_create_buf(false, true)
	
	-- Calculate window dimensions
	local width = 100
	local height = 30
	local row = math.ceil((vim.o.lines - height) / 2)
	local col = math.ceil((vim.o.columns - width) / 2)
	
	-- Window options
	local opts = {
		style = "minimal",
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		border = "rounded",
		title = " ⌨️  Keymap Reference ",
		title_pos = "center",
	}
	
	-- Create the window
	local win = vim.api.nvim_open_win(buf, true, opts)
	
	-- Set buffer options
	vim.api.nvim_buf_set_option(buf, "modifiable", true)
	vim.api.nvim_buf_set_option(buf, "readonly", false)
	
	-- Generate content
	local lines = {}
	
	-- Add header
	table.insert(lines, "")
	table.insert(lines, "🚀 Neovim Keymap Reference - Press 'q' to close")
	table.insert(lines, string.rep("─", width - 4))
	table.insert(lines, "")
	
	-- Add each category
	for _, category in ipairs(M.keymaps) do
		-- Category header
		table.insert(lines, "┌─ " .. category.title .. " " .. string.rep("─", width - 8 - vim.fn.strwidth(category.title)))
		
		-- Add keymaps in two columns
		for i = 1, #category.keymaps, 2 do
			local left_keymap = category.keymaps[i]
			local right_keymap = category.keymaps[i + 1]
			
			local left_part = ""
			if left_keymap then
				left_part = string.format("│ %-18s %s", left_keymap.key, left_keymap.desc)
			end
			
			local right_part = ""
			if right_keymap then
				right_part = string.format("%-18s %s", right_keymap.key, right_keymap.desc)
			end
			
			-- Calculate padding
			local left_len = vim.fn.strwidth(left_part)
			local mid_col = math.floor(width / 2)
			local padding = string.rep(" ", math.max(1, mid_col - left_len))
			
			local line = left_part .. padding .. right_part
			-- Ensure line doesn't exceed width
			if vim.fn.strwidth(line) > width - 2 then
				line = string.sub(line, 1, width - 5) .. "..."
			end
			
			table.insert(lines, line)
		end
		
		table.insert(lines, "")
	end
	
	-- Add footer
	table.insert(lines, string.rep("─", width - 4))
	table.insert(lines, "Press 'q' or <Esc> to close")
	table.insert(lines, "")
	
	-- Set buffer content
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_option(buf, "readonly", true)
	
	-- Set buffer keymaps to close
	local close_popup = function()
		vim.api.nvim_win_close(win, true)
	end
	
	vim.keymap.set("n", "q", close_popup, { buffer = buf, nowait = true })
	vim.keymap.set("n", "<Esc>", close_popup, { buffer = buf, nowait = true })
	
	-- Set highlight groups for better appearance
	vim.api.nvim_win_set_option(win, "winhl", "Normal:Normal,FloatBorder:FloatBorder")
end

return M