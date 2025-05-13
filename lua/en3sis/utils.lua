vim.api.nvim_create_user_command('Reload', function()
  -- Source init.lua
  vim.cmd('source $MYVIMRC')
  -- Clear and source all Lua modules
  for name, _ in pairs(package.loaded) do
    if name:match('^user') or name:match('^plugins') then
      package.loaded[name] = nil
    end
  end
  -- Show confirmation
  vim.notify('Neovim config reloaded!', vim.log.levels.INFO)
end, {})


