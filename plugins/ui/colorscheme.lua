return {
	"morhetz/gruvbox",
	priority = 1000,
	config = function()
		-- Gruvbox設定
		vim.g.gruvbox_contrast_light = "soft" -- soft, medium, hard
		vim.g.gruvbox_italic = 1
		vim.g.gruvbox_bold = 1
		vim.g.gruvbox_underline = 1
		vim.g.gruvbox_undercurl = 1

		-- 背景を明るいモードに設定
		vim.opt.background = "light"

		vim.cmd.colorscheme("gruvbox")
	end,
}
