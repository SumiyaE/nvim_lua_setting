return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({
			pickers = {
				find_files = {
					-- 隠しファイル（.githubなど）を検索対象に含める
					-- .gitignoreは引き続き尊重される
					hidden = true,
				},
			},
		})

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope: Find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope: Live grep" })
		vim.keymap.set("v", "<leader>fg", '"zy<cmd>Telescope grep_string search=<C-r>z<CR>', { desc = "Telescope: Grep selection" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope: Find buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope: Help tags" })
		vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Telescope: Resume last search" })
		vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Telescope: Recent files" })
	end,
}
