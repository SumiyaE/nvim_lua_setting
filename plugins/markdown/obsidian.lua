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
	opts = {
		workspaces = {
			{
				name = "scratches",
				path = "~/notes/",
			},
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
