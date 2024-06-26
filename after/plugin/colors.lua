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
    --FloatBorder = { fg = 'rose', bg = 'rose' },

    -- Customize the appearance of floating windows
    -- NormalFloat = { bg = 'base', blend = 0 },
    -- Add background to floating window
    -- Float = { bg = 'base' },
  }
})

function ColorMyPencils(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
