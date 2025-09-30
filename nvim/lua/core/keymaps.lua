-- So that we don't have to repeat ourselves
local opts = { noremap = true, silent = true }

---------------------
-- BETTER DEFAULTS --
---------------------

-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Move up (wrapped lines)" })
vim.keymap.set(
	"n",
	"j",
	"v:count == 0 ? 'gj' : 'j'",
	{ expr = true, silent = true, desc = "Move down (wrapped lines)" }
)

-- clear highlights
vim.keymap.set("n", "<Esc>", ":noh<CR>", { noremap = true, silent = true, desc = "Clear search highlights" })

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true, desc = "Delete character (no register)" })

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true, desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true, desc = "Scroll up and center" })

-- Find and center
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', { noremap = true, silent = true, desc = "Paste without losing register" })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true, desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true, desc = "Indent right and reselect" })

-- Explicitly yank to system clipboard (highlighted and entire row)
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })

----------------
-- KEY REMAPS --
----------------

-----------------------
-- PLUGIN KEYMAPS   --
-----------------------

-- Setup which-key groups and plugin keymaps
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- Load telescope and set up keymaps
		local telescope_builtin = require("telescope.builtin")

		-- Buffer and file search
		vim.keymap.set("n", "<leader>sb", telescope_builtin.buffers, { desc = "Search existing buffers" })
		vim.keymap.set("n", "<leader><tab>", telescope_builtin.buffers, { desc = "Search existing buffers" })
		vim.keymap.set("n", "<leader><leader>", telescope_builtin.buffers, { desc = "Find existing buffers" })
		vim.keymap.set("n", "<leader>sf", telescope_builtin.find_files, { desc = "Search files" })
		vim.keymap.set("n", "<leader>so", telescope_builtin.oldfiles, { desc = "Search recent files" })
		vim.keymap.set("n", "<leader>sm", telescope_builtin.marks, { desc = "Search marks" })

		-- Git searches
		vim.keymap.set("n", "<leader>gf", telescope_builtin.git_files, { desc = "Git files" })
		vim.keymap.set("n", "<leader>gc", telescope_builtin.git_commits, { desc = "Git commits" })
		vim.keymap.set("n", "<leader>gcf", telescope_builtin.git_bcommits, { desc = "Git commits for current file" })
		vim.keymap.set("n", "<leader>gb", telescope_builtin.git_branches, { desc = "Git branches" })
		vim.keymap.set("n", "<leader>gs", telescope_builtin.git_status, { desc = "Git status (diff view)" })

		-- Text searches
		vim.keymap.set("n", "<leader>sh", telescope_builtin.help_tags, { desc = "Search help" })
		vim.keymap.set("n", "<leader>sw", telescope_builtin.grep_string, { desc = "Search current word" })
		vim.keymap.set("n", "<leader>sg", telescope_builtin.live_grep, { desc = "Search by grep" })
		vim.keymap.set("n", "<leader>sd", telescope_builtin.diagnostics, { desc = "Search diagnostics" })
		vim.keymap.set("n", "<leader>sr", telescope_builtin.resume, { desc = "Search resume" })

		-- Advanced searches
		vim.keymap.set("n", "<leader>sds", function()
			telescope_builtin.lsp_document_symbols({
				symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Property" },
			})
		end, { desc = "Search LSP document symbols" })

		vim.keymap.set("n", "<leader>s/", function()
			telescope_builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "Search in open files" })

		vim.keymap.set("n", "<leader>/", function()
			telescope_builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				previewer = false,
			}))
		end, { desc = "Fuzzily search in current buffer" })

		-- Comment keymaps
		vim.keymap.set("n", "<C-_>", function()
			require("Comment.api").toggle.linewise.current()
		end, { desc = "Toggle line comment" })
		vim.keymap.set("n", "<C-c>", function()
			require("Comment.api").toggle.linewise.current()
		end, { desc = "Toggle line comment" })
		vim.keymap.set("n", "<C-/>", function()
			require("Comment.api").toggle.linewise.current()
		end, { desc = "Toggle line comment" })
		vim.keymap.set(
			"v",
			"<C-_>",
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
			{ desc = "Toggle line comment" }
		)
		vim.keymap.set(
			"v",
			"<C-c>",
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
			{ desc = "Toggle line comment" }
		)
		vim.keymap.set(
			"v",
			"<C-/>",
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
			{ desc = "Toggle line comment" }
		)

		-- Session management keymaps
		vim.keymap.set("n", "<leader>pf", "<cmd>AutoSession search<CR>", { desc = "Project find session" })
		vim.keymap.set("n", "<leader>ps", "<cmd>AutoSession save<CR>", { desc = "Project save session" })
		vim.keymap.set("n", "<leader>pa", "<cmd>AutoSession toggle<CR>", { desc = "Project autosave toggle" })
		vim.keymap.set("n", "<leader>pd", function()
			-- This will be available in the telescope picker
			vim.notify("Use <leader>pf to open session picker, then use <leader>pd to delete", vim.log.levels.INFO)
		end, { desc = "Project delete session (via picker)" })
		vim.keymap.set("n", "<leader>pc", function()
			-- This will be available in the telescope picker
			vim.notify("Use <leader>pf to open session picker, then use <leader>pc to copy", vim.log.levels.INFO)
		end, { desc = "Project copy session (via picker)" })

		-- LSP keymaps (moved from lsp.lua)
		-- These are set up via LspAttach autocmd but we define them here for reference
		-- Actual setup happens in the LSP config, but this helps with documentation
		local function setup_lsp_keymaps()
			-- Navigation
			vim.keymap.set("n", "gd", function()
				require("telescope.builtin").lsp_definitions()
			end, { desc = "LSP: Goto definition" })
			vim.keymap.set("n", "gr", function()
				require("telescope.builtin").lsp_references()
			end, { desc = "LSP: Goto references" })
			vim.keymap.set("n", "gI", function()
				require("telescope.builtin").lsp_implementations()
			end, { desc = "LSP: Goto implementation" })
			vim.keymap.set("n", "gD", function()
				vim.lsp.buf.declaration()
			end, { desc = "LSP: Goto declaration" })
			vim.keymap.set("n", "<leader>D", function()
				require("telescope.builtin").lsp_type_definitions()
			end, { desc = "LSP: Type definition" })

			-- Documentation and help
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, { desc = "LSP: Hover documentation" })

			-- Symbols and workspace
			vim.keymap.set("n", "<leader>ds", function()
				require("telescope.builtin").lsp_document_symbols()
			end, { desc = "LSP: Document symbols" })
			vim.keymap.set("n", "<leader>ws", function()
				require("telescope.builtin").lsp_dynamic_workspace_symbols()
			end, { desc = "LSP: Workspace symbols" })

			-- Code actions and refactoring
			vim.keymap.set("n", "<leader>rn", function()
				vim.lsp.buf.rename()
			end, { desc = "LSP: Rename symbol" })
			vim.keymap.set("n", "<leader>ca", function()
				vim.lsp.buf.code_action()
			end, { desc = "LSP: Code action" })

			-- Workspace management
			-- vim.keymap.set("n", "<leader>wa", function() vim.lsp.buf.add_workspace_folder() end, { desc = "LSP: Workspace add folder" })
			-- vim.keymap.set("n", "<leader>wr", function() vim.lsp.buf.remove_workspace_folder() end, { desc = "LSP: Workspace remove folder" })
			-- vim.keymap.set("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { desc = "LSP: Workspace list folders" })

			-- Toggle features
			vim.keymap.set("n", "<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }))
			end, { desc = "LSP: Toggle inlay hints" })
		end

		-- Note: LSP keymaps are actually set in the LspAttach autocmd for buffer-local mapping

		-- Setup which-key groups
		local wk = require("which-key")

		-- Register key groups
		wk.add({
			{ "<leader>s", group = "Search" },
			{ "<leader>g", group = "Git" },
			{ "<leader>t", group = "Tabs/Toggle" },
			{ "<leader>x", group = "Close/Exit" },
			{ "<leader>w", group = "Workspace" },
			{ "<leader>c", group = "Code" },
			{ "<leader>d", group = "Diagnostics/Definition" },
			{ "<leader>r", group = "Rename/Refactor" },
			{ "<leader>l", group = "Line" },
			{ "<leader>n", group = "New" },
			{ "<leader>b", group = "Background/Buffer" },
			{ "<leader>p", group = "Project/Session" },
			{ "<leader>th", desc = "Toggle inlay hints" },
		})
	end,
})

