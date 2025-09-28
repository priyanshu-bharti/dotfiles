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
}

return plugins
