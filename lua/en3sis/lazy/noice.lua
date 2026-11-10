return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim" },
  init = function()
    vim.opt.wildmode = "noselect:lastused,full"
    vim.opt.wildoptions = "pum,fuzzy"

    vim.api.nvim_create_autocmd("CmdlineChanged", {
      pattern = ":",
      callback = function() vim.fn.wildtrigger() end,
    })

    local function pick(next_key, history_key)
      return function()
        return vim.fn.wildmenumode() == 1 and next_key or history_key
      end
    end
    vim.keymap.set("c", "<Down>", pick("<C-n>", "<Down>"), { expr = true })
    vim.keymap.set("c", "<Up>", pick("<C-p>", "<Up>"), { expr = true })
  end,
  config = function(_, opts)
    require("noice").setup(opts)
    vim.api.nvim_create_autocmd("CmdlineEnter", {
      callback = function()
        local views = require("noice.config").options.views
        if not views then return end
        views.cmdline_popupmenu.size.width = math.floor(vim.o.columns * 0.6)
      end,
    })
  end,
  opts = {
    cmdline = {
      view = "cmdline_popup",
      format = {
        cmdline = { icon = "❯", title = "" },
        search_down = { icon = "↓", title = "" },
        search_up = { icon = "↑", title = "" },
        filter = { icon = "$", title = "" },
        lua = { icon = "", title = "" },
        help = { icon = "?", title = "" },
      },
    },
    popupmenu = { enabled = true, backend = "nui" },
    messages = { enabled = false },
    notify = { enabled = false },
    lsp = {
      progress = { enabled = false },
      hover = { enabled = false },
      signature = { enabled = false },
      message = { enabled = false },
    },
    views = {
      cmdline_popup = {
        position = { row = 4, col = "50%" },
        size = { width = "60%", height = "auto" },
        border = { style = "rounded", padding = { 0, 1 } },
      },
      cmdline_popupmenu = {
        relative = "editor",
        position = { row = 7, col = "50%" },
        size = { width = 72, height = "auto", max_height = 12 },
        border = { style = "rounded", padding = { 0, 1 } },
      },
    },
  },
}
