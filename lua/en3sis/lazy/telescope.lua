return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  cmd = "Telescope",
  keys = {
    { "<leader>ef", function() require("telescope.builtin").find_files() end },
    { "<C-p>",      function() require("telescope.builtin").git_files() end },
    { "<leader>ew", function() require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") }) end },
    { "<leader>eW", function() require("telescope.builtin").grep_string({ search = vim.fn.expand("<cWORD>") }) end },
    { "<leader>es", function() require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") }) end },
    { "<leader>vh", function() require("telescope.builtin").help_tags() end },
  },
  config = function()
    require('telescope').setup({
      defaults = {
        color_devicons = true,
        disable_devicons = false,
        color_icons = true,
        file_ignore_patterns = { "^%.git/", "^node_modules/" },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    })
  end
}
