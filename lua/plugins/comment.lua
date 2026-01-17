return {
  "numToStr/Comment.nvim",
  opts = {},
  config = function()
    require("Comment").setup()
    local api = require("Comment.api")
    local opts = { noremap = true, silent = true }

    -- Normal mode
    vim.keymap.set("n", "<C-/>", api.toggle.linewise.current, opts)
    vim.keymap.set("n", "<C-_>", api.toggle.linewise.current, opts)

    -- Visual mode
    vim.keymap.set("v", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
    vim.keymap.set("v", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)

    -- Insert mode
    vim.keymap.set("i", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>", opts)
    vim.keymap.set("i", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>", opts)
  end,
}
