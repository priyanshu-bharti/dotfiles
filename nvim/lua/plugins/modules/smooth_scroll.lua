return {
	"karb94/neoscroll.nvim",
	opts = {
		hide_cursor = true,
	},
	config = function(_, opts)
		local neoscroll = require("neoscroll")
		neoscroll.setup(opts)

		local keymap = {
			-- page-like motions
			["<C-u>"] = function()
				neoscroll.ctrl_u({ duration = 120 })
			end,
			["<C-d>"] = function()
				neoscroll.ctrl_d({ duration = 120 })
			end,
			["<C-b>"] = function()
				neoscroll.ctrl_b({ duration = 200 })
			end,
			["<C-f>"] = function()
				neoscroll.ctrl_f({ duration = 200 })
			end,
		}

		local modes = { "n", "v", "x" }
		for key, fn in pairs(keymap) do
			vim.keymap.set(modes, key, fn, { silent = true, noremap = true })
		end
	end,
}
