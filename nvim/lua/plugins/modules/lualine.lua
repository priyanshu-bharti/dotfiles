-- Set lualine as statusline
return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local hide_in_width = function()
            return vim.fn.winwidth(0) > 100
        end

        local mode = {
            "mode",
            fmt = function(str)
                if hide_in_width() then
                    return " " .. str
                else
                    return " " .. str:sub(1, 1) -- displays only the first character of the mode
                end
            end,
        }

        local filename = {
            "filename",
            file_status = true, -- displays file status (readonly status, modified status)
            path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
        }

        local diagnostics = {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            sections = { "error", "warn" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
            colored = false,
            update_in_insert = false,
            always_visible = false,
            cond = hide_in_width,
        }

        local diff = {
            "diff",
            colored = false,
            symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
            cond = hide_in_width,
        }

        local macro_recording = function()
            local reg = vim.fn.reg_recording()
            if reg == "" then
                return ""
            else
                return "󰑐 @" .. reg
            end
        end

        require("lualine").setup({
            options = {
                icons_enabled = true,
                -- Some useful glyphs:
                -- https://www.nerdfonts.com/cheat-sheet
                --        
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
                disabled_filetypes = { "alpha", "neo-tree", "Avante" },
                always_divide_middle = true,
            },
            sections = {
                lualine_a = { mode },
                lualine_b = { "branch" },
                lualine_c = { filename },
                lualine_x = {
                    diagnostics,
                    diff,
                    { "encoding", cond = hide_in_width },
                    { "filetype", cond = hide_in_width },
                },
                lualine_y = { macro_recording, "location" },
                lualine_z = { "progress" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { "filename", path = 1 } },
                lualine_x = { { "location", padding = 0 } },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            extensions = { "fugitive" },
        })

        -- Set up autocmds to refresh lualine when macro recording starts/stops
        local macro_group = vim.api.nvim_create_augroup("MacroRecording", { clear = true })
        vim.api.nvim_create_autocmd("RecordingEnter", {
            group = macro_group,
            callback = function()
                require("lualine").refresh()
            end,
        })
        vim.api.nvim_create_autocmd("RecordingLeave", {
            group = macro_group,
            callback = function()
                require("lualine").refresh()
            end,
        })
    end
}