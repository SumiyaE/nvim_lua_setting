return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- オレンジをメインにしたカスタムテーマ
		local colors = {
			bg = "#282828",
			fg = "#ebdbb2",
			orange = "#fe8019",
			bright_orange = "#ff9933",
			dark_orange = "#d65d0e",
			gray = "#928374",
		}

		local custom_theme = {
			normal = {
				a = { bg = colors.orange, fg = colors.bg, gui = "bold" },
				b = { bg = colors.dark_orange, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			insert = {
				a = { bg = colors.bright_orange, fg = colors.bg, gui = "bold" },
				b = { bg = colors.dark_orange, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			visual = {
				a = { bg = colors.dark_orange, fg = colors.bg, gui = "bold" },
				b = { bg = colors.orange, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			replace = {
				a = { bg = colors.bright_orange, fg = colors.bg, gui = "bold" },
				b = { bg = colors.orange, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			command = {
				a = { bg = colors.orange, fg = colors.bg, gui = "bold" },
				b = { bg = colors.dark_orange, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			inactive = {
				a = { bg = colors.gray, fg = colors.bg },
				b = { bg = colors.bg, fg = colors.gray },
				c = { bg = colors.bg, fg = colors.gray },
			},
		}

		require("lualine").setup({
			options = {
				theme = custom_theme,
				icons_enabled = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" }, -- 三角に尖った形
				globalstatus = true, -- 1つのステータスラインを全ウィンドウで共有
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return str:sub(1, 1) -- 最初の1文字のみ表示（N, I, V等）
						end,
					},
				},
				lualine_b = {
					{
						"branch",
						icon = "",
					},
					{
						"diff",
						symbols = { added = " ", modified = " ", removed = " " },
					},
				},
				lualine_c = {
					{
						"filename",
						path = 1, -- 相対パス表示
						symbols = {
							modified = " ●",
							readonly = " ",
							unnamed = "[No Name]",
						},
					},
					{
						"diagnostics",
						sources = { "nvim_lsp" },
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
					},
				},
				lualine_x = {
					{
						-- LSPサーバー表示
						function()
							local clients = vim.lsp.get_clients({ bufnr = 0 })
							if #clients == 0 then
								return ""
							end
							local names = {}
							for _, client in ipairs(clients) do
								table.insert(names, client.name)
							end
							return " " .. table.concat(names, ", ")
						end,
						color = { fg = "#fe8019" }, -- オレンジ色
					},
					{
						"filetype",
						colored = true,
						icon_only = false,
					},
					{
						-- インデント情報
						function()
							if vim.bo.expandtab then
								return "␣" .. vim.bo.shiftwidth
							else
								return "⇥" .. vim.bo.tabstop
							end
						end,
					},
				},
				lualine_y = {
					{
						-- 現在時刻
						function()
							return " " .. os.date("%H:%M")
						end,
					},
					{
						"progress",
						fmt = function()
							local cur = vim.fn.line(".")
							local total = vim.fn.line("$")
							return string.format("%d/%d", cur, total)
						end,
					},
				},
				lualine_z = {
					{
						"location",
						fmt = function(str)
							return " " .. str
						end,
					},
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			extensions = { "neo-tree", "lazy" },
		})
	end,
}
