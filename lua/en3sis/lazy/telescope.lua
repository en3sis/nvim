return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },

  config = function()
    require('telescope').setup({
      defaults = {
        color_devicons = true,
        disable_devicons = false,
        color_icons = true,
        file_ignore_patterns = { "^%.git/", "^node_modules/" }, -- Ignore .git and node_modules directories
      },
       pickers = {
        find_files = {
          hidden = true, -- Show hidden files in find_files picker
        },
      },
    })

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ef', builtin.find_files, {})
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    vim.keymap.set('n', '<leader>ew', function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({ search = word })
    end)
    vim.keymap.set('n', '<leader>eW', function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end)
    vim.keymap.set('n', '<leader>es', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
    vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
  end
}
