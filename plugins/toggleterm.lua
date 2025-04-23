return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			size = 20,
			open_mapping = [[<c-t>]],
			hide_numbers = true,
			start_in_insert = true,
			insert_mappings = true,
			direction = "float",
			close_on_exit = true,
			float_opts = {
				border = "double",
				width = math.floor(vim.o.columns * 0.8),
				height = math.floor(vim.o.lines * 0.2),
				row = math.floor(vim.o.lines * 0.7), -- 画面の70%の高さから開始（下寄せ）
				col = math.floor((vim.o.columns - vim.o.columns * 0.8) / 2), -- 中央寄せ
				winblend = 30,
			},
			highlights = {
				FloatBorder = {
					guifg = "#ff8800", -- 明るめのオレンジで目立つ枠線
				},
			},
		},
	},
}
