return {
  "stevearc/oil.nvim",
  opts = {},
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  lazy = false,
  config = function()
    local width = math.floor(vim.o.columns * 0.35)
    local height = math.floor(vim.o.lines * 0.40)
    require("oil").setup({
      float = {
        enable = true,
        max_width = width,
        max_height = height,
        border = "single",
        win_options = {
          winblend = 0,
        },
      },

      keymaps = {
        ["<C-v>"] = "actions.select_vsplit",
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
