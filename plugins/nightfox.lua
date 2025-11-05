return {
	"EdenEast/nightfox.nvim",
	config = function()
		vim.cmd("colorscheme Nordfox")
		vim.cmd("highlight! link WinSeparator GlyphPalette2")
		vim.cmd("highlight! Visual guibg=#4a3332")

		-- 非アクティブなウィンドウをかなり暗くする（背景と文字色）
		vim.cmd("highlight! NormalNC guibg=#1a1f28 guifg=#5a657d")

		-- ウィンドウの境界線を明るく見やすくする
		vim.cmd("highlight! WinSeparator guifg=#81a1c1 gui=bold")

		-- 非アクティブなウィンドウ用の薄い色のシンタックスハイライト
		vim.cmd("highlight! KeywordNC guifg=#5a7a9a guibg=#1a1f28")
		vim.cmd("highlight! FunctionNC guifg=#6a8aa8 guibg=#1a1f28")
		vim.cmd("highlight! StringNC guifg=#6a8870 guibg=#1a1f28")
		vim.cmd("highlight! CommentNC guifg=#4a5568 guibg=#1a1f28 gui=italic")
		vim.cmd("highlight! ConstantNC guifg=#7a8a9a guibg=#1a1f28")
		vim.cmd("highlight! TypeNC guifg=#6a8aa0 guibg=#1a1f28")
		vim.cmd("highlight! IdentifierNC guifg=#5a6a7a guibg=#1a1f28")
		vim.cmd("highlight! OperatorNC guifg=#5a6a7a guibg=#1a1f28")
		vim.cmd("highlight! SpecialNC guifg=#6a7a8a guibg=#1a1f28")
		vim.cmd("highlight! LineNrNC guifg=#3b4252")
	end,
}
