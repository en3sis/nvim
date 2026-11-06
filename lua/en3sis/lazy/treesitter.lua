local ENSURE_INSTALLED = {
  "vimdoc", "javascript", "typescript", "tsx", "c", "lua", "rust",
  "jsdoc", "bash", "markdown", "markdown_inline", "html", "nginx", "go", "templ",
  "json", "yaml", "toml", "css", "scss", "dockerfile", "python", "make", "sql",
  "diff", "gitcommit", "terraform", "prisma",
}

local KEEP_REGEX_SYNTAX = { markdown = true, go = true }

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")

    local installed = ts.get_installed()
    local missing = vim.tbl_filter(function(lang)
      return not vim.tbl_contains(installed, lang)
    end, ENSURE_INSTALLED)
    if #missing > 0 then
      ts.install(missing)
    end

    local function start(buf, lang)
      if not pcall(vim.treesitter.start, buf, lang) then
        return
      end
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      if KEEP_REGEX_SYNTAX[vim.bo[buf].filetype] then
        vim.bo[buf].syntax = "ON"
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("en3sis_treesitter", { clear = true }),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
          return
        end
        if vim.tbl_contains(ts.get_installed(), lang) then
          start(args.buf, lang)
        elseif vim.tbl_contains(ts.get_available(), lang) then
          ts.install(lang):await(function()
            vim.schedule(function()
              if vim.api.nvim_buf_is_valid(args.buf) then
                start(args.buf, lang)
              end
            end)
          end)
        end
      end,
    })
  end,
}
