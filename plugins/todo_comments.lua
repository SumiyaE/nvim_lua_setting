return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		keywords = {
			DONE = {
				icon = "✔ ",
				color = "hint",
				alt = { "COMPLETED", "FINISHED" },
			},
			NEW = {
				icon = "★ ", -- お好みのアイコンに変更可能
				color = "warning", -- 黄色にしたい場合は warning（定義済みカラー）
				alt = { "NEWLY" },
			},
		},
	},
}
