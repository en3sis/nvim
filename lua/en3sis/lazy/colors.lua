function SetTheme(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require('rose-pine').setup({
        disable_background = true,
        --variant = 'moon',
        variant = 'auto',
        light_variant = 'dawn',
        dark_variant = 'moon',
        extend_background_behind_borders = true,
        dim_nc_background = false,
        disable_italics = true,
        disable_float_background = true,
        groups = {
          --background = 'base',
          background = 'none',
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
        before_highlight = function(group, highlight, palette)
          -- Change palette colour
          -- Optionally, only apply on light background (e.g. when using Dawn)
          if vim.o.background == "light" then
            if highlight.fg == palette.gold then
              --highlight.fg = "#C95B64"
              highlight.fg = "#D97971"
            end
            if highlight.fg == palette.rose then
              -- highlight.fg = "#802129"
              highlight.fg = "#E07694"
            end
          end
        end,
        highlight_groups = {
          ColorColumn = { bg = 'moon' },

          -- Blend colours against the "base" background
          --CursorLine = { bg = 'none', blend = 10 },
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
          StatusLineNC = { fg = "subtle", bg = "surface" },
        }
      })

      SetTheme("rose-pine-dawn")
      --SetTheme()
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

      --SetTheme("catppuccin-latte")
    end
  },
}
