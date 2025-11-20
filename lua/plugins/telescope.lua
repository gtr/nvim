return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        borderchars = {
          prompt = { "─", "│", "─", "│", "│", " ", "─", "└" },
          results = { "─", "│", "─", "│", "┌", "─", "─", "│" },
          preview = { "─", "│", "─", "│", "┬", "┐", "┘", "┴" },
        },
        -- layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "bottom",
          },
          width = { padding = 10 },
          height = { padding = 2 },
          preview_cutoff = 120,
        },
        mappings = {
          i = {
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-l>"] = require("telescope.actions").select_default,
          },
          n = {
            ["d"] = require("telescope.actions").delete_buffer,
          },
        },
        preview = {
          treesitter = true,
          numbers = true,
          title = true,
        },
        path_display = { "truncate" },
      },
      pickers = {
        find_files = {
          file_ignore_patterns = {
            "node_modules",
            ".git",
            ".venv",
            "backend/data",
            "etl/data",
            "etl/debug",
            "uploads",
            "search/data",
            "search/data-old",
            "backend/staticfiles",
            "frontend/src/assets",
            "target/",
          },
          hidden = true,
          path_display = function(opts, path)
            local tail = require("telescope.utils").path_tail(path)
            return string.format("%s (%s)", tail, path)
          end,
        },
      },
      live_grep = {
        file_ignore_patterns = {
          "node_modules",
          ".git",
          ".venv",
          "backend/data",
          "etl/data",
          "etl/debug",
          "uploads",
          "search/data",
          "search/data-old",
          "backend/staticfiles",
        },
        additional_args = function(_)
          return { "--hidden" }
        end,
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
        file_browser = {
          hijack_netrw = true,
          hidden = true,
          respect_gitignore = true,
          borderchars = {
            prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          },
          mappings = {
            ["i"] = {
              ["<Left>"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
              ["<Right>"] = require("telescope.actions").select_default,
            },
            ["n"] = {
              ["<Left>"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
              ["<Right>"] = require("telescope.actions").select_default,
            },
          },
          preview = {
            numbers = true,
          },
        },
      },
    })

    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")
    pcall(require("telescope").load_extension, "file_browser")

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>ss", builtin.lsp_document_symbols, { desc = "[S]earch [S]ymbols in current file" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>sg", function()
      vim.ui.input({ prompt = "Search in path (leave empty for root): " }, function(path)
        if path then
          require("telescope.builtin").live_grep({
            search_dirs = { path ~= "" and path or nil },
          })
        end
      end)
    end, { desc = "[S]earch by [G]rep with optional path" })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
    vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
    vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>", { desc = "File [B]rowser" })
    vim.keymap.set(
      "n",
      "<leader>fc",
      ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
      { desc = "File Browser [C]urrent Directory" }
    )

    vim.keymap.set("n", "<leader>/", function()
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        width = 100,
        height = 25,
        previewer = false,
        borderchars = {
          "─",
          "│",
          "─",
          "│",
          "┌",
          "┐",
          "┘",
          "└",
        },
      }))
    end, { desc = "[/] Fuzzily search in current buffer" })

    vim.keymap.set("n", "<leader>s/", function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end, { desc = "[S]earch [/] in Open Files" })

    local actions = require("telescope.actions")
    local original_select_default = actions.select_default

    -- Override the select_default action
    actions.select_default = function(prompt_bufnr)
      original_select_default(prompt_bufnr)
      vim.schedule(function()
        vim.cmd("normal! zz")
      end)
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "TelescopePreviewerLoaded",
      callback = function()
        vim.opt_local.number = true
      end,
    })
  end,
}
