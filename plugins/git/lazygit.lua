return {
	"kdheepak/lazygit.nvim",
	lazy = false, -- 起動を高速化するため、事前ロード
	config = function()
		-- LazyGitのウィンドウサイズを設定
		vim.g.lazygit_floating_window_winblend = 0 -- 透明度
		vim.g.lazygit_floating_window_scaling_factor = 0.8 -- サイズ（80%）
		vim.g.lazygit_floating_window_use_plenary = 0 -- plenaryを使わない（高速化）
	end,
	keys = {
		{ "<leader>g", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit (current file's repo)" },
	},
}
