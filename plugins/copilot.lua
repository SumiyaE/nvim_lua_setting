return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			filetypes = {
				markdown = true, -- ← 補完を有効にする
				help = false, -- ← 無効にしたい例
			},
		})
	end,
}
