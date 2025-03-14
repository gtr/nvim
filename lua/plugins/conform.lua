return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format", "ruff_fix" },
        markdown = { "prettier" },
      },
      formatters = {
        ruff_fix = {
          command = "ruff",
          args = { "check", "--fix", "-e", "-n", "--stdin-filename", "$FILENAME", "-" },
        },
        ruff_format = {
          command = "ruff",
          args = { "format", "--stdin-filename", "$FILENAME", "-" },
        },
        prettier = {
          args = { "--print-width", "120", "--prose-wrap", "always", "--stdin-filepath", "$FILENAME" },
        },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = true,
      },
    },
  },
}
