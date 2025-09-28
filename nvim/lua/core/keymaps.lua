-- So that we don't have to repeat ourselves
local opts = { noremap = true, silent = true }

---------------------
-- BETTER DEFAULTS --
---------------------

-- Disable the spacebar's default behavior in normal and visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- clear highlights
vim.keymap.set("n", "<Esc>", ":noh<CR>", opts)

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Explicitly yank to system clipboard (highlighted and entire row)
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

----------------
-- KEY REMAPS --
----------------

-- Helper to create a keymap and define which key with descriptions
local function keymap(mode, key, cmd, desc)
	vim.keymap.set(mode, key, cmd, opts)
end

-- Define custom keymaps here

-- Saving the file
keymap("n", "<C-s>", "<cmd> w <CR>", "[S]ave File")
keymap("n", "<C-S>", "<cmd> w <CR>", "[S]ave without Format")

-- Windows
keymap("n", "<C-q>", "<cmd> q <CR>", "[Q]uit")

-- Buffers
keymap("n", "<leader>xx", ":Bdelete!<CR>", "Close Buffer")
keymap("n", "<leader>nn", "<cmd> enew <CR>", "New Buffer")
keymap("n", "<Tab>", ":bnext<CR>", "Move to next Buffer")
keymap("n", "<S-Tab>", ":bprevious<CR>", "Move to previous Buffer")
keymap("n", "<C-i>", "<C-i>", "Restore Jump Forward")

-- Resizing Windows
keymap("n", "<Up>", ":resize -2<CR>", "Shrink Vertically")
keymap("n", "<Down>", ":resize +2<CR>", "Expand Vertically")
keymap("n", "<Left>", ":vertical resize -2<CR>", "Shrink Horizontally")
keymap("n", "<Right>", ":vertical resize +2<CR>", "Expand Horizontally")

-- Window management
keymap("n", "<leader>v", "<C-w>v", "Split Window Vertically")
keymap("n", "<leader>h", "<C-w>s", "Split Window Horizontally")
keymap("n", "<leader>se", "<C-w>=", "Split Equally")
keymap("n", "<leader>xs", ":close<CR>", "Close Split")

--Navigating between Window Splits
keymap("n", "<C-k>", ":wincmd k<CR>", "Move to Bottom")
keymap("n", "<C-j>", ":wincmd j<CR>", "Move to Top")
keymap("n", "<C-h>", ":wincmd h<CR>", "Move to Left")
keymap("n", "<C-l>", ":wincmd l<CR>", "Move to Right")

-- Tabs
keymap("n", "<leader>to", ":tabnew<CR>", "[T]ab [O]pen")
keymap("n", "<leader>tx", ":tabclose<CR>", "[T]ab [X] Close")
keymap("n", "<leader>tn", ":tabn<CR>", "[T]ab [N]ext")
keymap("n", "<leader>tp", ":tabp<CR>", "[T]ab [P]revious")

-- Toggle line wrapping
keymap("n", "<leader>lw", "<cmd>set wrap!<CR>", "Toggle [L]ine [W]rap")

-- Move text up and down
keymap("v", "<M-j>", ":m .+1<CR>==", "Move text Down")
keymap("v", "<M-k>", ":m .-2<CR>==", "Move text Up")
keymap("n", "<M-j>", ":m .+1<CR>==", "Move text Down")
keymap("n", "<M-k>", ":m .-2<CR>==", "Move text Up")

-- Neotree
keymap("n", "\\", ":Neotree toggle<CR>", "Toggle Neotree Sidebar")
keymap("n", "<leader>bg", "<cmd>lua toggle_bg()<CR>", "Toggle Theme [BG]")

-- Toggle diagnostics
local diagnostics_active = true

vim.keymap.set("n", "<leader>do", function()
	diagnostics_active = not diagnostics_active

	if diagnostics_active then
		vim.diagnostic.enable(true)
	else
		vim.diagnostic.enable(false)
	end
end)

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic message" })

vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic message" })

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Save and load session
vim.keymap.set("n", "<leader>ss", ":mksession! .session.vim<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>sl", ":source .session.vim<CR>", { noremap = true, silent = false })
