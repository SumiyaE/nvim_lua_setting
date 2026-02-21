return {
	"kdheepak/lazygit.nvim",
	init = function()
		vim.g.lazygit_floating_window_winblend = 0
		vim.g.lazygit_floating_window_scaling_factor = 0.8
		vim.g.lazygit_floating_window_use_plenary = 0
	end,
	keys = {
		{ "<leader>g", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit (current file's repo)" },
	},
}
