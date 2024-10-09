local M = {}

M.setup = function ()
  local configs = require("nvim-treesitter.configs")

  configs.setup({
    ensure_installed = { 
      -- web
      "typescript", "tsx", "javascript", "html", "css", "scss", "graphql", "sql", "prisma", "markdown",
      -- Deployment
      "terraform", "dockerfile", "python",
      -- data files
      "csv", "json", "yaml", "toml",
      -- Linux related
      "bash", "rust", "ssh_config", 
      -- nvim treesitter
      "lua", "vim", "vimdoc", "query"
    },

    sync_install = false,
    highlight = {
      enable = true,
      disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
              return true
          end
      end,
    },
    indent = { enable = true },  
  })
end

return M