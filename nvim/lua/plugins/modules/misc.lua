-- Standalone plugins with less than 10 lines of config go here
return {
	{ "nvim-java/nvim-java" },
	{ "mfussenegger/nvim-jdtls" },
	{ "sphamba/smear-cursor.nvim", opts = {} },
	{ "karb94/neoscroll.nvim", opts = {} },
	{
		"nvzone/typr",
		dependencies = "nvzone/volt",
		opts = {},
		cmd = { "Typr", "TyprStats" },
	},
	{
		"kylechui/nvim-surround",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{ "windwp/nvim-ts-autotag" },
	{ "tpope/vim-sleuth" },
	{ "tpope/vim-fugitive" },
	{ "tpope/vim-rhubarb" },
	{
		-- Hints keybinds
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local wk = require("which-key")
			wk.setup({
				delay = 1500, -- delay before which-key opens (in milliseconds)
				icons = {
					breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
					separator = "➜", -- symbol used between a key and it's label
					group = "+", -- symbol prepended to a group
				},
				win = {
					border = "rounded", -- none, single, double, shadow, rounded
					padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
				},
			})
		end,
	},
	{
		-- Autoclose parentheses, brackets, quotes, etc.
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	},
	{
		-- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		-- high-performance color highlighter
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
}
