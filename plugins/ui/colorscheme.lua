return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			compile = false, -- enable compiling the colorscheme
			undercurl = true, -- enable undercurls
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = false, -- do not set background color
			dimInactive = true, -- dim inactive window
			terminalColors = true, -- define vim.g.terminal_color_{0,17}
			colors = {
				palette = {},
				theme = {
					wave = {},
					lotus = {},
					dragon = {},
					all = {},
				},
			},
			overrides = function(colors)
				return {}
			end,
			theme = "lotus", -- Load "lotus" theme when 'background' option is set to light
			background = {
				dark = "wave",
				light = "lotus",
			},
		})

		vim.cmd.colorscheme("kanagawa-lotus")
	end,
}
