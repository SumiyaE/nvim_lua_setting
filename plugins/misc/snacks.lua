return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- Enable terminal functionality for claudecode.nvim
		terminal = {
			enabled = true,
		},
		-- Enable notification system
		notifier = {
			enabled = true,
			timeout = 3000, -- 3秒間表示
		},
		-- Optional: Enable other snacks.nvim features
		bigfile = { enabled = true },
		quickfile = { enabled = true },
	},
}
