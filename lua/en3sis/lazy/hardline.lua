return {
  'ojroques/nvim-hardline',
  config = function()
    require('hardline').setup {
      bufferline = false,
      -- theme = 'nord',
      custom_sections = {
        {
          class = 'high',
          item = function()
            if vim.fn.exists('*FugitiveHead') == 1 then
              local branch = vim.fn.FugitiveHead()
              if branch and #branch > 0 then
                return ' ' .. branch
              end
            end
            return ''
          end
        }
      }
    }
  end
}
