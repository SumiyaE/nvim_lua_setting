## 今後やりたいこと
- [ ] obsidianとvimを連携させる
  - [ ] obsidian連携用のpluginがあるようなのでinstallする
  - [ ] obsidianのmcpをvimから実行できるようにする


- [ ] treeのサイドバーとwindowの切り替えを現在は<C-w>を2回押すことで切り替えているが、別のキーでも良いので一回で切り替えられるようにキーバインディングする。
- [ ] bufferの削除を現状は:bdといちいち打ち込んでいる状態なので、一発で削除できるようにしたい。
- [ ] terraformで補完が効くようにLSP等の設定をしっかり入れる。こうすれば、他の言語でvimの使用を開始できるはず！
- [ ] tsのlspを導入する（[参考](https://coralpink.github.io/commentary/neovim/lsp/mason.html)）
- [ ] Jiraのチケットの完了 & 作成をCLIから実行できるようにする。公式のCLIがあるようなのでそれを調べる。
- [ ] lazy.luaのファイルの中にキーマップやcmdの設定も入れているため、他のファイルに分割する。
- [ ] lazy.luaで読み込む全てのプラグインを起動時に入れるようにしている（ように思える）最適化すれば起動が早くなるかもしれないので、そもそものlazy.nvimの仕様を調べ、今の設定を最適化する。
- [ ] copilot.luaなるものがあるらしいので、現在のcopilotの設定をそれに置き換える。
- [ ] copilot.luaに変更したら逆に動かなくなったので、その理由を確認。[参考](https://github.com/zbirenbaum/copilot.lua/issues/443)
