local ruff_root = vim.fn.getcwd() -- Gets directory where nvim was launched

return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        pyright = {
          on_attach = function(client, bufnr)
            -- Create autocmd group
            local augroup = vim.api.nvim_create_augroup("PyrightToggle", { clear = true })

            -- Disable diagnostics in insert mode
            vim.api.nvim_create_autocmd("InsertEnter", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.diagnostic.disable(bufnr)
              end,
            })

            -- Re-enable diagnostics when leaving insert mode
            vim.api.nvim_create_autocmd("InsertLeave", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.diagnostic.enable(bufnr)
              end,
            })
          end,
          settings = {
            python = {
              pythonPath = vim.fn.expand("/Users/gerardo/anaconda3/envs/paces/bin/python"),
            },
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
        ruff = {
          on_attach = function(client, bufnr)
            print('Ruff attached from: ' .. ruff_root)
          end,
          root_dir = function()
            return ruff_root
          end,
          settings = {
            ruff = {
              -- Only specify where to find the config file
              configPath = vim.fn.getcwd() .. '/ruff.toml',
            },
          },
        },
      },
    },
  },
}
