return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- Enable terminal functionality for claudecode.nvim
		terminal = {
			enabled = true,
		},
		-- Optional: Enable other snacks.nvim features
		bigfile = { enabled = true },
		quickfile = { enabled = true },
	},
}
