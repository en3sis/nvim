vim.opt.guicursor = ""
vim.clipboard = 'unnamedplus'
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true
vim.opt.linebreak = true
-- vim.opt.winblend = 20
-- set transparent background to floating windows
--vim.api.nvim_set_hl(1, "NormalFloat", { bg = "black" })
-- set border for floating windows
--vim.api.nvim_set_option("winhighlight", "NormalFloat:Normal")

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "90"

-- Enable highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end
})
