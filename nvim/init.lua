-- Properly Map the Leader Key --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true

--------------------
-- MODULE IMPORTS --
--------------------
require("core.options")
require("core.keymaps")

--------------------------------------
-- CONFIGURTING LAZY PLUGIN MANAGER --
--------------------------------------
-- Install the plugin manager in the following directory
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Get the lazy nvim plugin
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

-- Register the Plugin Manager
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

--------------------
-- IMPORT PLUGINS --
--------------------
-- Import the plugins table
local plugins = require("plugins.plugins")
-- Calls the setup method to setup all the plugins we put in the table passed as argument.
require("lazy").setup(plugins)
