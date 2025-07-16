return {
  "github/copilot.vim",
  config = function()
    vim.g.copilot_no_tab_map = false -- Disable default <Tab> mapping
    -- vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    vim.g.copilot_filetypes = {
      ["*"] = true,         -- Enable for all filetypes
      -- ["markdown"] = false, -- Disable for Markdown
      -- ["vim"] = false,      -- Disable for Vim files
    }
  end,
}
