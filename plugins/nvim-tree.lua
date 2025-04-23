return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		require("nvim-tree").setup({
			sort_by = "case_sensitive",
			view = {
				width = 40,
				side = "left",
				preserve_window_proportions = true,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = false,
			},
		})
		-- キーマップ（例：<leader>e でトグル）
		vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

		-- 境界の色を変更
		vim.cmd([[highlight NvimTreeWinSeparator guifg=#888888 guibg=None]])
	end,
}
