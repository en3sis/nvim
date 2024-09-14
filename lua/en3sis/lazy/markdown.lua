return {
  'MeanderingProgrammer/markdown.nvim',
  --name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('render-markdown').setup({
      code = {
        border = 'thin',
        -- Used above code blocks for thin border
        above = '_',
        -- Used below code blocks for thin border
        below = '_',
      }
    })
  end,
}
