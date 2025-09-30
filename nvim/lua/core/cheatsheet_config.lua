-- Custom cheatsheet configuration for personal keymaps
local M = {}

-- Define custom cheatsheets for your specific configuration
M.cheatsheets = {
	{
		name = "🔭 Telescope Quick Reference",
		desc = "Quick reference for all Telescope operations",
		sections = {
			{
				name = "Essential Telescope Commands",
				cheats = {
					{ keys = "<leader>sf", desc = "🔍 Search Files - Find files in project" },
					{ keys = "<leader>sg", desc = "🔍 Live Grep - Search text in all files" },
					{ keys = "<leader>sw", desc = "🔍 Search Word - Find word under cursor" },
					{ keys = "<leader>sb", desc = "📂 Search Buffers - Find open buffers" },
					{ keys = "<leader>sh", desc = "❓ Search Help - Search help documentation" },
					{ keys = "<leader>so", desc = "📜 Recent Files - Search recently opened files" },
					{ keys = "<leader>/", desc = "🔍 Buffer Search - Search in current buffer" },
				}
			},
			{
				name = "Advanced Telescope Search",
				cheats = {
					{ keys = "<leader>sm", desc = "🔖 Search Marks - Find bookmarks/marks" },
					{ keys = "<leader>sd", desc = "⚠️  Search Diagnostics - Find errors/warnings" },
					{ keys = "<leader>sr", desc = "🔄 Resume Search - Resume last search" },
					{ keys = "<leader>sds", desc = "📋 Document Symbols - Find functions/classes in file" },
					{ keys = "<leader>s/", desc = "📂 Search Open Files - Grep in open buffers only" },
				}
			},
			{
				name = "Telescope Git Integration",
				cheats = {
					{ keys = "<leader>gf", desc = "📁 Git Files - Search git tracked files" },
					{ keys = "<leader>gc", desc = "📝 Git Commits - Browse commit history" },
					{ keys = "<leader>gcf", desc = "📝 File Commits - Commits for current file" },
					{ keys = "<leader>gb", desc = "🌿 Git Branches - Switch branches" },
					{ keys = "<leader>gs", desc = "📊 Git Status - View git status/changes" },
				}
			},
		}
	},
	{
		name = "Personal Keymaps",
		desc = "My custom Neovim keymaps",
		sections = {
			{
				name = "Movement & Navigation",
				cheats = {
					{ keys = "j/k", desc = "Move down/up (wrapped lines)" },
					{ keys = "n/N", desc = "Next/Previous search (centered)" },
					{ keys = "<C-d>/<C-u>", desc = "Scroll down/up and center" },
					{ keys = "<C-h/j/k/l>", desc = "Move between window splits" },
					{ keys = "\\", desc = "Toggle file explorer (Neotree)" },
				}
			},
			{
				name = "File & Buffer Operations",
				desc = "File and buffer management",
				cheats = {
					{ keys = "<C-s>", desc = "Save file" },
					{ keys = "<C-q>", desc = "Quit window" },
					{ keys = "<Tab>/<S-Tab>", desc = "Next/Previous buffer" },
					{ keys = "<leader>xx", desc = "Close current buffer" },
					{ keys = "<leader>nn", desc = "Create new buffer" },
				}
			},
			{
				name = "Telescope Search",
				desc = "Telescope search functionality - All file and content search operations",
				cheats = {
					{ keys = "<leader>sf", desc = "Search files (find_files)" },
					{ keys = "<leader>sg", desc = "Search by grep (live_grep)" },
					{ keys = "<leader>sw", desc = "Search word under cursor (grep_string)" },
					{ keys = "<leader>sb", desc = "Search buffers (buffers)" },
					{ keys = "<leader>sh", desc = "Search help tags (help_tags)" },
					{ keys = "<leader>so", desc = "Search old files (oldfiles)" },
					{ keys = "<leader>sm", desc = "Search marks (marks)" },
					{ keys = "<leader>sd", desc = "Search diagnostics (diagnostics)" },
					{ keys = "<leader>sr", desc = "Search resume (resume)" },
					{ keys = "<leader>sds", desc = "Search document symbols (lsp_document_symbols)" },
					{ keys = "<leader>s/", desc = "Search in open files (live_grep in open files)" },
					{ keys = "<leader>/", desc = "Search in current buffer (current_buffer_fuzzy_find)" },
					{ keys = "<leader><leader>", desc = "Find existing buffers (buffers)" },
					{ keys = "<leader><tab>", desc = "Search existing buffers (buffers)" },
				}
			},
			{
				name = "Telescope Git",
				desc = "Telescope Git-related search commands",
				cheats = {
					{ keys = "<leader>gf", desc = "Git files (git_files)" },
					{ keys = "<leader>gc", desc = "Git commits (git_commits)" },
					{ keys = "<leader>gcf", desc = "Git commits for current file (git_bcommits)" },
					{ keys = "<leader>gb", desc = "Git branches (git_branches)" },
					{ keys = "<leader>gs", desc = "Git status (git_status)" },
				}
			},
			{
				name = "🤖 AI Agent (Gemini)",
				desc = "AI-powered code assistance",
				cheats = {
					{ keys = "<leader>aig", desc = "🤖 Toggle Gemini CLI - Open/close AI assistant" },
					{ keys = "<leader>aix", desc = "❌ Close Gemini CLI - Terminate AI process" },
					{ keys = "<leader>aia", desc = "✅ Accept Changes - Apply AI suggestions" },
					{ keys = "<leader>aii", desc = "❌ Reject Changes - Dismiss AI suggestions" },
					{ keys = "<leader>aidf", desc = "📄 File Diagnostics - Send file issues to AI" },
					{ keys = "<leader>aidl", desc = "📏 Line Diagnostics - Send line issues to AI" },
					{ keys = "<leader>aif", desc = "🎨 Switch Style - Change sidebar appearance" },
				}
			},
			{
				name = "Code Operations",
				desc = "LSP and code-related functionality",
				cheats = {
					{ keys = "gd", desc = "Go to definition" },
					{ keys = "gr", desc = "Go to references" },
					{ keys = "gI", desc = "Go to implementation" },
					{ keys = "gD", desc = "Go to declaration" },
					{ keys = "K", desc = "Hover documentation" },
					{ keys = "<leader>ca", desc = "Code action" },
					{ keys = "<leader>rn", desc = "Rename symbol" },
					{ keys = "<leader>D", desc = "Type definition" },
					{ keys = "<leader>ds", desc = "Document symbols" },
					{ keys = "<leader>ws", desc = "Workspace symbols" },
				}
			},
			{
				name = "Diagnostics",
				desc = "Error and diagnostic navigation",
				cheats = {
					{ keys = "[d/]d", desc = "Previous/Next diagnostic" },
					{ keys = "<leader>d", desc = "Show diagnostic float" },
					{ keys = "<leader>q", desc = "Open diagnostics list" },
					{ keys = "<leader>do", desc = "Toggle diagnostics" },
				}
			},
			{
				name = "Comments",
				desc = "Code commenting",
				cheats = {
					{ keys = "<C-_>/<C-c>/<C-/>", desc = "Toggle line comment" },
					{ keys = "<C-_>/<C-c>/<C-/> (Visual)", desc = "Toggle block comment" },
				}
			},
			{
				name = "Window Management",
				desc = "Split and window operations",
				cheats = {
					{ keys = "<leader>v", desc = "Split window vertically" },
					{ keys = "<leader>h", desc = "Split window horizontally" },
					{ keys = "<leader>se", desc = "Make splits equal size" },
					{ keys = "<leader>xs", desc = "Close current split" },
					{ keys = "Arrow Keys", desc = "Resize windows" },
				}
			},
			{
				name = "Tab Management",
				desc = "Tab operations",
				cheats = {
					{ keys = "<leader>to", desc = "Open new tab" },
					{ keys = "<leader>tx", desc = "Close current tab" },
					{ keys = "<leader>tn", desc = "Go to next tab" },
					{ keys = "<leader>tp", desc = "Go to previous tab" },
				}
			},
			{
				name = "AI Agent Operations",
				desc = "Gemini AI assistant commands",
				cheats = {
					{ keys = "<leader>aig", desc = "Toggle Gemini CLI (GeminiToggle)" },
					{ keys = "<leader>aix", desc = "Close Gemini CLI process (GeminiClose)" },
					{ keys = "<leader>aia", desc = "Accept Gemini suggested changes (GeminiAccept)" },
					{ keys = "<leader>aii", desc = "Reject Gemini suggested changes (GeminiReject)" },
					{ keys = "<leader>aidf", desc = "Send file diagnostics to AI (GeminiSendFileDiagnostic)" },
					{ keys = "<leader>aidl", desc = "Send line diagnostics to AI (GeminiSendLineDiagnostic)" },
					{ keys = "<leader>aif", desc = "Switch sidebar style (GeminiSwitchSidebarStyle)" },
				}
			},
			{
				name = "Text Editing",
				desc = "Advanced text manipulation",
				cheats = {
					{ keys = "</>", desc = "Indent left/right (keep selection)" },
					{ keys = "<M-j>/<M-k>", desc = "Move line/selection up/down" },
					{ keys = "x", desc = "Delete character (no register)" },
					{ keys = "p (Visual)", desc = "Paste without losing register" },
					{ keys = "<leader>y/<leader>Y", desc = "Yank to system clipboard" },
				}
			},
			{
				name = "Session Management",
				desc = "Save and restore sessions",
				cheats = {
					{ keys = "<leader>ss", desc = "Save session" },
					{ keys = "<leader>sl", desc = "Load session" },
				}
			},
			{
				name = "Utilities",
				desc = "Miscellaneous utilities",
				cheats = {
					{ keys = "<Esc>", desc = "Clear search highlights" },
					{ keys = "<leader>lw", desc = "Toggle line wrap" },
					{ keys = "<leader>bg", desc = "Toggle background theme" },
					{ keys = "<leader>?/<leader>ch", desc = "Open cheatsheet" },
					{ keys = "<leader>km", desc = "Show keymap reference (NvChad-style)" },
					{ keys = "<F1>", desc = "Show keymap reference" },
					{ keys = "<leader>test", desc = "Test which-key functionality" },
				}
			},
		}
	}
}

return M