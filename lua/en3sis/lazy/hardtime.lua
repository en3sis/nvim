return {
  "m4xshen/hardtime.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    max_time = 1000,
    max_count = 2,
    disable_mouse = false,
    arrow = false,
    hint = true,
    notification = true,
    allow_different_key = true,
    enabled = true,
  },
}
