vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
vim.pack.add { { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } }

require("lazy").setup({
    {
        "stevearc/oil.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("oil").setup({
                default_file_explorer = true,

                view_options = {
                    show_hidden = true,
                },

                columns = {
                    "icon",
                    "permissions",
                    "size",
                    "mtime",
                },

                float = {
                    padding = 2,
                    max_width = 100,
                    max_height = 30,
                    border = "rounded",
                    win_options = {
                        winblend = 5,
                    },
                },
            })

            vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", {
                desc = "Open file explorer",
            })
        end,
    },
})

-- Matugen + Hyprglass Neovim
-- ~/.config/nvim/init.lua

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.wrap = false
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

-- Clean UI
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.cmdheight = 0

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Cursor
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20"

-- Load Matugen colors
local matugen = dofile(vim.fn.expand("~/.config/hypr/matugen-colors.lua"))

local bg = matugen.background
local fg = matugen.foreground
local accent = matugen.accent
local accent2 = matugen.accent2

-- Editor
vim.api.nvim_set_hl(0, "Normal", {
    fg = fg,
    bg = bg,
})

vim.api.nvim_set_hl(0, "NormalFloat", {
    fg = fg,
    bg = bg,
})

vim.api.nvim_set_hl(0, "FloatBorder", {
    fg = accent,
    bg = bg,
})

vim.api.nvim_set_hl(0, "CursorLine", {
    bg = bg,
})

vim.api.nvim_set_hl(0, "CursorLineNr", {
    fg = accent,
    bold = true,
})

vim.api.nvim_set_hl(0, "LineNr", {
    fg = accent2,
})

vim.api.nvim_set_hl(0, "Visual", {
    bg = accent,
})

vim.api.nvim_set_hl(0, "Search", {
    fg = bg,
    bg = accent,
})

vim.api.nvim_set_hl(0, "IncSearch", {
    fg = bg,
    bg = accent,
})

-- Window separators
vim.api.nvim_set_hl(0, "WinSeparator", {
    fg = accent,
})

-- Popup menus
vim.api.nvim_set_hl(0, "Pmenu", {
    fg = fg,
    bg = bg,
})

vim.api.nvim_set_hl(0, "PmenuSel", {
    fg = bg,
    bg = accent,
})

-- Diagnostics
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    float = {
        border = "rounded",
    },
})

-- Rounded floating windows
vim.api.nvim_create_autocmd("WinNew", {
    callback = function()
        local win = vim.api.nvim_get_current_win()

        if vim.api.nvim_win_get_config(win).relative ~= "" then
            vim.wo[win].winhighlight =
                "Normal:NormalFloat,FloatBorder:FloatBorder"
        end
    end,
})
