local function harpoon()
  return require("harpoon")
end

return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>a",     function() harpoon():list():add() end },
      { "<C-e>",         function() harpoon().ui:toggle_quick_menu(harpoon():list()) end },
      { "<C-t>",         function() harpoon():list():select(1) end },
      { "<C-h>",         function() harpoon():list():select(2) end },
      { "<C-n>",         function() harpoon():list():select(3) end },
      { "<C-m>",         function() harpoon():list():select(4) end },
      { "<leader><C-h>", function() harpoon():list():replace_at(1) end },
      { "<leader><C-t>", function() harpoon():list():replace_at(2) end },
      { "<leader><C-n>", function() harpoon():list():replace_at(3) end },
      { "<leader><C-s>", function() harpoon():list():replace_at(4) end },
    },
    config = function()
      harpoon():setup()
    end
  }
}
