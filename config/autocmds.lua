-- ===================================================================
-- Autocmd設定
-- ===================================================================
-- このファイルは自動コマンド（イベント駆動の処理）を管理します

local autocmd = vim.api.nvim_create_autocmd

-- ===== ウィンドウフォーカス視覚化 =====
-- アクティブなウィンドウでのみcursorlineを表示
autocmd({ "WinEnter", "BufEnter" }, {
	pattern = "*",
	callback = function()
		vim.opt_local.cursorline = true
	end,
	desc = "Enable cursorline in active window",
})

autocmd({ "WinLeave", "BufLeave" }, {
	pattern = "*",
	callback = function()
		vim.opt_local.cursorline = false
	end,
	desc = "Disable cursorline in inactive window",
})

-- ===== ファイルタイプ検出 =====
-- .template / .conf ファイルをnginxとしてハイライト
autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.template", "*.conf" },
	callback = function()
		vim.bo.filetype = "nginx"
	end,
	desc = "Detect .template/.conf files as nginx config",
})

-- ===== View保存（折りたたみ・カーソル位置） =====
-- 保存時に view を保存
autocmd("BufWritePost", {
	pattern = "*",
	callback = function()
		if vim.fn.expand("%") ~= "" and not vim.bo.buftype:match("nofile") then
			vim.cmd("mkview")
		end
	end,
	desc = "Save view on write",
})

-- 読み込み時に view を読み込む
autocmd("BufRead", {
	pattern = "*",
	callback = function()
		if vim.fn.expand("%") ~= "" and not vim.bo.buftype:match("nofile") then
			vim.cmd("silent! loadview")
		end
	end,
	desc = "Load view on read",
})