-- Comment keymaps (wrapped in a function to ensure Comment is loaded)
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.keymap.set("n", "<C-_>", function()
			require("Comment.api").toggle.linewise.current()
		end, { desc = "Toggle line comment" })
		vim.keymap.set("n", "<C-c>", function()
			require("Comment.api").toggle.linewise.current()
		end, { desc = "Toggle line comment" })
		vim.keymap.set("n", "<C-/>", function()
			require("Comment.api").toggle.linewise.current()
		end, { desc = "Toggle line comment" })
		vim.keymap.set(
			"v",
			"<C-_>",
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
			{ desc = "Toggle line comment" }
		)
		vim.keymap.set(
			"v",
			"<C-c>",
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
			{ desc = "Toggle line comment" }
		)
		vim.keymap.set(
			"v",
			"<C-/>",
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
			{ desc = "Toggle line comment" }
		)
	end,
})

-- AI Agent keymaps (Gemini)
vim.keymap.set("n", "<leader>aig", "<cmd>GeminiToggle<cr>", { desc = "Toggle Gemini CLI" })
vim.keymap.set("n", "<leader>aix", "<cmd>GeminiClose<cr>", { desc = "Close Gemini CLI process" })
vim.keymap.set("n", "<leader>aia", "<cmd>GeminiAccept<cr>", { desc = "Accept Gemini suggested changes" })
vim.keymap.set("n", "<leader>aii", "<cmd>GeminiReject<cr>", { desc = "Reject Gemini suggested changes" })
vim.keymap.set("n", "<leader>aidf", "<cmd>GeminiSendFileDiagnostic<cr>", { desc = "Send File Diagnostics" })
vim.keymap.set("n", "<leader>aidl", "<cmd>GeminiSendLineDiagnostic<cr>", { desc = "Send Line Diagnostics" })
vim.keymap.set("n", "<leader>aif", "<cmd>GeminiSwitchSidebarStyle<cr>", { desc = "Switch Sidebar Style" })

