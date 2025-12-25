return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
	config = function(_, opts)
		require("obsidian").setup(opts)

		-- 週ディレクトリ対応の日記オープン関数
		local function open_daily_note(days_offset)
			days_offset = days_offset or 0
			local notes_dir = vim.fn.expand("~/notes/📅 日記")

			-- 対象日付を計算
			local target_date = os.time() + (days_offset * 24 * 60 * 60)
			local date_str = os.date("%Y年%m月%d日", target_date)

			-- 週の月曜日と日曜日を計算
			local wday = tonumber(os.date("%w", target_date))
			if wday == 0 then wday = 7 end  -- 日曜日を7に
			local monday_offset = -(wday - 1)
			local sunday_offset = 7 - wday

			local monday = target_date + (monday_offset * 24 * 60 * 60)
			local sunday = target_date + (sunday_offset * 24 * 60 * 60)

			local monday_str = os.date("%Y年%m月%d日", monday)
			local sunday_str = os.date("%m月%d日", sunday)

			-- 週ディレクトリ名を生成
			local week_dir = monday_str .. "~" .. sunday_str
			local week_path = notes_dir .. "/" .. week_dir

			-- ディレクトリが存在しなければ作成
			vim.fn.mkdir(week_path, "p")

			-- 日記ファイルを開く
			local file_path = week_path .. "/" .. date_str .. ".md"
			vim.cmd("edit " .. vim.fn.fnameescape(file_path))
		end

		-- キーマッピング
		vim.keymap.set("n", "<leader>ot", function() open_daily_note(0) end, { desc = "Open today's daily note" })
		vim.keymap.set("n", "<leader>oy", function() open_daily_note(-1) end, { desc = "Open yesterday's daily note" })
		vim.keymap.set("n", "<leader>om", function() open_daily_note(1) end, { desc = "Open tomorrow's daily note" })
	end,
	opts = {
		workspaces = {
			{
				name = "scratches",
				path = "~/notes/",
			},
		},
		ui = {
			enable = true, -- UI機能を有効化
		},
		daily_notes = {
			-- Optional, if you keep daily notes in a separate directory.
			folder = "📅 日記",
			date_format = "%Y年%m月%d日",
			-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
			template = nil,
		},

		note_path_func = function(spec)
			-- new note は現在のバッファと同じディレクトリに作る
			local current_dir = vim.fn.expand("%:p:h")
			return require("plenary.path"):new(current_dir) / (spec.id .. ".md")
		end,
		note_id_func = function(title)
			if title ~= nil then
				return title:gsub('[\\/:%*%?"<>|]', "")
			else
				return tostring(os.time())
			end
		end,
	},
}
