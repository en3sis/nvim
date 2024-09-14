local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 20
local MIN_LABEL_WIDTH = 20

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
    "saadparwaiz1/cmp_luasnip",
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

      vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
      vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)
      vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
      vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
      vim.keymap.set("n", '<leader>gr', function() require('telescope.builtin').lsp_references() end,
        { noremap = true, silent = true })
      vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
      vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
      vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
      vim.keymap.set("n", "<F3>", function() vim.lsp.buf.code_action() end, opts)
      vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end, opts)
      vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
      -- vim.cmd('highlight NormalFloat guibg=#1c1c1c')
      -- New keybindings for implementation and references
      vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
      vim.keymap.set("n", "<leader>fr", function() require('telescope.builtin').lsp_references() end, opts)
      vim.keymap.set("n", "<leader>fi", function() require('telescope.builtin').lsp_implementations() end, opts)
    end)

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "gopls",
        'eslint',
        'ts_ls'
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
      }
    })

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
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          --require("cmp-under-comparator").under,
          cmp.config.compare.kind,
        },
      },
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
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
