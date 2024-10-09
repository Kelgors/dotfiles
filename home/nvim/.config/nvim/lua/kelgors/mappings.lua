local M = {}

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

M.setup = function ()
  -- Screen
  vim.keymap.set({ "n", "x" }, "<C-u>", "<C-u>zz") -- Half a screen up with center on cursor
  vim.keymap.set({ "n", "x" }, "<C-d>", "<C-d>zz") -- Half a screen down with center on cursor
  vim.keymap.set({ "n", "x" }, "<C-b>", "<NOP>")

  -- Search Results
  vim.keymap.set({ "n", "x" }, "n", "nzzzv") -- Next search result, center on cursor, and open folds
  vim.keymap.set({ "n", "x" }, "N", "Nzzzv") -- Previous search result, center on cursor, and open folds

  -- Toggles
  vim.keymap.set({ "n", "x" }, "<Leader>R", function() vim.o.relativenumber = not vim.o.relativenumber end)

  -- Display for LSP
  local cmp = require('cmp')
  cmp.setup({
    mapping = {
      ["<Tab>"] = cmp.mapping(function (fallback)
        local cmp = require('cmp')
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { "i", "s" }),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
      ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i", "c" }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
  })

  -- Telescope
  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>ff', builtin.find_files, {}) -- find_[f]iles
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})  -- live_[g]rep
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})    -- [b]uffers
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})  -- [h]elp_tags
end

M.setup_lsp = function ()
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })       -- [d]efinition
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })  -- [t]ype definition
  vim.keymap.set("n", "gr", vim.lsp.buf.rename, { buffer = 0 })           -- [r]ename
  vim.keymap.set("n", "gca", vim.lsp.buf.code_action, { buffer = 0 })     -- [c]ode [a]ction

  vim.keymap.set("n", "gqd", vim.diagnostic.setqflist, { buffer = 0 })    -- [d]iagnostics
  vim.keymap.set("n", "gqi", vim.lsp.buf.implementation, { buffer = 0 })  -- [i]mplementation
  vim.keymap.set("n", "gqr", vim.lsp.buf.references, { buffer = 0 })      -- [r]eferences
  vim.keymap.set("n", "gqs", vim.lsp.buf.document_symbol, { buffer = 0 }) -- [s]ybmol
end

return M
