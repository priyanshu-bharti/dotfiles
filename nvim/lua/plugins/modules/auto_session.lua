return {
	"rmagatti/auto-session",
	lazy = false,
	opts = {
		suppressed_dirs = { "~/", "~/Developer/projects", "~/Downloads", "~/Developer/git" },
		session_lens = {
			picker = "telescope", -- "telescope"|"snacks"|"fzf"|"select"|nil Pickers are detected automatically but you can also set one manually. Falls back to vim.ui.select
			load_on_setup = true, -- Only used for telescope, registers the telescope extension at startup so you can use :Telescope session-lens
			picker_opts = nil, -- Table passed to Telescope / Snacks / Fzf-Lua to configure the picker. See below for more information
			mappings = {
				delete_session = { "i", "<leader>pd" }, -- mode and key for deleting a session from the picker
				alternate_session = { "i", "<leader>ps" }, -- mode and key for swapping to alternate session from the picker
				copy_session = { "i", "<leader>pc" }, -- mode and key for copying a session from the picker
			},
			session_control = {
				control_dir = vim.fn.stdpath("data") .. "/auto_session/", -- Auto session control dir, for control files, like alternating between two sessions with session-lens
				control_filename = "session_control.json", -- File name of the session control file
			},
		},
	},
}
