return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      -- VimTeX configuration
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_quickfix_mode = 0
      vim.g.tex_flavor = "latex"
    end,
  },

  -- PDF viewer (optional)
  {
    "jakewvincent/texmagic.nvim",
    config = function()
      require("texmagic").setup({
        engines = {
          pdflatex = {
            executable = "pdflatex",
            args = {
              "-interaction=nonstopmode",
              "-synctex=1",
              "%f",
            },
            isContinuous = false,
          },
        },
      })
    end,
  },
}
