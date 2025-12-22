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
				local ft = vim.bo[bufnr].filetype
				if ft == "jsonnet" or ft == "php" then
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
