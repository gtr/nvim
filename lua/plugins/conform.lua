-- return { -- Autoformat
-- 	"stevearc/conform.nvim",
-- 	event = { "BufWritePre" },
-- 	cmd = { "ConformInfo" },
-- 	keys = {
-- 		{
-- 			"<leader>f",
-- 			function()
-- 				require("conform").format({ async = true, lsp_format = "fallback" })
-- 			end,
-- 			mode = "",
-- 			desc = "[F]ormat buffer",
-- 		},
-- 	},
-- 	opts = {
-- 		notify_on_error = false,
-- 		format_on_save = function(bufnr)
-- 			-- Disable "format_on_save lsp_fallback" for languages that don't
-- 			-- have a well standardized coding style. You can add additional
-- 			-- languages here or re-enable it for the disabled ones.
-- 			local disable_filetypes = { c = true, cpp = true }
-- 			local lsp_format_opt
-- 			if disable_filetypes[vim.bo[bufnr].filetype] then
-- 				lsp_format_opt = "never"
-- 			else
-- 				lsp_format_opt = "fallback"
-- 			end
-- 			return {
-- 				timeout_ms = 500,
-- 				lsp_format = lsp_format_opt,
-- 			}
-- 		end,
-- 		formatters_by_ft = {
-- 			lua = { "stylua" },
-- 			-- Conform can also run multiple formatters sequentially
-- 			-- python = { "isort", "black" },
-- 			--
-- 			-- You can use 'stop_after_first' to run the first available formatter from the list
-- 			-- javascript = { "prettierd", "prettier", stop_after_first = true },
-- 		},
-- 	},
-- }
--
--
return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                python = { "ruff_format", "ruff_fix" },
            },
            formatters = {
                ruff_fix = {
                    -- This ensures ruff uses your config file
                    command = "ruff",
                    args = { "check", "--fix", "-e", "-n", "--stdin-filename", "$FILENAME", "-" },
                },
                ruff_format = {
                    command = "ruff",
                    args = { "format", "--stdin-filename", "$FILENAME", "-" },
                },
            },
            -- Format on save
            format_on_save = {
                timeout_ms = 500,
                lsp_format = true,
            },
        },
    },
}
