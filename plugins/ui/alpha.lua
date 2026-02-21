return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local startify = require("alpha.themes.startify")

		-- ヘッダーを大きく中央に
		startify.section.header.val = {
			[[                                                    ]],
			[[  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
			[[  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
			[[  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
			[[  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
			[[  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
			[[  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
			[[                                                    ]],
		}
		startify.section.header.opts = { hl = "Type", position = "center" }

		-- ボタン
		startify.section.top_buttons.val = {
			startify.button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
			startify.button("g", "  Find text", ":Telescope live_grep <CR>"),
			startify.button("s", "  Restore session", [[<cmd>lua require("persistence").load()<cr>]]),
			startify.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
		}

		startify.section.bottom_buttons.val = {
			startify.button("l", "󰒲  Lazy", ":Lazy <CR>"),
			startify.button("q", "  Quit", ":qa<CR>"),
		}

		-- カレントディレクトリの最近のファイル（10件）
		startify.section.mru_cwd.val = {
			{ type = "padding", val = 1 },
			{ type = "text", val = "  Recent Files (Current Directory)", opts = { hl = "SpecialComment", shrink_margin = false } },
			{ type = "padding", val = 1 },
			{
				type = "group",
				val = function()
					return { startify.mru(0, vim.fn.getcwd(), 10) }
				end,
				opts = { shrink_margin = false },
			},
		}

		-- グローバルの最近のファイル（3件）
		startify.section.mru.val = {
			{ type = "padding", val = 1 },
			{ type = "text", val = "  Recent Files (Global)", opts = { hl = "SpecialComment", shrink_margin = false } },
			{ type = "padding", val = 1 },
			{
				type = "group",
				val = function()
					return { startify.mru(10, false, 3) }
				end,
				opts = { shrink_margin = false },
			},
		}

		alpha.setup(startify.opts)

		-- nvim . でディレクトリを開いた場合、ディレクトリバッファを閉じてalphaを表示
		if vim.fn.argc(-1) == 1 then
			local stat = vim.uv.fs_stat(vim.fn.argv(0))
			if stat and stat.type == "directory" then
				vim.cmd.bdelete()
				require("alpha").start()
			end
		end
	end,
}
