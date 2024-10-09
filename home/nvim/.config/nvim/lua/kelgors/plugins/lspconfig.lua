local M = {}

M.setup = function (shared_config)
  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local function config(_config)
    return vim.tbl_deep_extend("force", { capabilities = capabilities }, shared_config, _config or {})
  end

  local lspconfig = require('lspconfig')
  -- Ansible
  lspconfig.ansiblels.setup(config())
  -- Bash
  lspconfig.bashls.setup(config())
  -- Docker
  lspconfig.dockerls.setup(config())
  -- lspconfig.docker_compose_language_service.setup(config())
  -- Prisma
  lspconfig.prismals.setup(config())
  -- SQL
  lspconfig.sqlls.setup(config())
  -- Rust-Analyzer commands:
  -- CargoReload: Reload current cargo workspace
  lspconfig.rust_analyzer.setup(config())
  -- Pyright commands:
  -- PyrightOrganizeImports: Organize Imports
  -- PyrightSetPythonPath: Reconfigure pyright with the provided python path
  lspconfig.pyright.setup(config())
  -- Terraform
  lspconfig.terraformls.setup(config())
  -- YAML
  lspconfig.yamlls.setup(config())
  -- JSON
  lspconfig.jsonls.setup(config())
  -- HTML
  lspconfig.html.setup(config())
  -- CSS
  lspconfig.cssls.setup(config())
  -- TypescriptServer
  lspconfig.tsserver.setup(config())
  -- ESLint
  lspconfig.eslint.setup(config({
    on_attach = function(client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
  }))
  -- GraphQL
  lspconfig.graphql.setup(config())
  -- Lua
--   lspconfig.lua_ls.setup(config({
--     on_init = function(client)
--       local path = client.workspace_folders[1].name
--       if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
--         client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
--           Lua = {
--             runtime = {
--               -- Tell the language server which version of Lua you're using
--               -- (most likely LuaJIT in the case of Neovim)
--               version = 'LuaJIT'
--             },
--             -- Make the server aware of Neovim runtime files
--             workspace = {
--               checkThirdParty = false,
--               library = {
--                 vim.env.VIMRUNTIME
--                 -- "${3rd}/luv/library"
--                 -- "${3rd}/busted/library",
--               }
--               -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
--               -- library = vim.api.nvim_get_runtime_file("", true)
--             }
--           }
--         })
-- 
--         client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
--       end
--       return true
--     end
--   }))
end

return M
