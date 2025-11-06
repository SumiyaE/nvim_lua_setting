return {
	"shellRaining/hlchunk.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		chunk = {
			enable = true,
			delay = 0,
			duration = 0,
			style = {
				"#FFE500", -- yellow
				"#c21f30", -- maple red
			},
		},
		indent = {
			enable = true,
			chars = {
				"│",
				"¦",
				":",
			},
			style = {
				vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
			},
		},
		line_num = {
			enable = true,
			style = "#FFE500",
		},
	},
}
