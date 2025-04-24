# Install

## Install Nvim

### for Mac

```bash
# install neovim with brew
brew install neovim

# create nvim setting directory
cd ~/.config/
git clone https://github.com/SumiyaE/nvim_lua_setting.git nvim
```

## 各プラグインの説明

----
現在のnvimの設定はlazy.nvimを使用して管理している。
そもそもlazy.nvimが何をしているのかわかっていない上に、luaも雰囲気で書いている状態なので改めて設定を調べてまとめる。

ディレクトリ構成としては以下のようになっている。

```bash
~/.config/nvim
├── init.lua
├── lazy-lock.json
├── pack
├── lua
│   ├── plugins
│   │   ├──telescope.lua
│   │   ├──treesitter.lua
│   │   ├──etc......luaで書かれた各種プラグイン
│   ├── confg
│   │   ├──lazy.lua 
│   ├── readme.md
```

init.luaでlazy.luaを読見込み

```init.lua
require("config.lazy")
```

さらに、lazy.luaの中で各種プラグインを読み込んでいる。

```lazy.lua
-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
})
```

## lazy.nvimとは？
neovimのプラグインマネージャーの一つ。  
参考：[lazy.nvimの使い方から起動を爆速にする方法までを解説](https://eiji.page/blog/neovim-lazy-nvim-intro/)


## lazy.luaがなぜnvimの起動時に読み込まれているのか？
neovimが、~/.config/nvim/init.luaに書かれている設定を自動で読み込むような仕組みになっている。
また、neovimでluaが使えるようになったのは、2021年の7月ごろにリリースされたversion 0.5からだそう。

> It is also possible to write user configuration in Lua: If there is an init.lua, it is read instead of init.vim (these cannot coexist, and having both in your config directory will give an error), and .lua files in runtime directories (plugin/, colorscheme/, after/ etc.) are sourced in addition to (after) Vimscript files.

参考：https://neovim.io/news/2021/07?utm_source=chatgpt.com


## init.luaからlazy.luaを読み込む時にはrequireを使っているが、lazy.luaからpluginsを読み込む時にはrequireを使っていないのはなぜか？
requireは、luaの標準ライブラリで、モジュールを読み込むための関数。
lazy.luaが実行しているsetup関数は、lazy.nvimの関数で、モジュールを読み込むためのものではないためrequireを使っていない。


## lazy.luaの中で実行されるrequire("lazy")の`lazy`は何を指しているのか？
~/.local/share/nvim/lazy/lazy.nvimを指している。ここをlazy.nvimのインストール先として指定しているのが、以下の記述。
```lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

```

```lua  

---
## 不明点
- [ ] Q.そもそもlazy.nvimとは何か？
- [ ] Q.lazy.luaがなぜnvimの起動時に読み込まれているのか？
- [ ] Q.lazy.luaに記載されている以下の記述が何を指しているのか？
```lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
```
- [ ] Q.init.luaからlazy.luaを読み込む時にはrequireを使っているが、lazy.luaからpluginsを読み込む時にはrequireを使っていないのはなぜか？
- [ ] Q.lazy.luaの中で実行されるrequire("lazy")の`lazy`は何を指しているのか？

```
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
})
```

動作確認のために編集
 
## なぐりがき
lazygitのおかげでかなりeditorのようになった。
terraformぐらいの書き方が決まっている言語であれば、vimで開発しても良いぐらい快適になってきた。
とはいえ、terraformを使用するときにコード補完ができていないので、そこを解消したい

編集が反映されるか確認
