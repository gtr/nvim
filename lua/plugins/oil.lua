return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  lazy = false,
  config = function()
    require("oil").setup({
      float = {
        enable = true,
        max_width = 80,
        max_height = 20,
        border = "rounded",
        win_options = {
          winblend = 50,
        },
      },

      -- Disable confirmation prompts (yep)
      confirm_file_exists = false,
      delete_to_trash = false,
      skip_confirm_for_simple_edits = true,
      prompt_save_on_select_new_entry = false,
    })

    -- Map Ctrl-minus to open oil in float mode
    vim.keymap.set("n", "<C-->", function()
      require("oil").open_float()
    end, { desc = "Open oil file explorer in float window" })
  end,
}
