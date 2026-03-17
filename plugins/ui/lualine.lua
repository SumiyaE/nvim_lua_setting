return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- 現在のリポジトリ情報（BufEnterで更新）
		local current_repo = {
			color = nil,
			color_light = nil,
			name = nil,
		}

		-- HSL to RGB変換
		local function hsl_to_rgb(h, s, l)
			local r, g, b
			if s == 0 then
				r, g, b = l, l, l
			else
				local function hue2rgb(p, q, t)
					if t < 0 then t = t + 1 end
					if t > 1 then t = t - 1 end
					if t < 1/6 then return p + (q - p) * 6 * t end
					if t < 1/2 then return q end
					if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end
					return p
				end
				local q = l < 0.5 and l * (1 + s) or l + s - l * s
				local p = 2 * l - q
				r = hue2rgb(p, q, h / 360 + 1/3)
				g = hue2rgb(p, q, h / 360)
				b = hue2rgb(p, q, h / 360 - 1/3)
			end
			return string.format("#%02x%02x%02x", r * 255, g * 255, b * 255)
		end

		-- リポジトリ情報を非同期で更新する関数
		local function update_repo_info()
			local buf_path = vim.fn.expand("%:p:h")
			if buf_path == "" then
				buf_path = vim.fn.getcwd()
			end

			vim.system(
				{ "git", "rev-parse", "--show-toplevel" },
				{ cwd = buf_path, text = true },
				function(obj)
					vim.schedule(function()
						if obj.code ~= 0 or not obj.stdout or obj.stdout == "" then
							current_repo = { color = nil, color_light = nil, name = nil }
							return
						end

						-- リポジトリ名を取得（改行や空白を除去）
						local repo_name = obj.stdout:gsub("%s+", ""):match("([^/]+)$") or "default"

						-- リポジトリ名 + 日付からハッシュ値を生成（毎日色が変わる）
						local date_str = os.date("%Y-%m-%d")
						local hash_input = repo_name .. date_str
						local hash = 0
						for i = 1, #hash_input do
							hash = (hash * 31 + hash_input:byte(i)) % 16777216
						end

						-- HSLで彩度と明度を固定し、色相だけ変える
						local hue = (hash % 360)
						local saturation = 0.7
						local lightness = 0.5

						current_repo = {
							color = hsl_to_rgb(hue, saturation, lightness),
							color_light = hsl_to_rgb(hue, saturation * 0.6, lightness * 1.3),
							name = repo_name,
						}

						if package.loaded["lualine"] then
							require("lualine").refresh()
						end
					end)
				end
			)
		end

		-- BufEnterでリポジトリ情報を更新（非同期）
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "WinEnter", "FocusGained" }, {
			callback = function()
				update_repo_info()
			end,
		})

		-- 初回更新
		update_repo_info()

		-- 色取得関数（シンプルに現在のリポジトリ情報を返す）
		local function get_repo_color()
			return current_repo.color, current_repo.name
		end

		local function get_repo_color_light()
			return current_repo.color_light
		end

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
						-- リポジトリ名（色付き）
						function()
							local _, repo_name = get_repo_color()
							return "󰉋 " .. (repo_name or "")
						end,
						color = function()
							local repo_color = get_repo_color()
							if repo_color then
								return { bg = repo_color, fg = "#1d2021", gui = "bold" }
							end
							return { bg = colors.orange, fg = colors.bg, gui = "bold" }
						end,
						cond = function()
							return get_repo_color() ~= nil
						end,
						separator = { right = "" },
						padding = { left = 1, right = 1 },
					},
					{
						"mode",
						fmt = function(str)
							return str:sub(1, 1)
						end,
						color = function()
							local repo_color = get_repo_color()
							if repo_color then
								return { bg = repo_color, fg = "#1d2021", gui = "bold" }
							end
							return { bg = colors.orange, fg = colors.bg, gui = "bold" }
						end,
					},
				},
				lualine_b = {
					{
						"branch",
						icon = "⎇",
						color = function()
							local light = get_repo_color_light()
							if light then
								return { bg = light, fg = "#1d2021" }
							end
							return { bg = colors.dark_orange, fg = colors.fg }
						end,
					},
					{
						"diff",
						symbols = { added = " ", modified = " ", removed = " " },
						-- 薄いグレー背景で固定（色付き記号は維持）
						color = { bg = "#3c3836", fg = "#ebdbb2" },
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
						color = { bg = "#282828", fg = "#ebdbb2" },
					},
					{
						"diagnostics",
						sources = { "nvim_lsp" },
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
						color = { bg = "#282828" },
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
						color = function()
							local repo_color = get_repo_color()
							if repo_color then
								return { fg = repo_color }
							end
							return { fg = "#fe8019" }
						end,
					},
					{
						"filetype",
						colored = false,
						icon_only = false,
						color = function()
							local light = get_repo_color_light()
							if light then
								return { fg = light }
							end
							return { fg = "#fe8019" }
						end,
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
						color = function()
							local light = get_repo_color_light()
							if light then
								return { bg = light, fg = "#1d2021" }
							end
							return { bg = colors.dark_orange, fg = colors.fg }
						end,
					},
					{
						"progress",
						fmt = function()
							local cur = vim.fn.line(".")
							local total = vim.fn.line("$")
							return string.format("%d/%d", cur, total)
						end,
						color = function()
							local light = get_repo_color_light()
							if light then
								return { bg = light, fg = "#1d2021" }
							end
							return { bg = colors.dark_orange, fg = colors.fg }
						end,
					},
				},
				lualine_z = {
					{
						"location",
						fmt = function(str)
							return " " .. str
						end,
						color = function()
							local repo_color = get_repo_color()
							if repo_color then
								return { bg = repo_color, fg = "#1d2021", gui = "bold" }
							end
							return { bg = colors.orange, fg = colors.bg, gui = "bold" }
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
