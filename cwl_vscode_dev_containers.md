# Article：CWLの作成環境をVScodeの｢Dev Containers｣の機能を使って構築する(仮)

## はじめに

  

皆さんは｢ワークフロー言語｣をご存知でしょうか?

  

  

  

## バイオインフォマティクスにおけるデータ解析

バイオインフォマティクスにおけるデータ解析では、一つのツールのみで解析が終了することは極稀です｡ 通常､複数のツールを組み合わせて、大量のデータに対して一連のプロセスを繰り返し実行する必要があります。これらの作業手順は、ワークフロー(またはパイプライン)と呼ばれます。

  

しかし、手動でこれらの手順を繰り返すと、ヒューマンエラーに加え､異なる実行環境による再現性の問題が発生することがあります。このような場合に、ワークフロー言語を用いることで、各ステップを自動化し、かつ実行環境に依存せず解析の再現性を向上させる事ができます(以下のNatureの記事が参考になるかと思います)

  

#### **Workflow systems turn raw data into scientific knowledge**

[

doi.org

https://doi.org/10.1038/d41586-019-02619-z

](https://doi.org/10.1038/d41586-019-02619-z)

  

  

現在､さまざまな種類のワークフロー言語(Snakemake, Nextflow, Workflow Description language(WDL)...)が存在していますが、このドキュメントと統合TVの動画では**Common Workflow Language (CWL)** について紹介します。

  

実際にCWLを使って記述されたバイオインフォマティクスにおける解析ワークフローは数多くあります｡ 例えば､ヒトゲノムバリアント検出ワークフローである｢ddbj/human-reseq｣が挙げられます｡

  

#### ddbj/human-reseq

[

github.com

https://github.com/ddbj/human-reseq

](https://github.com/ddbj/human-reseq)

  

CWLについてより詳しく知りたい方は、日本語のドキュメントや書籍も多くあるので、ぜひ参考にしてください。

  

#### CWL日本語公式ドキュメント

[

github.com

https://github.com/pitagora-network/pitagora-cwl/wiki/CWL-Start-Guide-JP

](https://github.com/pitagora-network/pitagora-cwl/wiki/CWL-Start-Guide-JP)

  

#### Common Workflow Language入門

[https://oumpy.github.io/blog/2018/12/cwl.html](https://oumpy.github.io/blog/2018/12/cwl.html)

  

  

  

CWLの実行を行うcwltoolなどは、pipコマンドやcondaを使ってインストールすることが可能です。しかしながら､環境構築は大変な場合が多々あるかと思います。そこでこのドキュメントでは､作業するコンピュータの環境に依存せず、CWLの開発環境を作成して実行する方法を紹介します。

  

(※)なお､このドキュメントと統合TVの動画は､第13回 国内版バイオハッカソン(2022)にてアイデアをいただいて作成しています｡ 主な内容はQiitaの以下の記事がベースになっています｡ CWLに関してアドバイスをしてくださった石井さん､丹生さんにこの場をお借りして御礼申し上げます｡

  

[

qiita.com

https://qiita.com/tm\_tn/items/3fafe22e2c4a92a7f597

](https://qiita.com/tm_tn/items/3fafe22e2c4a92a7f597)

  

# 準備しよう

## 【STEP1-1】VScodeのインストール

  

はじめに、Visual Studio Code (VScode)のインストール方法を説明します。VScodeoといえばもはや業界で標準的なコードエディターになりつつあります｡ 特徴としては拡張機能が豊富に存在している部分であり､このドキュメントでもこの部分を活用します｡

  

ダウンロードは以下のページにアクセスしておこないます｡ 今回は､M1 Macを使用しているのでMac OS版のApple siliconをクリックします｡ 皆さんも自分のコンピュータの環境に合わせて選んでください｡

[

code.visualstudio.com

https://code.visualstudio.com/download

](https://code.visualstudio.com/download)

  

![](https://t907947.p.clickup-attachments.com/t907947/af629de7-baff-43bd-b8a3-d666c6e9f2c1/image.png)

｢Apple silicon｣をクリックしてインストールしました｡

  

  

## 【STEP1-2】拡張機能を導入する

  

環境構築の準備については､動画で見てもらったほうがわかりやすいかと思いますので､ここでは補足的な情報を主に記述しています｡

  

先程述べたように､VSCodeには豊富な拡張機能が存在します｡ サイドバー(ここでは左)の拡張機能のボタン(四角が4つあつまっている部分)を押すと､様々な拡張機能がMarketplaceで検索できます｡

  

ここで､｢Dev Containers｣ と検索してください｡ こちらが必要なのでインストールします(以前は｢Remote -Container extension｣という名前だったようですが､どうやら変わったようです)｡

![](https://t907947.p.clickup-attachments.com/t907947/8dede111-052d-4ea4-ba7c-007ed30335ed/image.png)

  

#### VScode公式サイトでの説明

[

code.visualstudio.com

https://code.visualstudio.com/docs/devcontainers/containers

](https://code.visualstudio.com/docs/devcontainers/containers)

  

インストールしたあと､よくよくみると....

![](https://t907947.p.clickup-attachments.com/t907947/a0ec0686-3952-4149-b1a7-6c0245a2f93b/image.png)

左下に｢ >< ｣というマークが出てきます｡  これでVScodeは一旦､準備完了です｡

  

  

この｢Dev Containers｣だけでなく､他の拡張機能を含んだ拡張機能パック｢Remote Development｣をインストールする方法もあるようです｡

![](https://t907947.p.clickup-attachments.com/t907947/c73afc83-d397-4826-b62c-de24f1d30ea1/image.png)

  

Dev containerに関する情報は以下の記事が参考になります｡ 開発環境を揃える､という点でこの機能は非常に重要なことがわかります｡

  

#### Devcontainer(Remote Container) いいぞという話 開発環境を整える

[

qiita.com

https://qiita.com/yoshii0110/items/c480e98cfe981e36dd56

](https://qiita.com/yoshii0110/items/c480e98cfe981e36dd56)

  

#### 開発コンテナ(Development Containers)を使おう

[

gist.github.com

https://gist.github.com/heronshoes/4e707bbc92ceee60d71fc09007e01d02#%E9%96%8B%E7%99%BA%E3%82%B3%E3%83%B3%E3%83%86%E3%83%8A%E3%81%A8%E3%81%AF%E4%BD%95%E3%81%8B

](https://gist.github.com/heronshoes/4e707bbc92ceee60d71fc09007e01d02#%E9%96%8B%E7%99%BA%E3%82%B3%E3%83%B3%E3%83%86%E3%83%8A%E3%81%A8%E3%81%AF%E4%BD%95%E3%81%8B)

  

  

(※) なお､自分は日本語で表示されるように拡張機能である｢Japanese Language Pack for Visual Studio Code｣もインストールしています｡ 本当に豊富にあるのでもはや手放せなくなりました｡

![](https://t907947.p.clickup-attachments.com/t907947/02f51be2-60bf-4e65-8518-2e9217d776d5/image.png)

  

この拡張機能を使って､新しく環境構築などを行う(VScodeから自分にあった環境をつくる､など) ことも可能ですが､今回はGitHubにすでに用意されているテンプレートを使って簡単に実行できる方法をご紹介します(【STEP3】に記載)｡

  

  

## 【STEP2】Docker Desktopのインストール

  

次にDocker Desktopをインストールします｡ 下のリンクから可能です｡ 今回はMac(Apple chip)版をインストールします｡

[

www.docker.com

https://www.docker.com/products/docker-desktop/

](https://www.docker.com/products/docker-desktop/)

  

ダッシュボードを開くと以下のようになっています｡

![](https://t907947.p.clickup-attachments.com/t907947/3d83459a-08c3-47b3-bb92-0e89060865a6/image.png)

  

  

## 【STEP3】GitHubからテンプレートを取得する

  

ここまででVScodeとdockerのインストールが完了しました｡ 次にCWLを実行する環境のテンプレートをGitHubから取得します｡ 以下のリポジトリ(tom-tan/cwl-for-remote-container-template)にアクセスしてください｡今回はこのリポジトリをテンプレートにして環境を作っていきます｡ このテンプレートでは既にシンタックスハイライトの機能があるCWL(Rabix/benten)などの拡張機能が使用できるように準備されています｡

  

[

github.com

https://github.com/tom-tan/cwl-for-remote-container-template

](https://github.com/tom-tan/cwl-for-remote-container-template)

  

  

ページ内の ｢Use this template｣ をクリックし､｢Create a new repository｣を選択すると､自分のアカウントで新規リポジトリを作成することができます｡ なお､GitHubのアカウントを持っていない場合はこのステップを飛ばしてください｡

![](https://t907947.p.clickup-attachments.com/t907947/b7265827-aa40-451d-b251-472e6abec596/image.png)

  

  

次に `git clone` を行います(GitHubのアカウントがない場合は､tom-tan/cwl-for-remote-container-templateを､アカウントがある場合は､my\_account/cwl-for-remote-container-template ということになります)｡

```bash
# git cloneを行う例(アカウントが無い場合)
git clone https://github.com/tom-tan/cwl-for-remote-container-template 
```

  

  

次にVSCodeを開きます｡ VSCode画面左下の緑の｢ >< ｣マークを押すと､ 検索窓に以下のようなオプションが出てくるので､｢コンテナーでフォルダーを開く｣を選択し､先程cloneしたリポジトリを開きます｡

![](https://t907947.p.clickup-attachments.com/t907947/3e86b0e8-d5b9-42aa-8934-caefbd58b73c/image.png)

  

最初の立ち上げは5分程度かかりました｡

  

  

ログを見ていると環境構築のために色々されていることがわかります｡

![](https://t907947.p.clickup-attachments.com/t907947/f4bac0c6-adaa-4ea4-a794-734ab630d40d/image.png)

  

ターミナルはこのようになりました｡

![](https://t907947.p.clickup-attachments.com/t907947/ea721043-8c13-4415-be0f-9fa971a1342c/image.png)

  

本当にCWL関連のツールは使えるようになっているのか見てみましょう｡

cwl と入力してtab を押すと....

![](https://t907947.p.clickup-attachments.com/t907947/82fdde14-a4cf-4c49-9071-cabe0b47a44d/image.png)

cwltoolなど実行に必要なツールが導入されています｡

  

では､Dockerのコンテナが起動しているかどうかdocker desktopで確認してみると...

![](https://t907947.p.clickup-attachments.com/t907947/40fb1465-c5af-4bdf-abea-fc9cfb44a81d/image.png)

  

上記のように､立ち上がっているのがわかります｡

これで環境導入ができました｡

  

  

## 【番外編】GitHub Codespacesで実行環境を作って作業する

  

ここまでは､ローカルの自分のマシンで行うことを前提に色々準備してきました｡ しかしながら､｢もっと楽したい!!｣ という方もいらっしゃるかと思います｡ そこで活用できるのが｢GitHub Codespaces｣というクラウドでホストされている開発環境です｡ その概要は以下の日本語ドキュメントをご覧ください｡

  

#### GitHub Codespaces の概要

[

docs.github.com

https://docs.github.com/ja/codespaces/overview

](https://docs.github.com/ja/codespaces/overview)

  

先程テンプレートを取得する段階で､｢Use this template｣を押す時に気になった方がいらっしゃるかもしれませんが､この時､｢Create a new repository｣ と｢Open in a codespace｣と2つの選択肢があったかと思います｡ このとき｢Open in a codespace｣を選べばなんとブラウザでこの開発環境が立ち上がってしまいます!

  

まず､左下の緑の｢><｣ボタンを押してください｡

*   ![](https://t907947.p.clickup-attachments.com/t907947/760c595c-7e08-47dd-b5c7-a862c2f71194/image.png)
*   次に､｢Create New Codespace｣をクリックして､立ち上げたいリポジトリを選択します｡
*   ![](https://t907947.p.clickup-attachments.com/t907947/b0aa9b0e-6370-4c91-b666-937df1847ee5/image.png)
*   ![](https://t907947.p.clickup-attachments.com/t907947/633cc294-92f3-477b-a9d6-bdfd6f142bf9/image.png)

そうすると､自動的に環境が構築されていきます｡今回はすでに環境を構築しているものを使用します｡なお､Codespaceで作成した環境は､自分のGitHubのページから確認できます｡最初の立ち上げには同様に時間がかかります｡

  

  

  

# ワークフローを実際に書いてみよう

  

ここまではCWLに関する説明､および環境導入を行いました｡ 後編では実際にCWLファイルの記述､実行を行っていきます｡ 今回は2つの例について､1つは**シェルで使用するコマンドについて**､2つ目は**バイオインフォマティクスの解析に関わるコマンド**の例を紹介します｡

  

  

  

# 【Case1】grepコマンドとwcコマンドをCWL化する (cwlversion v1.0)

  

  

初めにgrepコマンドとwcコマンドを使ったワークフローをCWLによって記述する例を紹介します｡

実行するのは､`grep one mock.txt > grep_out.txt` と `wc -l grep_out.txt > wc_out.txt` の2つです｡

```bash
grep one mock.txt > grep_out.txt
wc -l grep_out.txt > wc_out.txt
```

  

このワークフローの構造はCWL runner に載っているこちらの構造になります｡ 日本語ドキュメントでも説明されている例になります｡

![](https://t907947.p.clickup-attachments.com/t907947/1014304a-ce36-49ee-a2f4-9c43dcdee836/image.png)

  

次に､実際にCWLファイルの記述を行っていきます｡今回､主役となるコマンドは ｢grep｣ と｢wc｣の2つ(黄色で示されているブロック)です｡ 今回記述する流れとしては､ (1)コマンドの処理に関するcwlファイルを書き(今回は2つ)､ (2)ワークフロー全体を記述するcwlファイルを書きます｡

CWLファイルは記述する内容を YAMLかJSON の形式で記述し、｢.cwl ｣という拡張子でファイルに保存します。実行時にこの CWL ファイルを実行エンジンに入力すると、ワークフローが実行される､という流れになっています｡まずはじめにスクリプトの最初の処理である `grep one mock.txt > grepout.txt` の処理をCWLファイルとして記述していきます｡

  

  

### 実際に書いてみる

それでは実際に書いていきましょう｡ まず､右上のマークを押して､ファイル作成を行います｡

次に､記述するために必要な情報について説明します｡ 今回は最低限の情報をYAML形式で記述していきます｡ 上から順に､ “cwlversion” , “class” , “baseCommand” , “inputs” , “outputs” , “stdout(標準出力)” が必要です｡ それぞれ書いていきます｡

“cwlversion” ここには､cwltoolの準拠しているバージョンを書きます｡

![](https://t907947.p.clickup-attachments.com/t907947/cf8cf2c7-57b7-4173-bdee-21c202175c66/image.png)

  

今回はv1.0で書いてみます｡

"class" ここには､ワークフローを記述する場合は｢Workflow｣か､単独の処理を記述する場合は｢CommandLineTool｣を入力します｡

![](https://t907947.p.clickup-attachments.com/t907947/4842b7fb-b0f8-4c93-83c3-197cab89baba/image.png)

  

"baseCommand" ここで実行されるコマンドを指定します｡ ここでは､grepコマンドです｡

"inputs" ここでコマンドに与える入力について記述します｡one というワードのパターンを調べたいので､｢pattern｣と入力を定義します｡

  

同様に､調べるファイル(ここではmock.txt)も入力したいので｢file\_to\_search｣として定義しています｡入力するパラメータのタイプと､引数のポジションをここでは記述しています｡

![](https://t907947.p.clickup-attachments.com/t907947/13acddd8-088a-4151-9141-b36dbce9aed7/image.png)

  

"outputs" ここではコマンドから得る出力について記述します｡

ここでは標準出力に書き込まれる文字列を得るために｢stdout｣を指定しています｡

![](https://t907947.p.clickup-attachments.com/t907947/352361d5-6c5d-4964-a72c-15803773b0cd/image.png)

"stdout" このキーワードで標準出力を取得します｡

ここにテキストファイルの名前を書いておくと､文字列がこのファイルに書き込まれます｡

  

実際に書いてみたのが以下のような例です｡

![](https://t907947.p.clickup-attachments.com/t907947/cbb48c5d-018f-4f6a-97b7-cba139a5eaee/image.png)

  

  

  

#### 実際に試してみる

cwltoolで実際に試してみることができます｡cwltool ./cwl/grep.cwl --pattern one --file\_to\_search ./data/mock.txt

![](https://t907947.p.clickup-attachments.com/t907947/42e88166-cc57-463e-bcc9-1348647778ed/image.png)

もしこの実行でエラーが発生した場合､ `cwltool --debug grep.cwl --pattern one --file_to_search ./data/mock.txt` でデバッグをすることができます｡

  

### 記述が正しいか確認する

*   実際の実行の前に記述が正しいか確認することもできます｡
*   “ cwltool –-validate” コマンドを実行すると､記述したCWLファイルを評価することができます｡
*   実際にやってみましょう｡
*   今回の場合はエラーは確認されませんでした｡
*   ![](https://t907947.p.clickup-attachments.com/t907947/5c793c4e-82e1-41f2-a366-58855ba42f28/image.png)
*   このように､記述がおかしい場合はコマンドで確認できる他に､シンタックスエラーがある場合は､補助的に赤線で明示されるので､記述している際にも確認ができます｡

  

#### 【続けて別のcwlファイルを書く】

*   同様に､ `wc -l grep_out.txt > wc_out.txt` を記述します｡
*   ![](https://t907947.p.clickup-attachments.com/t907947/570ed8be-2099-4120-905d-f2a5472f3773/image.png)
*   このように書いてみました｡
*   まず､ `cwltool --validate ./cwl/wc.cwl` で評価してみます｡
*   ![](https://t907947.p.clickup-attachments.com/t907947/de19da01-bd7d-4ed3-b156-d3ffda263d41/image.png)
*   大丈夫なようなので､次に実際に実行してみます｡
*   `cwltool ./cwl/wc.cwl --file ./grep_out.txt`
*   ![](https://t907947.p.clickup-attachments.com/t907947/0c486d65-7469-4158-9a2f-a66607d9e799/image.png)
*   正常に実行できたようです｡

  

  

  

#### ワークフローの記述を行う

  

それでは､この2つのステップを実際にワークフローとして記述していきます｡ ｢grep-and-count.cwl｣というファイルを作成していきます｡ "class" ここにはこれまでと違い､｢Workflow｣と記述します｡ 続いて"inputs", "outputs", そしてワークフローの手順である"steps" について注目して記述していきます｡ "inputs" ここでは､｢ワークフロー｣として必要な入力のパラメータについて記述します｡

  

今回は､最初のステップである｢grep｣コマンドの抜き出すパターンと､対象のファイルの2つのパラメータを書きます｡

![](https://t907947.p.clickup-attachments.com/t907947/ba1f62aa-81f6-49c3-a999-c2c8906af714/image.png)

  

それぞれのパラメータのタイプを記述します｡ "outputs" ここでは､｢wc｣コマンド出力のパラメータを記述します｡

![](https://t907947.p.clickup-attachments.com/t907947/6d071715-1c87-4a07-95fe-b12b47b88a26/image.png)

  

"outputSource" は､ワークフロー全体の出力を明示的に指定するために使用されるフィールドであり､特定のステップの出力をワークフロー全体の出力としてマッピングします｡ "steps" ここでは､具体的なワークフローの手順を記述します｡ それぞれのステップでのインプット､アウトプットを"in"､"out"として記述します｡ "run" には先程作成したファイルを記述します｡ なお､"out" では､リスト形式で書くことで､複数の出力を書くことができます｡ 実際に書いてみたのがこちらになります｡

![](https://t907947.p.clickup-attachments.com/t907947/0276a0cd-66df-4d87-9b98-451cdcfe8dc2/image.png)

  

  

#### 実際に実行してみる

それでは実際にこのワークフローを実行してみましょう｡ cwl-runner コマンドを使用して実行します｡

```bash
cwl-runner ./cwl/grep-and-count.cwl --grep_pattern one --target_file ./data/mock.txt
INFO /usr/local/bin/cwl-runner 3.1.20230906142556
INFO Resolved './cwl/grep-and-count.cwl' to 'file:///workspaces/togotv_shooting/cwl/grep-and-count.cwl'
INFO [workflow ] start
INFO [workflow ] starting step 1_grep
INFO [step 1_grep] start
INFO [job 1_grep] /tmp/kt8uwiwx$ grep \
    one \
    /tmp/5jijn8q2/stg7e8a0a28-85d5-4893-afe5-64b27b903203/mock.txt > /tmp/kt8uwiwx/grep_out.txt
INFO [job 1_grep] completed success
INFO [step 1_grep] completed success
INFO [workflow ] starting step 2_wc
INFO [step 2_wc] start
INFO [job 2_wc] /tmp/ombsr24r$ wc \
    -l \
    /tmp/z5xowry5/stg6a76ed4d-7b55-48ea-b454-eb9fc747d9ab/grep_out.txt > /tmp/ombsr24r/wc_out.txt
INFO [job 2_wc] completed success
INFO [step 2_wc] completed success
INFO [workflow ] completed success
{
    "counts": {
        "location": "file:///workspaces/togotv_shooting/wc_out.txt",
        "basename": "wc_out.txt",
        "class": "File",
        "checksum": "sha1$ced21e7b8b8e0a0bc7f92fa3fdca9e23c7d65c4c",
        "size": 69,
        "path": "/workspaces/togotv_shooting/wc_out.txt"
    }
}INFO Final process status is success
```

このように処理され､最終的にwc\_out.txtが出力されます｡なお､パラメータはYAMLファイルとして､まとめて記述することも可能です｡

  

  

  

  

  

  

  

## 【Case2】バイオインフォマティクスの解析をワークフロー化する

  

  

次に､ 具体的に生命科学で使用されているツールを使った例をワークフローとして記述してみます｡

今回は､BLASTによる配列類似性検索､配列類似性検索の結果をawkで抜き出す､ ClustalOmegaによるマルチプルアラインメント､fasttreeによるブートストラップ値の算出をワークフローとして記述してみます｡

今回取り上げた全てのツールは Biocontainers によってdocker imageが構築されています｡docker hubのホームページ にアクセスし､コマンドをコピー&ペーストをすることでこれらのimageをpullすることができます｡

  

#### docker imageをとってくる

まず､それぞれのdocker imageをダウンロードします｡ tag を指定する形で今回はダウンロードしました｡

![](https://t907947.p.clickup-attachments.com/t907947/1491867c-04f7-4db4-998e-aa7d51331d7a/image.png)

  

  

#### BLASTの準備をする

  

次に､インプットするファイルを準備します｡ 今回クエリとするのは､  ウシのミオスタチンのタンパク質配列のfastaファイル (MSTN.fasta)です｡ このファイルに加え､BLASTのデータベースとして使用するUniProtのタンパク質配列のfastaファイル(uniprot\_sprot.fasta)をftpサイトよりcurlコマンドで取得しました｡ makeblastdbコマンドで実行されるBLAST用データベースの作成はワークフローに組み込まない形で記述します｡ makeblastdb の実行は以下のコマンドで行いました｡

```bash
docker run --rm -it -v `pwd`:`pwd` -w `pwd` biocontainers/blast:v2.2.31_cv2 makeblastdb -in uniprot_sprot.fasta -dbtype prot -hash_index -parse_seqids 
```

  

  

  

#### 実際にCWLファイルを書いてみる (CommandLineTool編)

*   次に実際の処理について､CWLファイルを記述していきましょう｡
*   今回実行するコマンドはこのようになっています｡

```bash
% # Step1
% docker run --rm -it -v `pwd`:`pwd` -w `pwd` biocontainers/blast:v2.2.31_cv2 blastp -query MSTN.fasta -db uniprot_sprot.fasta -evalue 1e-5 -num_threads 4 -outfmt 6 -out blastp_result_MSTN.txt -max_target_seqs 20 

% # Step2
% awk '{ print $2 }' blastp_result_MSTN2.txt > blastp_result_id.txt

% #Step3
% docker run --rm -it -v `pwd`:`pwd`  -w  `pwd` biocontainers/blast:v2.2.31_cv2 blastdbcmd -db uniprot_sprot.fasta -entry_batch blastp_result_id.txt  -out blastp_results_MSTN.fasta

% #Step4
% docker run --rm -it -v `pwd`:`pwd` -w `pwd` biocontainers/clustalo:v1.2.4-2-deb_cv1 clustalo -i `pwd`/blastp_results_MSTN.fasta --outfmt=fasta -o MSTN_aligned_sequence.fasta

% #Step5
% docker run --rm -it -v `pwd`:`pwd` -w `pwd` biocontainers/fasttree:v2.1.10-2-deb_cv1 FastTree -out MSTN_tree.newick `pwd`/MSTN_aligned_sequence.fasta
```

*   awk以外のdocker を使用したプロセスには､新たに “dockerrequirements” の記述が必要です｡
*   一番最初のblastpコマンドの記述を例に紹介していきます｡
*   これらを手作業で書くという他に､すでにこの環境で使えるようになっている ｢zatsu-cwl-generator｣ を使って､アウトラインをある程度出力してもらう､という方法があるので､今回はこの方法を試してみます｡
*   zatsu-cwl-generator に コマンドを入力します｡ 

```plain
% zatsu-cwl-generator "docker run --rm -it -v `pwd`:`pwd` -w `pwd` biocontainers/blast:v2.2.31_cv2 blastp -query MSTN.fasta -db uniprot_sprot.fasta -evalue 1e-5 -num_threads 4 -outfmt 6 -out blastp_result_MSTN.txt -max_target_seqs 20" > blastp.cwl
```

*   ただし､これが完成版ではなく､実際に確認して修正することが必要です｡
*   出力されたファイルの中身を見てみましょう｡

```yaml
#!/usr/bin/env cwl-runner
# Generated from: docker run --rm -it -v `pwd`:`pwd` -w `pwd` biocontainers/blast:v2.2.31_cv2 blastp -query MSTN.fasta -db uniprot_sprot.fasta -evalue 1e-5 -num_threads 4 -outfmt 6 -out blastp_result_MSTN.txt -max_target_seqs 20
class: CommandLineTool
cwlVersion: v1.0
baseCommand: docker
arguments:
  - $(inputs.run)
  - --rm
  - -it
  - -v
  - $(inputs.v)
  - -w
  - $(inputs.w)
  - $(inputs.blast:v2_2_31_cv2)
  - $(inputs.blastp)
  - -query
  - $(inputs.query)
  - -db
  - $(inputs.db)
  - -evalue
  - $(inputs.evalue)
  - -num_threads
  - $(inputs.num_threads)
  - -outfmt
  - $(inputs.outfmt)
  - -out
  - $(inputs.out)
  - -max_target_seqs
  - $(inputs.max_target_seqs)
inputs:
  - id: run
    type: Any
    default: run
  - id: v
    type: Any
    default: `pwd`:`pwd`
  - id: w
    type: Any
    default: `pwd`
  - id: blast:v2_2_31_cv2
    type: File
    default:
      class: File
      location: biocontainers/blast:v2.2.31_cv2
  - id: blastp
    type: Any
    default: blastp
  - id: query
    type: File
    default:
      class: File
      location: MSTN.fasta
  - id: db
    type: File
    default:
      class: File
      location: uniprot_sprot.fasta
  - id: evalue
    type: Any
    default: 1e-5
  - id: num_threads
    type: int
    default: 4
  - id: outfmt
    type: int
    default: 6
  - id: out
    type: File
    default:
      class: File
      location: blastp_result_MSTN.txt
  - id: max_target_seqs
    type: int
    default: 20
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
```

  

記述するべき部分が出力されています｡修正すべき点がありますので修正していきましょう｡まず､大きな点として､baseCommand は実行するコマンドですが､ここにはdocker ではなく､blastpと書き直します｡

  

なお､docker は "requirements" の部分で記述します｡

![](https://t907947.p.clickup-attachments.com/t907947/7795ad70-c804-4435-a62c-428dfbf1cfb6/image.png)

  

次に｢inputs｣ ｢outputs｣ セクションについて記述します｡ ｢arguments｣の部分は今回は記述しない方法で書いていきます｡ 実際に色々書いてみたのがこちらになります｡

```yaml
#!/usr/bin/env cwl-runner
# Generated from: docker run --rm -it -v `pwd`:`pwd` -w `pwd` biocontainers/blast:v2.2.31_cv2 blastp -query MSTN.fasta -db uniprot_sprot.fasta -evalue 1e-5 -num_threads 4 -outfmt 6 -out blastp_result_MSTN.txt -max_target_seqs 20
class: CommandLineTool
cwlVersion: v1.0
# baseCommandにパラメータを全て書いてしまうと､変更ができなくなる
# 特定のオプションが必要な時はここに書く
baseCommand: [blastp]
doc: BLASTP.cwlを書いてみた

requirements:
  DockerRequirement:
    dockerPull: "biocontainers/blast:v2.2.31_cv2"
  InlineJavascriptRequirement: {} # Javascriptの式を使わせるためにここの部分が必要

# input
inputs:
  protein_query:
    type: File
    inputBinding:
      prefix: "-query"
      position: 1
  protein_database_directory: #ここが難しい? けど例はたくさんあるので参考にする
    type: Directory?
    default:
      class: Directory
      path: "./"
  protein_database_name:
    type: string?
    default: "uniprot_sprot.fasta"
    inputBinding:
      prefix: "-db"
      position: 2
      # もし入力されていなかったらカレントディレクトリのデータベースを使用するという構文
      # YAMLのparser? が混乱してしまうということで､""でくくった
      valueFrom: "${ return inputs.protein_database_directory ? inputs.protein_database_directory.path + '/' + inputs.protein_database_name : './' + inputs.protein_database_name; }"
  e-value:
    type: float?
    default: 1e-5
    inputBinding:
      prefix: "-evalue"
      position: 3
  number_of_threads:
    type: int
    default: 4
    inputBinding:
      prefix: "-num_threads"
      position: 4
  outformat_type:
    type: int
    default: 6
    inputBinding:
      prefix: "-outfmt"
      position: 5
  output_file_name:
    type: string
    inputBinding:
      prefix: "-out"
      position: 6
  max_target_sequence:
    type: int
    default: 20
    inputBinding:
      prefix: "-max_target_seqs"
      position: 7

#outputs
outputs:
  blastp_output_file:
    type: File
    outputBinding:
      glob: "$(inputs.output_file_name)"

# stdout
stdout: $(inputs.output_file_name)
```

  

同様に他のCWLファイルも､zatsu-cwl-generatorで一旦出力後､修正する形で書いてみましょう｡

  

####   

#### 他のCWLファイル

2\_awk.cwl

```yaml
#!/usr/bin/env cwl-runner
# Generated from: awk '{ print $2 }' blastp_result_MSTN.txt > blastp_result_id.txt
class: CommandLineTool
cwlVersion: v1.0
baseCommand: [awk]

# 固定の引数
arguments:
  - valueFrom: '{ print $2 }' # "" で囲むとエラーになる?  shellQuate: false でも駄目だった
    position: 1 # 同じオブジェクト内に配置しなきゃ駄目!! - position とか並列して書いちゃうと駄目

inputs:
  blastp_result:
    type: File
    inputBinding:
      position: 2
  output_id_file_name:
    type: string
    inputBinding:
      position: 3
outputs:
  awk_output:
    type: File
    outputBinding:
      glob: "$(inputs.output_id_file_name)"
stdout: $(inputs.output_id_file_name)
```

  

3\_blastdbcmd.cwl

```yaml
#!/usr/bin/env cwl-runner
# Generated from: docker run --rm -it -v /workspaces/togotv_shooting/data:/workspaces/togotv_shooting/data  -w  /workspaces/togotv_shooting/data biocontainers/blast:v2.2.31_cv2 blastdbcmd -db uniprot_sprot.fasta -entry_batch blastp_result_id.txt  -out blastp_results_MSTN.fasta
class: CommandLineTool
cwlVersion: v1.0
baseCommand: [blastdbcmd]
doc: blastdbcmdで抜き出してきたIDをもとにタンパク質を検索する

requirements:
  DockerRequirement:
    dockerPull: "biocontainers/blast:v2.2.31_cv2"
  InlineJavascriptRequirement: {} # Javascriptの式を使わせるためにここの部分が必要らしい

# Inputs
inputs:
  blastdbcmd_protein_database_directory: #ここが難しい? けど例はたくさんあるので参考にする
    type: Directory?
  blastdbcmd_protein_database_name:
    type: string?
    default: "uniprot_sprot.fasta"
    inputBinding:
      prefix: "-db"
      position: 1
      # もし入力されていなかったらカレントディレクトリのデータベースを使用するという構文
      # YAMLのparser? が混乱してしまうということで､""でくくった
      valueFrom: "${ return inputs.blastdbcmd_protein_database_directory ? inputs.blastdbcmd_protein_database_directory.path + '/' + inputs.blastdbcmd_protein_database_name : './' + inputs.blastdbcmd_protein_database_name; }"
  id_query:
    type: File
    inputBinding:
      prefix: "-entry_batch"
      position: 2
  blastdbcmd_output_name:
    type: string
    inputBinding:
      prefix: "-out"
      position: 3

#Outputs
outputs:
  blastdbcmd_output:
    type: File
    outputBinding:
      glob: "$(inputs.blastdbcmd_output_name)"
```

  

4\_clustalo.cwl

```yaml
#!/usr/bin/env cwl-runner
# Generated from: docker run --rm -it -v /workspaces/togotv_shooting/data:/workspaces/togotv_shooting/data -w /workspaces/togotv_shooting/data biocontainers/clustalo:v1.2.4-2-deb_cv1 clustalo -i /workspaces/togotv_shooting/data/blastp_results_MSTN.fasta --outfmt=fasta -o MSTN_aligned_sequence.fasta
class: CommandLineTool
cwlVersion: v1.0
baseCommand: [clustalo]

requirements:
  DockerRequirement:
    dockerPull: "biocontainers/clustalo:v1.2.4-2-deb_cv1"

# Inputs
inputs:
  clustalo_inputs:
    type: File
    inputBinding:
      prefix: "-i"
      position: 1
  clustalo_format:
    type: string
    default: "fasta"
    inputBinding:
      prefix: "--outfmt"
      position: 2
  clustalo_output_name:
    type: string
    inputBinding:
      prefix: "-o"
      position: 3

outputs:
  clustalo_output:
    type: File
    outputBinding:
      glob: "$(inputs.clustalo_output_name)"


```

  

5\_fasttree.cwl

```yaml
#!/usr/bin/env cwl-runner
# Generated from: docker run --rm -it -v /workspaces/togotv_shooting/data:/workspaces/togotv_shooting/data -w /workspaces/togotv_shooting/data biocontainers/fasttree:v2.1.10-2-deb_cv1 FastTree -out MSTN_tree.newick /workspaces/togotv_shooting/data/MSTN_aligned_sequence.fasta
class: CommandLineTool
cwlVersion: v1.0
baseCommand: [fasttree]

requirements:
  DockerRequirement:
    dockerPull: "biocontainers/fasttree:v2.1.10-2-deb_cv1"

#Inputs
inputs:
  fasttree_output_file_name:
    type: string
    inputBinding:
      prefix: "-out"
      position: 1
  fasttree_input_file:
    type: File
    inputBinding:
      position: 2
# Outputs
outputs:
  fasttree_output_file:
    type: File
    outputBinding:
      glob: "$(inputs.fasttree_output_file_name)"
```

  

  

  

#### 【ワークフローを記述する】

*   全ての処理に関するCWLファイルを書いてみました｡
*   次にこれらの5つのステップを実行するワークフローを記述していきます｡
*   この例では､ワークフロー全体に関するパラメータを｢1\_protein\_query｣のように数字をつけています｡
*   前の処理のアウトプットを受け取る部分は｢blastp\_result: step1\_blastp/blastp\_output\_file｣のように記述し､それ以外の全ての処理に関するパラメータをinputsで記述しています｡

```yaml
#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
doc: "5つのステップを実行するワークフロー: blastp, awk, blastdbcmd, clustalo, and fasttree"
#最初のインプットのみ記述しようと思ったが､全部書いてわかりやすく書く方針に
# 前のステップの出力の書き方に注意
inputs: 
  #blastp
  1_protein_query: 
    type: File
  2_protein_database_directory:
    type: Directory?
  3_protein_database_name: 
    type: string
  4_e-value: 
    type: float?
  5_number_of_threads: 
    type: int
  6_outformat_type: 
    type: int
  7_output_file_name: 
    type: string
  8_max_target_sequence: 
    type: int
  #awk
  9_output_id_file_name:
    type: string
  #blastdbcmd
  10_blastdbcmd_protein_database_directory:
    type: Directory?
  11_blastdbcmd_protein_database_name:
    type: string
  12_blastdbcmd_output_name:
    type: string
  #clustalo
  13_clustalo_format:
    type: string
  14_clustalo_output_name:
    type: string
  #fasttree
  15_fasttree_output_file_name:
    type: string
  

outputs:
  final_output_bootstrap: 
    type: File
    outputSource: step5_fasttree/fasttree_output_file
steps:
  step1_blastp:
    run: 1_blastp.cwl #同じディレクトリにあるか確認
    in: #workflow全体のインプットにつながる
      protein_query: 1_protein_query
      protein_database_directory: 2_protein_database_directory
      protein_database_name: 3_protein_database_name
      e-value: 4_e-value
      number_of_threads: 5_number_of_threads
      outformat_type: 6_outformat_type
      output_file_name: 7_output_file_name
      max_target_sequence: 8_max_target_sequence
    out: [blastp_output_file] #1_blastp.cwlで記述したoutput

  step2_awk:
    run: 2_awk.cwl
    in:
      blastp_result: step1_blastp/blastp_output_file #1_blastp.cwlで記述したoutput ここがこんがらがるので注意
      output_id_file_name: 9_output_id_file_name
    out: [awk_output]

  step3_blastdbcmd:
    run: 3_blastdbcmd.cwl
    in: 
      blastdbcmd_protein_database_directory: 10_blastdbcmd_protein_database_directory
      blastdbcmd_protein_database_name: 11_blastdbcmd_protein_database_name
      id_query: step2_awk/awk_output #ここは前のステップの出力
      blastdbcmd_output_name: 12_blastdbcmd_output_name
    out: [blastdbcmd_output]

  step4_clustalo:
    run: 4_clustalo.cwl
    in:
      clustalo_inputs: step3_blastdbcmd/blastdbcmd_output
      clustalo_format: 13_clustalo_format
      clustalo_output_name: 14_clustalo_output_name
    out: [clustalo_output]

  step5_fasttree:
    run: 5_fasttree.cwl
    in:
      fasttree_output_file_name: 15_fasttree_output_file_name
      fasttree_input_file: step4_clustalo/clustalo_output
    out: [fasttree_output_file]
```

*   最後に全てのパラメータ(1\_protein\_queryのように書いている部分)を記述したファイル を作成します｡
*   すでに述べたように､パラメータはYAMLファイルとしてまとめて記述することが可能です｡
*   このようになりました｡

```yaml
# 1_blastp.cwl のパラメータ
1_protein_query:
  class: File
  path: "MSTN.fasta"
2_protein_database_directory:
  class: Directory
  path: "./"
3_protein_database_name: "uniprot_sprot.fasta"
4_e-value: 1e-5
5_number_of_threads: 4
6_outformat_type: 6
7_output_file_name: "blastp_result.txt"
8_max_target_sequence: 20

# 2_awk.cwl のパラメータ
9_output_id_file_name: "awk_output_id.txt"

# 3_blastdbcmd.cwl のパラメータ
10_blastdbcmd_protein_database_directory:
  class: Directory
  path: "./"
11_blastdbcmd_protein_database_name: "uniprot_sprot.fasta"
12_blastdbcmd_output_name: "blastdbcmd_output.fasta"

# 4_clustalo.cwl のパラメータ
13_clustalo_format: "fasta"
14_clustalo_output_name: "clustalo_output.fasta"

# 5_fasttree.cwl のパラメータ
15_fasttree_output_file_name: "fasttree_output.newick"
```

*   最後に “cwltool –-validate” を実行します｡

```yaml
$ cwltool --validate 6_phylogenetic-workflow.cwl 
INFO /usr/local/bin/cwltool 3.1.20230906142556
INFO Resolved '6_phylogenetic-workflow.cwl' to 'file:///workspaces/togotv_shooting/data/6_phylogenetic-workflow.cwl'
6_phylogenetic-workflow.cwl is valid CWL.
```

*   書き方としては問題が無いようです｡
*   次に､実際に実行してみます｡

```yaml
% cwl-runner 6_phylogenetic-workflow.cwl input.yaml
INFO /usr/local/bin/cwl-runner 3.1.20230906142556
INFO Resolved '6_phylogenetic-workflow.cwl' to 'file:///workspaces/togotv_shooting/data/6_phylogenetic-workflow.cwl'
INFO [workflow ] start
INFO [workflow ] starting step step1_blastp
INFO [step step1_blastp] start
INFO [job step1_blastp] /tmp/7ucsrbco$ docker \
    run \
    -i \
    --mount=type=bind,source=/tmp/7ucsrbco,target=/qfvKTr \
    --mount=type=bind,source=/tmp/haav6qpy,target=/tmp \
    --mount=type=bind,source=/workspaces/togotv_shooting/data,target=/var/lib/cwl/stgbe25c83e-750e-4f35-9f29-393cfd19c8c2/data,readonly \
    --workdir=/qfvKTr \
    --read-only=true \
    --log-driver=none \
    --user=1000:1000 \
    --rm \
    --cidfile=/tmp/dkvhe4ne/20230913080440-948300.cid \
    --env=TMPDIR=/tmp \
    --env=HOME=/qfvKTr \
    biocontainers/blast:v2.2.31_cv2 \
    blastp \
    -query \
    /var/lib/cwl/stgbe25c83e-750e-4f35-9f29-393cfd19c8c2/data/MSTN.fasta \
    -db \
    /var/lib/cwl/stgbe25c83e-750e-4f35-9f29-393cfd19c8c2/data/uniprot_sprot.fasta \
    -evalue \
    0.00001 \
    -num_threads \
    4 \
    -outfmt \
    6 \
    -out \
    blastp_result.txt \
    -max_target_seqs \
    20 > /tmp/7ucsrbco/blastp_result.txt
INFO [job step1_blastp] Max memory used: 6MiB
INFO [job step1_blastp] completed success
INFO [step step1_blastp] completed success
INFO [workflow ] starting step step2_awk
INFO [step step2_awk] start
INFO [job step2_awk] /tmp/35d57m97$ awk \
    '{ print $2 }' \
    /tmp/9nt3lvc5/stg489dad2a-61c9-465a-b4c6-9bd9c3027c75/blastp_result.txt \
    awk_output_id.txt > /tmp/35d57m97/awk_output_id.txt
INFO [job step2_awk] completed success
INFO [step step2_awk] completed success
INFO [workflow ] starting step step3_blastdbcmd
INFO [step step3_blastdbcmd] start
INFO [job step3_blastdbcmd] /tmp/bkbeawd6$ docker \
    run \
    -i \
    --mount=type=bind,source=/tmp/bkbeawd6,target=/qfvKTr \
    --mount=type=bind,source=/tmp/qf7wda78,target=/tmp \
    --mount=type=bind,source=/tmp/35d57m97/awk_output_id.txt,target=/var/lib/cwl/stga4f0d973-fa8f-432a-afbc-fdb63e37239a/awk_output_id.txt,readonly \
    --mount=type=bind,source=/workspaces/togotv_shooting/data,target=/qfvKTr/data,readonly \
    --workdir=/qfvKTr \
    --read-only=true \
    --user=1000:1000 \
    --rm \
    --cidfile=/tmp/kv_wyzkw/20230913080442-689708.cid \
    --env=TMPDIR=/tmp \
    --env=HOME=/qfvKTr \
    biocontainers/blast:v2.2.31_cv2 \
    blastdbcmd \
    -db \
    /qfvKTr/data/uniprot_sprot.fasta \
    -entry_batch \
    /var/lib/cwl/stga4f0d973-fa8f-432a-afbc-fdb63e37239a/awk_output_id.txt \
    -out \
    blastdbcmd_output.fasta
INFO [job step3_blastdbcmd] completed success
INFO [step step3_blastdbcmd] completed success
INFO [workflow ] starting step step4_clustalo
INFO [step step4_clustalo] start
INFO [job step4_clustalo] /tmp/qe430pdu$ docker \
    run \
    -i \
    --mount=type=bind,source=/tmp/qe430pdu,target=/qfvKTr \
    --mount=type=bind,source=/tmp/8468stf5,target=/tmp \
    --mount=type=bind,source=/tmp/bkbeawd6/blastdbcmd_output.fasta,target=/var/lib/cwl/stg50a863b3-45d4-4f4f-8d4c-ae00a750b775/blastdbcmd_output.fasta,readonly \
    --workdir=/qfvKTr \
    --read-only=true \
    --user=1000:1000 \
    --rm \
    --cidfile=/tmp/sd6ri7wg/20230913080443-718463.cid \
    --env=TMPDIR=/tmp \
    --env=HOME=/qfvKTr \
    biocontainers/clustalo:v1.2.4-2-deb_cv1 \
    clustalo \
    -i \
    /var/lib/cwl/stg50a863b3-45d4-4f4f-8d4c-ae00a750b775/blastdbcmd_output.fasta \
    --outfmt \
    fasta \
    -o \
    clustalo_output.fasta
INFO [job step4_clustalo] completed success
INFO [step step4_clustalo] completed success
INFO [workflow ] starting step step5_fasttree
INFO [step step5_fasttree] start
INFO [job step5_fasttree] /tmp/wsu7hqcq$ docker \
    run \
    -i \
    --mount=type=bind,source=/tmp/wsu7hqcq,target=/qfvKTr \
    --mount=type=bind,source=/tmp/f10y0m0u,target=/tmp \
    --mount=type=bind,source=/tmp/qe430pdu/clustalo_output.fasta,target=/var/lib/cwl/stg91c3ea64-0650-4959-b0b2-63e47a64f1e4/clustalo_output.fasta,readonly \
    --workdir=/qfvKTr \
    --read-only=true \
    --user=1000:1000 \
    --rm \
    --cidfile=/tmp/y9m_6ajr/20230913080444-735692.cid \
    --env=TMPDIR=/tmp \
    --env=HOME=/qfvKTr \
    biocontainers/fasttree:v2.1.10-2-deb_cv1 \
    fasttree \
    -out \
    fasttree_output.newick \
    /var/lib/cwl/stg91c3ea64-0650-4959-b0b2-63e47a64f1e4/clustalo_output.fasta
FastTree Version 2.1.10 Double precision (No SSE3)
Alignment: /var/lib/cwl/stg91c3ea64-0650-4959-b0b2-63e47a64f1e4/clustalo_output.fasta
Amino acid distances: BLOSUM45 Joins: balanced Support: SH-like 1000
Search: Normal +NNI +SPR (2 rounds range 10) +ML-NNI opt-each=1
TopHits: 1.00*sqrtN close=default refresh=0.80
ML Model: Jones-Taylor-Thorton, CAT approximation with 20 rate categories
Initial topology in 0.00 seconds
Refining topology: 15 rounds ME-NNIs, 2 rounds ME-SPRs, 7 rounds ML-NNIs
Total branch-length 0.205 after 0.01 sec
ML-NNI round 1: LogLk = -1664.746 NNIs 2 max delta 0.00 Time 0.14
      0.13 seconds: Site likelihoods with rate category 1 of 20
Switched to using 20 rate categories (CAT approximation)
Rate categories were divided by 0.677 so that average rate = 1.0
CAT-based log-likelihoods may not be comparable across runs
Use -gamma for approximate but comparable Gamma(20) log-likelihoods
ML-NNI round 2: LogLk = -1632.213 NNIs 0 max delta 0.00 Time 0.27
Turning off heuristics for final round of ML NNIs (converged)
      0.26 seconds: ML NNI round 3 of 7, 1 of 11 splits
ML-NNI round 3: LogLk = -1632.213 NNIs 0 max delta 0.00 Time 0.35 (final)
Optimize all lengths: LogLk = -1632.213 Time 0.38
Total time: 0.46 seconds Unique: 13/20 Bad splits: 0/10
INFO [job step5_fasttree] Max memory used: 0MiB
INFO [job step5_fasttree] completed success
INFO [step step5_fasttree] completed success
INFO [workflow ] completed success
{
    "final_output_bootstrap": {
        "location": "file:///workspaces/togotv_shooting/data/fasttree_output.newick",
        "basename": "fasttree_output.newick",
        "class": "File",
        "checksum": "sha1$2174533dd0b0da12a274ed2e0849f7c878c9376b",
        "size": 807,
        "path": "/workspaces/togotv_shooting/data/fasttree_output.newick"
    }
}INFO Final process status is success
```

*   解析が成功しているようです｡
*   実際に､newick形式のファイルも出力されています｡
*   このように､何回もコマンドを実行せず､1つのコマンドで実行することができ､更に再現性も担保することができました｡
*   このように､ワークフローをCWLで記述することができます｡