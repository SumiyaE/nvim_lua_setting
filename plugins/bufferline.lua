return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		options = {
			offsets = {
				{
					filetype = "NvimTree", -- 対象のサイドバーの filetype
					text = "File Explorer", -- サイドバー上に表示するテキスト（任意）
					highlight = "Directory", -- 表示テキストのハイライトグループ（任意）
					separator = true, -- 分割線を表示する（true か任意の文字）
				},
			},
		},
	},
}