-------------------------
-- CUSTOM KEYMAPS     --
-------------------------

-- Saving the file
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", { noremap = true, silent = true, desc = "Save file" })
vim.keymap.set("n", "<C-S>", "<cmd> w <CR>", { noremap = true, silent = true, desc = "Save file without format" })

-- Windows
vim.keymap.set("n", "<C-q>", "<cmd> q <CR>", { noremap = true, silent = true, desc = "Quit window" })

-- Buffers
vim.keymap.set("n", "<leader>xx", ":Bdelete!<CR>", { noremap = true, silent = true, desc = "Close buffer" })
vim.keymap.set("n", "<leader>nn", "<cmd> enew <CR>", { noremap = true, silent = true, desc = "New buffer" })
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<C-i>", "<C-i>", { noremap = true, silent = true, desc = "Jump forward" })

-- Resizing Windows
vim.keymap.set("n", "<Up>", ":resize -2<CR>", { noremap = true, silent = true, desc = "Decrease window height" })
vim.keymap.set("n", "<Down>", ":resize +2<CR>", { noremap = true, silent = true, desc = "Increase window height" })
vim.keymap.set(
	"n",
	"<Left>",
	":vertical resize -2<CR>",
	{ noremap = true, silent = true, desc = "Decrease window width" }
)
vim.keymap.set(
	"n",
	"<Right>",
	":vertical resize +2<CR>",
	{ noremap = true, silent = true, desc = "Increase window width" }
)

