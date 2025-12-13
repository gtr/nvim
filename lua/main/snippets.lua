-- Prevent LSP semantic tokens from overwriting Treesitter colors
-- https://github.com/NvChad/NvChad/issues/1907
if vim.hl and vim.hl.priorities then
  vim.hl.priorities.semantic_tokens = 95
end

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    format = function(diagnostic)
      local code = diagnostic.code and ("[" .. diagnostic.code .. "] ") or ""
      return code .. diagnostic.message
    end,
  },
  underline = true,
  signs = true,
  update_in_insert = false,
  float = {
    source = "always",
  },
})

-- Highlight on yank
local yank_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.hl.on_yank({
      higroup = "Visual",
      timeout = 200,
    })
  end,
})
