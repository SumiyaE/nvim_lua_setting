return {
	"EdenEast/nightfox.nvim",
	config = function()
		vim.cmd("colorscheme Nordfox")
		vim.cmd("highlight! link WinSeparator GlyphPalette2")
		vim.cmd("highlight! Visual guibg=#4a3332")

		-- アクティブなウィンドウを明るくする
		vim.cmd("highlight! Normal guibg=#2e3440 guifg=#d8dee9")

		-- アクティブなウィンドウのカーソル行をより明るく
		vim.cmd("highlight! CursorLine guibg=#3b4252")
		vim.cmd("highlight! CursorLineNr guifg=#88c0d0 gui=bold")

		-- 非アクティブなウィンドウをかなり暗くする（背景と文字色）
		vim.cmd("highlight! NormalNC guibg=#1a1f28 guifg=#5a657d")

		-- ウィンドウの境界線を明るく見やすくする
		vim.cmd("highlight! WinSeparator guifg=#81a1c1 gui=bold")

		-- 非アクティブなウィンドウの行番号
		vim.cmd("highlight! LineNrNC guifg=#3b4252")
	end,
}