-- Window management
vim.keymap.set("n", "<leader>v", "<C-w>v", { noremap = true, silent = true, desc = "Split window vertically" })
vim.keymap.set("n", "<leader>h", "<C-w>s", { noremap = true, silent = true, desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { noremap = true, silent = true, desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>xs", ":close<CR>", { noremap = true, silent = true, desc = "Close current split" })

--Navigating between Window Splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { noremap = true, silent = true, desc = "Move to window above" })
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { noremap = true, silent = true, desc = "Move to window below" })
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { noremap = true, silent = true, desc = "Move to window left" })
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { noremap = true, silent = true, desc = "Move to window right" })

-- Tabs
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", { noremap = true, silent = true, desc = "Open new tab" })
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", { noremap = true, silent = true, desc = "Close current tab" })
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", { noremap = true, silent = true, desc = "Go to next tab" })
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", { noremap = true, silent = true, desc = "Go to previous tab" })

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", { noremap = true, silent = true, desc = "Toggle line wrap" })

-- Move text up and down
vim.keymap.set("v", "<M-j>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move selection down" })
vim.keymap.set("v", "<M-k>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move selection up" })
vim.keymap.set("n", "<M-j>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move line down" })
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move line up" })

-- Neotree
vim.keymap.set("n", "\\", ":Neotree toggle<CR>", { noremap = true, silent = true, desc = "Toggle file explorer" })
vim.keymap.set(
	"n",
	"<leader>bg",
	"<cmd>lua toggle_bg()<CR>",
	{ noremap = true, silent = true, desc = "Toggle background theme" }
)

-- Cheatsheet
vim.keymap.set("n", "<leader>?", ":Cheatsheet<CR>", { noremap = true, silent = true, desc = "Open cheatsheet" })
vim.keymap.set("n", "<leader>ch", ":Cheatsheet<CR>", { noremap = true, silent = true, desc = "Open cheatsheet" })

-- Keymap viewer (NvChad-style)
vim.keymap.set("n", "<leader>km", function()
	require("core.keymap_viewer").show_keymaps()
end, { noremap = true, silent = true, desc = "Show keymap reference" })

vim.keymap.set("n", "<F1>", function()
	require("core.keymap_viewer").show_keymaps()
end, { noremap = true, silent = true, desc = "Show keymap reference" })

-- Toggle diagnostics
local diagnostics_active = true

vim.keymap.set("n", "<leader>do", function()
	diagnostics_active = not diagnostics_active

	if diagnostics_active then
		vim.diagnostic.enable(true)
	else
		vim.diagnostic.enable(false)
	end
end, { desc = "Toggle diagnostics" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic" })

vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic" })

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic in floating window" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Save and load session
vim.keymap.set(
	"n",
	"<leader>ss",
	":mksession! .session.vim<CR>",
	{ noremap = true, silent = false, desc = "Save session" }
)
vim.keymap.set("n", "<leader>sl", ":source .session.vim<CR>", { noremap = true, silent = false, desc = "Load session" })

-- Setup which-key groups
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local wk = require("which-key")

		-- Register key groups with simpler approach
		wk.add({
			{ "<leader>s", group = "Search" },
			{ "<leader>g", group = "Git" },
			{ "<leader>t", group = "Tabs" },
			{ "<leader>x", group = "Close/Exit" },
			{ "<leader>w", group = "Workspace" },
			{ "<leader>c", group = "Code" },
			{ "<leader>d", group = "Diagnostics" },
			{ "<leader>r", group = "Rename" },
			{ "<leader>l", group = "Line" },
			{ "<leader>n", group = "New" },
			{ "<leader>b", group = "Background/Buffer" },
			{ "<leader>ch", group = "Cheatsheet" },
			{ "<leader>k", group = "Keymaps" },
			{ "<leader>a", group = "AI Agent" },
			{ "<leader>ai", group = "AI Operations" },
			{ "<leader>aid", group = "AI Diagnostics" },
		})

		-- Add a test keymap to verify which-key is working
		vim.keymap.set("n", "<leader>test", function()
			print("Which-key test successful!")
		end, { desc = "Test which-key functionality" })
	end,
})
