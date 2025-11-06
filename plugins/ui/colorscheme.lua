return {
	"EdenEast/nightfox.nvim",
	priority = 1000,
	config = function()
		require("nightfox").setup({
			options = {
				transparent = false,
				terminal_colors = true,
				dim_inactive = false,
				styles = {
					comments = "italic",
					keywords = "bold",
					types = "italic,bold",
				},
			},
		})

		vim.cmd.colorscheme("nightfox")
	end,
}
