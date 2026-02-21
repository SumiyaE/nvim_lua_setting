return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree",
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle Neo-tree" },
		{ "<leader>b", "<cmd>Neotree reveal<CR>", desc = "Find current file in Neo-tree" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			-- ディレクトリを開いた時にneo-treeで表示
			hijack_netrw_behavior = "open_current",
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
				follow_current_file = {
					enabled = true,
				},
				group_empty_dirs = true,
				commands = {
					-- 相対パスをコピー
					copy_path = function(state)
						local node = state.tree:get_node()
						local filepath = node:get_id()
						local relative_path = vim.fn.fnamemodify(filepath, ":.")
						vim.fn.setreg("+", relative_path)
						vim.notify("Copied: " .. relative_path)
					end,
					-- 絶対パスをコピー
					copy_absolute_path = function(state)
						local node = state.tree:get_node()
						local filepath = node:get_id()
						vim.fn.setreg("+", filepath)
						vim.notify("Copied: " .. filepath)
					end,
				},
				window = {
					mappings = {
						["Y"] = "copy_path",
						["gy"] = "copy_absolute_path",
					},
				},
			},
			source_selector = {
				winbar = true,
			},
			window = {
				position = "left",
				width = 30,
				mappings = {
					["<Tab>"] = "noop", -- グローバルなTabマッピングを無効化
					["<S-Tab>"] = "noop", -- グローバルなShift+Tabマッピングを無効化
					["<C-x>"] = "noop", -- グローバルなCtrl+xマッピングを無効化
				},
			},
		})

	end,
}
