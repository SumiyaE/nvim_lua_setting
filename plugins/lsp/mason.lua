return {
	"williamboman/mason.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		-- mason自体のセットアップ
		require("mason").setup()

		-- デフォルトのcapabilitiesを全サーバーに適用
		vim.lsp.config["*"] = {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		}

		-- lua_ls専用の設定
		vim.lsp.config.lua_ls = {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		}

		-- mason-lspconfigのセットアップ（自動でvim.lsp.enable()を呼び出す）
		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "terraformls", "marksman", "clangd" },
		})
	end,
}
