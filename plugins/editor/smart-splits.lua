
return {
	"mrjones2014/smart-splits.nvim",
	dependencies = { "nvimtools/hydra.nvim" },
	config = function()
		require("smart-splits").setup({
			-- リサイズの量（デフォルトは3、少し大きめに5に設定）
			default_amount = 5,
			-- サイドバー系のバッファのみを無視（ターミナルは含めない）
			ignored_filetypes = {
				"neo-tree",
			},
			ignored_buftypes = {
				"nofile",
				"quickfix",
				"prompt",
			},
		})

		-- ウィンドウ移動（既存のCtrl+hjklを置き換え）
		vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left, { desc = "Move to left window" })
		vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down, { desc = "Move to down window" })
		vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "Move to up window" })
		vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right, { desc = "Move to right window" })

		-- ターミナルモードからのウィンドウ移動
		-- Claude Codeのターミナルと干渉するため、左右のみに制限
		vim.keymap.set("t", "<C-h>", function()
			vim.cmd("stopinsert")
			require("smart-splits").move_cursor_left()
		end, { desc = "Move to left window from terminal" })
		vim.keymap.set("t", "<C-l>", function()
			vim.cmd("stopinsert")
			require("smart-splits").move_cursor_right()
		end, { desc = "Move to right window from terminal" })

		-- Hydraを使ったリサイズモード
		local Hydra = require("hydra")
		local resize_hydra = Hydra({
			name = "Window Resize",
			mode = "n",
			body = "<leader>r", -- スペース + r でリサイズモードに入る
			hint = [[
  ^^^^        Resize Window
  ^^^^------------------------------
  ^ ^ _k_ ^ ^   _K_: +5 height
  _h_ ^ ^ _l_   _J_: -5 height
  ^ ^ _j_ ^ ^   _H_: -5 width
  ^^^^          _L_: +5 width
  ^^^^
  ^ ^ _q_: exit
]],
			config = {
				color = "pink", -- 連打可能、ESCで抜ける
				invoke_on_body = true,
				hint = {
					float_opts = {
						border = "rounded",
					},
					position = "bottom",
				},
			},
			heads = {
				-- 基本のリサイズ（hjkl）
				{ "h", require("smart-splits").resize_left, { desc = "resize left" } },
				{ "j", require("smart-splits").resize_down, { desc = "resize down" } },
				{ "k", require("smart-splits").resize_up, { desc = "resize up" } },
				{ "l", require("smart-splits").resize_right, { desc = "resize right" } },

				-- 大きくリサイズ（HJKL - Shift + hjkl）
				{
					"H",
					function()
						require("smart-splits").resize_left(10)
					end,
					{ desc = "resize left more" },
				},
				{
					"J",
					function()
						require("smart-splits").resize_down(10)
					end,
					{ desc = "resize down more" },
				},
				{
					"K",
					function()
						require("smart-splits").resize_up(10)
					end,
					{ desc = "resize up more" },
				},
				{
					"L",
					function()
						require("smart-splits").resize_right(10)
					end,
					{ desc = "resize right more" },
				},

				-- 終了
				{ "q", nil, { exit = true, desc = "exit" } },
				{ "<Esc>", nil, { exit = true, desc = "exit" } },
			},
		})

		-- ターミナルモードからもリサイズモードに入れるようにする
		vim.keymap.set("t", "<leader>r", function()
			vim.cmd("stopinsert") -- ターミナルモードを抜ける
			resize_hydra:activate() -- リサイズモードをアクティベート
		end, { desc = "Enter resize mode from terminal" })
	end,
}

