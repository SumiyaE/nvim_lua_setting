return {
	"sunjon/Shade.nvim",
	enabled = false, -- Masonなど他のプラグインとの互換性問題のため無効化
	config = function()
		-- Shade.nvimの自動イベントを無効化
		vim.g.shade_disable_autostart = 1

		require("shade").setup({
			overlay_opacity = 50, -- 非アクティブなウィンドウの暗さ（0-100、値が大きいほど暗い）
			opacity_step = 1, -- 不透明度の変更ステップ
			keys = {
				brightness_up = "<C-Up>", -- 明るさを上げる
				brightness_down = "<C-Down>", -- 明るさを下げる
				toggle = "<Leader>s", -- Shadeのオン/オフ切り替え
			},
			exclude_filetypes = {
				"snacks_terminal",
				"snacks_win",
				"snacks_input",
				"snacks",
				"mason",
			},
			exclude_buftypes = {
				"terminal",
				"nofile",
				"prompt",
			},
		})

		-- Shade.nvimの内部イベントハンドラを無効化
		vim.api.nvim_create_augroup("shade_events", { clear = true })

		-- 独自の安全なイベントハンドラを設定
		local shade_group = vim.api.nvim_create_augroup("ShadeProtection", { clear = true })

		-- WinEnterイベントの安全な処理
		vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained" }, {
			group = shade_group,
			callback = function()
				vim.schedule(function()
					local current_win = vim.api.nvim_get_current_win()
					-- ウィンドウの有効性を確認
					if not vim.api.nvim_win_is_valid(current_win) then
						return
					end

					-- バッファタイプとfiletypeを確認
					local ok, bufnr = pcall(vim.api.nvim_win_get_buf, current_win)
					if not ok then
						return
					end

					local ft = vim.bo[bufnr].filetype
					local bt = vim.bo[bufnr].buftype

					-- 除外するfiletypeとbuftypeをチェック
					local exclude_ft = { "snacks_terminal", "snacks_win", "snacks_input", "snacks", "mason" }
					local exclude_bt = { "terminal", "nofile", "prompt" }

					for _, excluded in ipairs(exclude_ft) do
						if ft == excluded then
							return
						end
					end

					for _, excluded in ipairs(exclude_bt) do
						if bt == excluded then
							return
						end
					end

					-- 安全にShadeを適用
					pcall(function()
						require("shade").refresh()
					end)
				end)
			end,
		})
	end,
}
