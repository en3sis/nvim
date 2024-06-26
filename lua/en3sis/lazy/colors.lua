function ColorMyPencils(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)
  if color == "rose-pine" then
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  end
end

return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require('rose-pine').setup({
        disable_background = true,
        variant = 'moon',
        dim_nc_background = false,
        disable_italics = false,
        disable_float_background = true,
        groups = {
          background = 'base',
          background_nc = '_experimental_nc',
          panel = 'surface',
          panel_nc = 'base',
          border = 'highlight_med',
          comment = 'muted',
          link = 'iris',
          punctuation = 'subtle',

          error = 'love',
          hint = 'iris',
          info = 'foam',
          warn = 'gold',

          -- or set all headings at once
          -- headings = 'subtle'
        },
        highlight_groups = {
          ColorColumn = { bg = 'moon' },

          -- Blend colours against the "base" background
          CursorLine = { bg = 'love', blend = 10 },
          StatusLine = { fg = 'love', bg = 'love', blend = 10 },

          -- By default each group adds to the existing config.
          -- If you only want to set what is written in this config exactly,
          -- you can set the inherit option:
          Search = { bg = 'gold', fg = 'black', inherit = false },

          -- Add a border to floating windows
          --FloatBorder = { fg = 'gold', bg = 'gold' },

          -- Customize the appearance of floating windows
          NormalFloat = { bg = 'gold', blend = 0, inherit = true },
          -- Add background to floating window
          Float = { bg = 'love', blend = 0, inherit = true },
        }
      })

      --vim.cmd("colorscheme rose-pine")
      --ColorMyPencils()
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        flavour = "latte", -- latte, frappe, macchiato, mocha
        background = {     -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true, -- disables setting the background color.
        show_end_of_buffer = false,    -- shows the '~' characters after the end of buffers
        term_colors = true,            -- sets terminal colors (e.g. `g:terminal_color_0`)
      })
      --vim.cmd("colorscheme catppuccin-latte")
      ColorMyPencils("catppuccin-latte")
    end
  },

}
