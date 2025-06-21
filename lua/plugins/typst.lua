return {
  {
    "kaarmu/typst.vim",
    ft = "typst",
    lazy = true,
  },
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    lazy = false,
    version = "0.3.*",
    build = function()
      require("typst-preview").update()
    end,
    config = function()
      require("typst-preview").setup({
        -- Explicitly set the mode to webview
        mode = "webview",
      })
    end,
    keys = {
      { "<leader>tp", "<cmd>TypstPreview<cr>", desc = "Preview Typst" },
    },
  },
}
