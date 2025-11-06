return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "latte", -- latte, frappe, macchiato, mocha
			transparent_background = false,
			show_end_of_buffer = false,
			term_colors = true,
			dim_inactive = {
				enabled = true,
				shade = "dark",
				percentage = 0.15,
			},
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				telescope = {
					enabled = true,
				},
				mason = true,
				which_key = true,
			},
		})

		vim.cmd.colorscheme("catppuccin")

		-- Shade.nvimとの併用のため、非アクティブウィンドウの設定を調整
		vim.cmd("highlight! NormalNC guibg=#e6e9ef")
		vim.cmd("highlight! LineNrNC guifg=#9ca0b0")
	end,
}
