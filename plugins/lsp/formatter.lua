return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				markdown = { "prettier" },
				zsh = { "shfmt" },
				jsonnet = {},
			},
			format_on_save = function(bufnr)
				if vim.bo[bufnr].filetype == "jsonnet" then
					return nil
				end
				return {
					timeout_ms = 500,
					lsp_format = "fallback",
				}
			end,
		})
	end,
}
