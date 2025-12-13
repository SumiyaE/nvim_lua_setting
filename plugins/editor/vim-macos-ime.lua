return {
	"laishulu/vim-macos-ime",
	enabled = function()
		return vim.uv.os_uname().sysname == "Darwin"
	end,
	event = { "InsertEnter" },
	init = function()
		vim.g.macosime_normal_ime = "com.apple.keylayout.ABC"
		vim.g.macosime_cjk_ime = "com.apple.inputmethod.Kotoeri.RomajiTyping.Japanese"
	end,
}
