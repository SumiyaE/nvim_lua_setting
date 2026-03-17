return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- LSP補完
		"hrsh7th/cmp-buffer", -- 現在のバッファ内の単語補完
		"hrsh7th/cmp-path", -- ファイルパス補完
		"hrsh7th/cmp-cmdline",
		"onsails/lspkind.nvim", -- 補完候補にアイコンを表示
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		vim.opt.completeopt = { "menu", "menuone", "noinsert" }
		-- 補完候補のフォーマット設定（アイコン付き）
		local formatting = {
			format = lspkind.cmp_format({
				mode = "symbol", -- "symbol_text" にすると文字＋アイコン
				maxwidth = 50,
				ellipsis_char = "...",
			}),
		}

		-- 補完ポップアップの見た目設定
		local window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		}

		-- キー操作のマッピング設定
		local mapping = cmp.mapping.preset.insert({
			["<CR>"] = cmp.mapping.confirm({ select = true }),
		})

		-- 補完の情報源（source）の定義
		local sources = {
			{ name = "nvim_lsp" },
			{ name = "buffer" },
			{ name = "path" },
		}

		-- 最終的な cmp 設定
		cmp.setup({
			formatting = formatting,
			window = window,
			mapping = mapping,
			sources = sources,
		})

		-- cmdline 用補完設定
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}
