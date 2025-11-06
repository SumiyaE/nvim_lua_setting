return {
	"sunjon/Shade.nvim",
	config = function()
		require("shade").setup({
			overlay_opacity = 50, -- 非アクティブなウィンドウの暗さ（0-100、値が大きいほど暗い）
			opacity_step = 1, -- 不透明度の変更ステップ
			keys = {
				brightness_up = "<C-Up>", -- 明るさを上げる
				brightness_down = "<C-Down>", -- 明るさを下げる
				toggle = "<Leader>s", -- Shadeのオン/オフ切り替え
			},
		})
	end,
}
