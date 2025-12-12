return {
	"mason-org/mason.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"mason-org/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- mason自体のセットアップ
		require("mason").setup()

		-- デフォルトのcapabilitiesを取得
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- 全サーバー共通のデフォルト設定
		vim.lsp.config["*"] = {
			capabilities = capabilities,
		}

		-- lua_ls専用の設定
		vim.lsp.config.lua_ls = {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		}

		-- mason-lspconfigのセットアップ
		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "terraformls", "marksman", "clangd" },
		})
	end,
}
