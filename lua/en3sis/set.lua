-- Set cursor style
vim.opt.guicursor = ""
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Use system clipboard
vim.clipboard = 'unnamedplus'

-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Tab and indentation settings
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = false
-- Line wrapping
vim.opt.wrap = true
vim.opt.linebreak = true

-- Transparency for floating windows (uncomment if needed)
-- vim.opt.winblend = 20
-- vim.api.nvim_set_hl(1, "NormalFloat", { bg = "black" })
-- vim.api.nvim_set_option("winhighlight", "NormalFloat:Normal")

-- Disable swap and backup files, set undo directory
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Search settings
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Enable 24-bit RGB colors
vim.opt.termguicolors = true

-- Scrolling and sign column settings
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Reduce update time for better performance
vim.opt.updatetime = 50

-- Highlight column at specified position
vim.opt.colorcolumn = "90"

-- Highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end
})

