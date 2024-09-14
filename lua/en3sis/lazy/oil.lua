return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require('oil').setup({
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }),
      keymaps = {
        ["<C-t>"] = false,  -- Disable the default new tab keybind
      },
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
        natural_sort = true,
      }
    })
  end,
}
