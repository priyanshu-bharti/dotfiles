-- Cheatsheet for viewing all keymaps
return {
	"sudormrfbin/cheatsheet.nvim",
	dependencies = {
		{ "nvim-telescope/telescope.nvim" },
		{ "nvim-lua/popup.nvim" },
		{ "nvim-lua/plenary.nvim" },
	},
	config = function()
		-- Load custom cheatsheet configuration
		local custom_cheatsheets = require("core.cheatsheet_config").cheatsheets
		
		require("cheatsheet").setup({
			-- Whether to show bundled cheatsheets
			bundled_cheatsheets = {
				enabled = { "default", "lua", "markdown", "regex", "netrw", "unicode" },
				disabled = { "nerd-fonts" },
			},
			bundled_plugin_cheatsheets = {
				enabled = {
					"auto-session",
					"goto-preview",
					"octo.nvim",
					"telescope.nvim",
					"vim-easy-align",
					"vim-sandwich",
				},
				disabled = { "gitsigns" },
			},
			include_only_installed_plugins = true,
			-- Key mappings for the cheatsheet buffer
			telescope_mappings = {
				["<CR>"] = require("cheatsheet.telescope.actions").select_or_fill_commandline,
				["<A-CR>"] = require("cheatsheet.telescope.actions").select_or_execute,
				["<C-Y>"] = require("cheatsheet.telescope.actions").copy_cheat_value,
				["<C-E>"] = require("cheatsheet.telescope.actions").edit_user_cheatsheet,
			},
		})
		
		-- Add custom cheatsheets
		for _, cheatsheet in ipairs(custom_cheatsheets) do
			require("cheatsheet").add_cheat(cheatsheet.name, cheatsheet.sections)
		end
	end,
}