return {
  'ojroques/nvim-hardline',
  config = function()
    require('hardline').setup {
      bufferline = false,
      -- theme = 'nord',
    }
  end
}
