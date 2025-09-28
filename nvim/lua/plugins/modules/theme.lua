local M = {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "moon",
		transparent = true,
		terminal_colors = true,
	},
}

local current_style = M.opts.style

function M.config(_, opts)
	local tokyonight = require("tokyonight")

	tokyonight.setup(opts)
	vim.cmd.colorscheme("tokyonight")

	local transparency = opts.transparent or true -- initialize with opts value

	_G.toggle_bg = function()
		transparency = not transparency -- toggle transparency state
		opts.transparent = transparency -- update opts accordingly

		tokyonight.setup(opts)
		vim.cmd.colorscheme("tokyonight")

		print("TokyoNight transparency toggled: " .. tostring(transparency))
	end
end

return M
