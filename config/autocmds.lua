-- ===================================================================
-- Autocmd設定
-- ===================================================================
-- このファイルは自動コマンド（イベント駆動の処理）を管理します

local autocmd = vim.api.nvim_create_autocmd

-- ===== Markdown設定 =====
autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.conceallevel = 1
	end,
	desc = "Set conceallevel for Markdown files",
})

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

-- ===== Claude Code通知機能 =====
-- 手動通知コマンド
vim.api.nvim_create_user_command("ClaudeNotify", function()
	if pcall(require, "snacks") then
		require("snacks").notifier.notify("作業を確認してください", {
			title = "🤖 Claude Code",
			level = "info",
		})
	end
	vim.fn.system([[osascript -e 'display notification "作業を確認してください" with title "Claude Code"']])
	vim.cmd("echo '\a'")
end, { desc = "Send Claude Code notification" })

-- Claude Codeターミナルの自動通知
local claude_last_line_count = {}
autocmd({ "BufEnter", "TermEnter" }, {
	pattern = "*",
	callback = function()
		local bufname = vim.api.nvim_buf_get_name(0)
		if bufname:match("claudecode") or bufname:match("snacks_terminal") then
			local buf = vim.api.nvim_get_current_buf()
			local current_lines = vim.api.nvim_buf_line_count(buf)

			-- 前回の行数と比較して、増えていたら通知
			if claude_last_line_count[buf] and current_lines > claude_last_line_count[buf] + 5 then
				-- 5行以上増えていたら通知（Claude Codeが応答した可能性が高い）
				if pcall(require, "snacks") then
					require("snacks").notifier.notify("新しい応答があります", {
						title = "🤖 Claude Code",
						level = "info",
					})
				end
				vim.cmd("echo '\a'")
			end

			claude_last_line_count[buf] = current_lines
		end
	end,
	desc = "Claude Code terminal notification",
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
