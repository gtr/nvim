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
  underline = false,
  update_in_insert = true,
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
    vim.highlight.on_yank({
      higroup = "Visual",
      timeout = 200,
    })
  end,
})
