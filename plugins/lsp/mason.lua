return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		-- mason自体のセットアップ
		require("mason").setup()

		-- mason-lspconfigのセットアップ
		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "terraformls", "marksman", "clangd" },
		})

		-- デフォルトのcapabilitiesを取得
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- lspサーバーを自動で設定
		require("mason-lspconfig").setup_handlers({
			-- デフォルトハンドラー
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
				})
			end,
			-- lua_ls専用の設定
			["lua_ls"] = function()
				require("lspconfig").lua_ls.setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				})
			end,
		})
	end,
}
