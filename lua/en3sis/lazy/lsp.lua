local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 20
local MIN_LABEL_WIDTH = 20

local KIND_PRIORITY = {
  Field = 11,
  Property = 11,
  Constant = 10,
  Enum = 10,
  EnumMember = 10,
  Event = 10,
  Function = 10,
  Method = 10,
  Operator = 10,
  Reference = 10,
  Struct = 10,
  Variable = 9,
  File = 8,
  Folder = 8,
  Class = 5,
  Color = 5,
  Module = 5,
  Keyword = 2,
  Constructor = 1,
  Interface = 1,
  Snippet = 0,
  Text = 1,
  TypeParameter = 1,
  Unit = 1,
  Value = 1,
}

local function configure_servers()
  vim.lsp.config("*", {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  })

  vim.lsp.config("bashls", {
    filetypes = { "sh", "zsh" },
  })

  vim.lsp.config("eslint", {
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  })

  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        runtime = { version = "Lua 5.1" },
        diagnostics = {
          globals = { "vim", "it", "describe", "before_each", "after_each" },
        },
      },
    },
  })

  vim.lsp.config("ts_ls", {
    settings = {
      completions = {
        completeFunctionCalls = true,
      },
    },
  })

  vim.lsp.config("gopls", {
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
          unusedwrite = true,
          unusedvariable = true,
        },
        staticcheck = true,
        usePlaceholders = true,
        completeUnimported = true,
        gofumpt = true,
      },
    },
  })

  vim.lsp.config("rust_analyzer", {
    settings = {
      ["rust-analyzer"] = {
        check = { command = "clippy" },
        diagnostics = {
          enable = true,
          experimental = { enable = true },
        },
        imports = {
          granularity = { group = "module" },
          prefix = "self",
        },
        cargo = {
          buildScripts = { enable = true },
        },
        procMacro = { enable = true },
      },
    },
  })

  vim.lsp.config("denols", {
    init_options = {
      lint = true,
      unstable = true,
      suggest = {
        imports = {
          hosts = {
            ["https://deno.land"] = true,
            ["https://cdn.nest.land"] = true,
            ["https://crux.land"] = true,
          },
        },
      },
    },
    settings = {
      deno = {
        enable = true,
        suggest = {
          imports = { autoDiscover = true },
        },
      },
    },
  })
end

local function on_save(bufnr, name, callback)
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("en3sis_lsp_" .. name .. "_" .. bufnr, { clear = true }),
    buffer = bufnr,
    callback = callback,
  })
end

local function run_code_action(kind)
  vim.lsp.buf.code_action({
    context = { only = { kind }, diagnostics = {} },
    apply = true,
  })
end

local SAVE_HOOKS = {
  eslint = function(bufnr)
    on_save(bufnr, "eslint", function()
      if vim.fn.exists(":LspEslintFixAll") == 2 then
        vim.cmd("LspEslintFixAll")
      elseif vim.fn.exists(":EslintFixAll") == 2 then
        vim.cmd("EslintFixAll")
      end
    end)
  end,
  lua_ls = function(bufnr)
    on_save(bufnr, "lua_ls", function()
      vim.lsp.buf.format({ bufnr = bufnr, name = "lua_ls", async = false })
    end)
  end,
  rust_analyzer = function(bufnr)
    on_save(bufnr, "rust_analyzer", function()
      vim.lsp.buf.format({ bufnr = bufnr, name = "rust_analyzer", async = false })
      run_code_action("source.removeUnusedImports")
      run_code_action("source.fixAll")
    end)
  end,
}

local function set_keymaps(bufnr)
  local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, remap = false })
  end

  map("n", "<leader>vd", vim.diagnostic.open_float)
  map("n", "[d", function() vim.diagnostic.jump({ count = 1, float = true }) end)
  map("n", "]d", function() vim.diagnostic.jump({ count = -1, float = true }) end)
  map("n", "<leader>vdw", function() vim.diagnostic.setqflist({ open = true }) end)
  map("n", "<leader>vdf", function()
    vim.diagnostic.setqflist({ open = true, title = "Diagnostics for current file", bufnr = 0 })
  end)

  map("n", "gd", vim.lsp.buf.definition)
  map("n", "gr", vim.lsp.buf.references)
  map("n", "gi", vim.lsp.buf.implementation)
  map("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
  map("n", "K", vim.lsp.buf.hover)
  map("i", "<C-h>", vim.lsp.buf.signature_help)
  map("n", "<F2>", vim.lsp.buf.rename)
  map("n", "<F3>", vim.lsp.buf.code_action)
end

local function setup_attach()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("en3sis_lsp_attach", { clear = true }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      set_keymaps(args.buf)
      local hook = client and SAVE_HOOKS[client.name]
      if hook then
        hook(args.buf)
      end
    end,
  })
end

local function setup_cmp()
  local cmp = require("cmp")
  local lsp_types = require("cmp.types").lsp
  local cmp_select = { behavior = cmp.SelectBehavior.Select }

  local function kind_comparator(entry1, entry2)
    if entry1.source.name ~= "nvim_lsp" then
      if entry2.source.name == "nvim_lsp" then
        return false
      end
      return nil
    end
    local priority1 = KIND_PRIORITY[lsp_types.CompletionItemKind[entry1:get_kind()]] or 0
    local priority2 = KIND_PRIORITY[lsp_types.CompletionItemKind[entry2:get_kind()]] or 0
    if priority1 == priority2 then
      return nil
    end
    return priority2 < priority1
  end

  local function label_comparator(entry1, entry2)
    return entry1.completion_item.label < entry2.completion_item.label
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.snippet.expand(args.body)
      end,
    },
    formatting = {
      format = function(_, vim_item)
        local label = vim_item.abbr
        local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
        if truncated_label ~= label then
          vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
        elseif string.len(label) < MIN_LABEL_WIDTH then
          vim_item.abbr = label .. string.rep(" ", MIN_LABEL_WIDTH - string.len(label))
        end
        return vim_item
      end,
    },
    view = {
      entries = {
        name = "custom",
        selection_order = "",
        follow_cursor = false,
      },
      docs = {
        auto_open = true,
      },
    },
    window = {
      documentation = cmp.config.window.bordered({
        border = "rounded",
        max_width = 0,
      }),
      completion = cmp.config.window.bordered(),
    },
    sorting = {
      comparators = { kind_comparator, label_comparator },
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
      ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
      ["<C-y>"] = cmp.mapping.confirm({ select = true }),
      ["<C-Space>"] = cmp.mapping.complete(),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "path" },
    }, {
      { name = "buffer" },
    }),
  })
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "mason-org/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    { "j-hui/fidget.nvim", opts = {} },
  },
  config = function()
    configure_servers()
    setup_attach()
    setup_cmp()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "rust_analyzer", "gopls", "eslint", "ts_ls" },
      automatic_enable = true,
    })
  end,
}
