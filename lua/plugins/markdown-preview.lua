return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  config = function()
    vim.g.mkdp_theme = "light"
    vim.g.mkdp_auto_start = 0
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.keymap.set(
          "n",
          "<leader>mp",
          "<cmd>MarkdownPreviewToggle<CR>",
          { buffer = true, desc = "Preview Markdown" }
        )
      end,
    })
  end,
}
