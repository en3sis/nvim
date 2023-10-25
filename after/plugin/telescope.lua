local builtin = require('telescope.builtin')
require'telescope'.load_extension('project')

-- Telescope keybindings 
vim.keymap.set('n', '<leader>ef', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>es', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
