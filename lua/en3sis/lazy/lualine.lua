return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local function filename_with_icon()
      local filename = vim.fn.expand('%:t')
      local extension = vim.fn.expand('%:e')
      local filepath = vim.fn.expand('%:p:h:t') -- Get the parent directory name
      local icon = require'nvim-web-devicons'.get_icon(filename, extension)
      if icon == nil then
        icon = ''
      end
      return icon .. ' ' .. filepath .. '/' .. filename
    end

    local custom_theme = {
      normal = {
        a = { fg = '#ffffff', bg = '#1a1b26', bold = true },
        b = { fg = '#ffffff', bg = '#16161e' },
        c = { fg = '#ffffff', bg = '#1a1b26' },
      },
      insert = {
        a = { fg = '#1a1b26', bg = '#7aa2f7', bold = true },
        b = { fg = '#7aa2f7', bg = '#16161e' },
      },
      visual = {
        a = { fg = '#1a1b26', bg = '#bb9af7', bold = true },
        b = { fg = '#bb9af7', bg = '#16161e' },
      },
      command = {
        a = { fg = '#1a1b26', bg = '#e0af68', bold = true },
        b = { fg = '#e0af68', bg = '#16161e' },
      },
    }

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = custom_theme,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {
          {
            filename_with_icon,
            file_status = true,
            path = 1,
            symbols = {
              modified = ' [+]',
              readonly = ' [-]',
              unnamed = '[No Name]',
            }
          },
          {
            function()
              local size = vim.fn.getfsize(vim.fn.expand('%:p'))
              if size < 0 then return '' end
              if size < 1024 then return size .. 'B' end
              if size < 1024 * 1024 then return string.format('%.1fKB', size / 1024) end
              return string.format('%.1fMB', size / (1024 * 1024))
            end,
            color = { fg = '#bb9af7' }
          }
        },
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
  end
}
