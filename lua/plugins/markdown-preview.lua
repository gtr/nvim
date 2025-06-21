return {
  "iamcco/markdown-preview.nvim",
  build = "cd app && npm install",
  ft = { "markdown" },
  config = function()
    vim.g.mkdp_auto_start = 1

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { buffer = true, desc = "Preview Markdown" })
      end,
    })
  end,
}
