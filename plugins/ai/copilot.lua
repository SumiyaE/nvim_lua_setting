return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot", -- :Copilotコマンドが実行されたときにプラグインを読み込む
	event = "BufReadPost", -- ファイルが読み込まれた後にプラグインをロード. https://vim-jp.org/vimdoc-ja/autocmd.html
	opts = {
		suggestion = {
			auto_trigger = true,
			keymap = {
				-- Tab は cmp.lua のスーパータブで管理
				accept = false,
			},
		},
		filetypes = {
			markdown = true,
		},
	},
}
