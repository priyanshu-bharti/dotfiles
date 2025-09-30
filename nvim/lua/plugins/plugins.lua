local plugins = {
	require("plugins.modules.treesitter"), -- Syntax highlighting
	require("plugins.modules.neotree"), -- Neo Tree for File Explorer Sidebar
	require("plugins.modules.theme"), -- Tokyonight Color Theme
	require("plugins.modules.bufferline"), -- Bufferline
	require("plugins.modules.lualine"), -- Status Bar
	require("plugins.modules.telescope"), -- File Finder
	require("plugins.modules.lsp"), -- Main LSP configuration
	require("plugins.modules.autocomplete"), -- Autocompletions
	require("plugins.modules.autoformatting"), -- Autoformatting
	require("plugins.modules.gitsigns"), -- Git status signs on lines
	require("plugins.modules.homepage"), -- Display a welcome page
	require("plugins.modules.agent"), -- Integrated AI agent
	require("plugins.modules.comments"), -- Comment utilities
	require("plugins.modules.database"), -- Database UI
	require("plugins.modules.indent_guides"), -- Indent Guides
	require("plugins.modules.tmux_navigator"), -- TMUX navigation with VIM
	require("plugins.modules.cheatsheet"), -- Cheatsheet for viewing all keymaps
	require("plugins.modules.noice"), -- Better UI for messages, cmdline and popups
	require("plugins.modules.smooth_scroll"), -- Smooth Scrolling
	require("plugins.modules.misc"), -- Miscellaneous small plugins
}

return plugins
