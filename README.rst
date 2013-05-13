====================================================
fixgaepath.vim - Google Appengine への path を解決！
====================================================

Vim で Google Appengine の開発を快適に行えるようにするために、
jedi-vim (http://github.com/davidhalter/jedi-vim) による補完機能や
ジャンプ機能などを、Google Appengine 用に調整します。


概要
====

fixgaepath.vim は、Vim 内で実行される Python のシステムパスに、
Google Appengine の SDK に含まれるパッケージ群へのパスを追加します。
また、開いているファイルを含むディレクトリから app.yaml ファイルを
再帰的に検索して、開発中のプロジェクトのトップディレクトリを特定し、
そのディレクトリも Python のシステムパスに追加します。


環境変数
========

fixgaepath.vim では、次のグローバル変数を使用しています。
.vimrc などに設定して使用してください。

g:fixgaepath_sdk_path
    Google Appengine for Python の SDK へのパスを指定します。


使用方法
========

fixgaepath.vim を実行するには、プロジェクトに含まれるファイルを開いた状態で、
``:FixGaePath`` コマンドを実行してください。
