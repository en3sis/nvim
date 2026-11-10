return {
  'nvim-lualine/lualine.nvim',
  event = "VeryLazy",
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

    local function build_theme()
      local p = require("en3sis.theme").palette()
      local function mode(color)
        return {
          a = { fg = p.on_accent, bg = color, gui = "bold" },
          b = { fg = p.fg, bg = p.line },
          c = { fg = p.sub, bg = p.bg },
        }
      end
      return {
        normal = mode(p.accent),
        insert = mode(p.green),
        visual = mode(p.magenta),
        replace = mode(p.red),
        command = mode(p.yellow),
        inactive = {
          a = { fg = p.muted, bg = p.bg },
          b = { fg = p.muted, bg = p.bg },
          c = { fg = p.muted, bg = p.bg },
        },
      }
    end

    local function setup()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = build_theme(),
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
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
              color = function() return { fg = require("en3sis.theme").palette().muted } end
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

    setup()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = setup })
  end
}
