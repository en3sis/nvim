local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 20
local MIN_LABEL_WIDTH = 20

local codeActionPriorities = {
  ["source.organizeImports.go"] = 100,
  ["source.fixAll"] = 90,
  ["source.addMissingImports"] = 89,
  ["quickfix.next"] = 80,
  ["refactor"] = 70,
}


return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    -- "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
    { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' }
  },
  config = function()
    local cmp = require('cmp')
    local cmp_lsp = require("cmp_nvim_lsp")

    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities())

    local lsp_zero = require('lsp-zero')
    ---@diagnostic disable-next-line: unused-local
    lsp_zero.on_attach(function(client, bufnr)
      local opts = { buffer = bufnr, remap = false }

      -- Diagnostics
      vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
      vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
      vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
      vim.keymap.set("n", "<leader>vdw", function() vim.diagnostic.setqflist({ open = true }) end, opts)
      vim.keymap.set("n", "<leader>vdf", function()
        vim.diagnostic.setqflist({ open = true, title = "Diagnostics for current file", bufnr = 0 })
      end, opts)

      -- Definitions and References
      vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
      vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
      vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)

      -- Workspace
      vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)

      -- Hover and Information
      vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
      vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

      -- Code Actions and Refactoring
      vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end, opts)
      vim.keymap.set("n", "<F3>", function() vim.lsp.buf.code_action() end, opts)
    end)

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "gopls",
        'eslint',
        'ts_ls',
      },
      handlers = {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities
          }
        end,

        ["bashls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.bashls.setup {
            capabilities = capabilities,
            filetypes = { "sh", "zsh" }
          }
        end,

        ["eslint"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.eslint.setup {
            capabilities = capabilities,
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
            on_attach = function(client, bufnr)
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "EslintFixAll",
              })
            end,
          }
        end,

        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = "Lua 5.1" },
                diagnostics = {
                  globals = { "vim", "it", "describe", "before_each", "after_each" },
                }
              }
            }
          }
        end,

        ['ts_ls'] = function()
          local lspconfig = require("lspconfig")

          lspconfig.ts_ls.setup({
            capabilities = capabilities,
            settings = {
              completions = {
                completeFunctionCalls = true
              }
            }
          })
        end,

        ["gopls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.gopls.setup({
            capabilities = capabilities,
            settings = {
              gopls = {
                analyses = {
                  unusedparams = true,     -- Detect unused parameters
                  unusedwrite = true,      -- Detect unused writes
                  unusedvariable = true,   -- Detect unused variables
                },
                staticcheck = true,        -- Enable staticcheck analysis
                usePlaceholders = true,    -- Use placeholders for function parameters
                completeUnimported = true, -- Enable completion for unimported packages
                gofumpt = true,            -- Enable stricter formatting (optional)
              },
            },
            on_attach = function(client, bufnr)
              -- Enable auto-formatting on save for Go files
              vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.go",
                callback = function()
                  vim.lsp.buf.format({ async = false })
                  -- Organize imports on save
                  vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
                end,
              })
            end,
          })
        end,

        ["rust_analyzer"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.rust_analyzer.setup({
            capabilities = capabilities,
            settings = {
              ["rust-analyzer"] = {
                check = {
                  command = "clippy",
                },
                diagnostics = {
                  enable = true,
                  experimental = {
                    enable = true,
                  },
                },
                imports = {
                  granularity = {
                    group = "module",
                  },
                  prefix = "self",
                },
                cargo = {
                  buildScripts = {
                    enable = true,
                  },
                },
                procMacro = {
                  enable = true
                },
              },
            },
            on_attach = function(client, bufnr)
              -- Enable auto-formatting on save
              vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.rs",
                callback = function()
                  vim.lsp.buf.format({ async = false })
                end,
              })

              -- Run additional fixes on save
              vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.rs",
                callback = function()
                  -- Remove unused imports
                  vim.lsp.buf.code_action({
                    context = {
                      only = { "source.removeUnusedImports" },
                      diagnostics = {},
                    },
                    apply = true,
                  })

                  -- Fix unused variables
                  vim.lsp.buf.code_action({
                    context = {
                      only = { "source.fixAll" },
                      diagnostics = {},
                    },
                    apply = true,
                  })
                end,
              })
            end,
          })
        end,

        ["denols"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.denols.setup({
            capabilities = capabilities,
            root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
            init_options = {
              lint = true,
              unstable = true,
              suggest = {
                imports = {
                  hosts = {
                    ["https://deno.land"] = true,
                    ["https://cdn.nest.land"] = true,
                    ["https://crux.land"] = true
                  }
                }
              }
            },
            settings = {
              deno = {
                enable = true,
                suggest = {
                  imports = {
                    autoDiscover = true
                  }
                }
              }
            }
          })
        end,
      }
    })

    -- Setup lspconfig comparator for cmp
    local lspkind_comparator = function(conf)
      local lsp_types = require('cmp.types').lsp
      return function(entry1, entry2)
        if entry1.source.name ~= 'nvim_lsp' then
          if entry2.source.name == 'nvim_lsp' then
            return false
          else
            return nil
          end
        end
        local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
        local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]

        local priority1 = conf.kind_priority[kind1] or 0
        local priority2 = conf.kind_priority[kind2] or 0
        if priority1 == priority2 then
          return nil
        end
        return priority2 < priority1
      end
    end

    local label_comparator = function(entry1, entry2)
      return entry1.completion_item.label < entry2.completion_item.label
    end
    -- end of setup lspconfig comparator for cmp

    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    -- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua for more options
    -- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/window.lua for more options
    cmp.setup({
      formatting = {
        format = function(entry, vim_item)
          local label = vim_item.abbr
          local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
          if truncated_label ~= label then
            vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
          elseif string.len(label) < MIN_LABEL_WIDTH then
            local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
            vim_item.abbr = label .. padding
          end
          return vim_item
        end,
      },
      performance = {
        -- max_view_entries = 10,
      },
      view = {
        entries = {
          name = 'custom',
          selection_order = '',
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
        comparators = {
          lspkind_comparator({
            kind_priority = {
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
            },
          }),
          label_comparator,
        },
        -- comparators = {
        --   cmp.config.compare.offset,
        --   cmp.config.compare.exact,
        --   cmp.config.compare.score,
        --   cmp.config.compare.recently_used,
        --   --require("cmp-under-comparator").under,
        --   cmp.config.compare.kind,
        -- },
      },
      -- snippet = {
      --   expand = function(args)
      --     require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      --   end,
      -- },
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),

      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
      }, {
        { name = 'buffer' },
      })
    })
  end
}
