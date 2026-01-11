return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- LSP補完
		"hrsh7th/cmp-buffer", -- 現在のバッファ内の単語補完
		"hrsh7th/cmp-path", -- ファイルパス補完
		"hrsh7th/cmp-cmdline",
		"onsails/lspkind.nvim", -- 補完候補にアイコンを表示
		-- スニペット
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		local luasnip = require("luasnip")

		-- friendly-snippets を読み込み
		require("luasnip.loaders.from_vscode").lazy_load()
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

		-- Copilot の suggestion モジュール
		local has_copilot, copilot_suggestion = pcall(require, "copilot.suggestion")

		-- キー操作のマッピング設定
		local mapping = cmp.mapping.preset.insert({
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			-- スーパータブ: Copilot → スニペット → 補完 → Tab
			["<Tab>"] = cmp.mapping(function(fallback)
				if has_copilot and copilot_suggestion.is_visible() then
					copilot_suggestion.accept()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end, { "i", "s" }),
			-- Shift+Tab: スニペット戻る → 補完戻る → Shift+Tab
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				elseif cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end, { "i", "s" }),
		})

		-- 補完の情報源（source）の定義
		local sources = {
			{ name = "luasnip" }, -- スニペット
			{ name = "nvim_lsp" },
			{ name = "buffer" },
			{ name = "path" },
		}

		-- 最終的な cmp 設定
		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
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
