return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "catppuccin",
				icons_enabled = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
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
						"filetype",
						colored = true,
						icon_only = false,
					},
				},
				lualine_y = {
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
			extensions = { "nvim-tree", "lazy" },
		})
	end,
}
