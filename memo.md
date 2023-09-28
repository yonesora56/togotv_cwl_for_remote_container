# This is the yonezawa memo

## 丹生さんへのリサーチ(20230928)

1. 全部ドキュメントにするのではなく､気になったらリンクがあることが重要!
    - リンク集を最後に作成
2. なんでCWLを扱うのか?
    - Markdownに書いている
3. hintフィールドとrequirementsフィールド(https://www.commonwl.org/v1.0/CommandLineTool.html#Requirements_and_hints)
4. CWLをなんのエンジンで実行するかで`requirements`フィールドの実行の可否が決まる
    - エンジンによってはサポートしていない
5. バッジで準拠を確認できる(implementation)
6. 書いたファイルのリポジトリのリンクを最後と最初においておく
    - 書こう
- __argumentsにブチ込んで書くのがが良さそう__
    - defaultはargumentsを書くほうが便利
    - __?がつくようなやつはargumentから消えるので､inputBindingをつけなきゃいけない__
- shebangを書く? 書かない?
    - どっちでも大丈夫(シバンで書くと ./で実行できる)
    - ベストプラクティスにも書かれていない
    - zatsuをもっと活かそう
    - <https://www.commonwl.org/v1.2/CommandLineTool.html#Executing_CWL_documents_as_scripts>
- どのツールで実行する?(cwltool? runner? toil-runner?)
    - Javaコマンド(OpenJDK,AzureJDK)を提供している
    - C-コンパイラ
    - なんでも実行したいならcwl-runner
    - チュートリアルなので､触れなくても良いかも
-  zatsu-cwl-generator --help を書く
    - Javaコマンド(OpenJDK,AzureJDK)を提供している
    - C-コンパイラ
    - なんでも実行したいならcwl-runner
    - チュートリアルなので､触れなくても良いかも

- __動画の広げ方について__
1. GitHub pagesで公開しよう? (公開手法：ddbj/workflow-registoryのように)
    - <https://ddbj.github.io/workflow-registry-browser/#/workflows/65bc3bd4-81d1-4f2a-8886-1fbe19011d81/versions/1.0.0>
2. いろんな環境で実行しよう


- ほしいファイルをキャッチするために
- ディレクトリの構造?
    - 問題なさそう
- zatsu-cwl-generator
    - __動画でzatsu､使って､記事ではもっと詳しく__
    - `-c`オプションメインでガンガン書いていく
    - biocontainers（コンテナ）を使うケースはおまけにしておく
    - __ホストでガンガン入れている人向けに作るので､ローカルに入れているツールでCWLを書いて､その後にdockerの事例を紹介__
    - zatsu をもっと記事にいかす
- Codespacesの違いを強調する
    - __クローンしなくても大丈夫な例を後ろに挿入__

- 公式サイトとかユーザーガイドは一番うしろ(細かい書き方はこちらを参照する､という意図で)
- 
    

## 丹生さんに聞くこと
- bentenが表示されない?
    - issueに自分も書いておく
    - <https://github.com/rabix/benten/issues/122>
- devcontainerの書き換え
    - お願いしました
- ブログについて
    - zennの方がいいのでは?
    - GitHubのリポジトリをあげられる
- cwlversion v1.0
    - どちらでもOK!



## docker image list(docker image ls)

```bash
REPOSITORY               TAG                 IMAGE ID       CREATED       SIZE
biocontainers/fasttree   v2.1.10-2-deb_cv1   bdfde5d6026c   3 years ago   118MB
biocontainers/clustalo   v1.2.4-2-deb_cv1    d14a5e27e301   4 years ago   118MB
biocontainers/blast      v2.2.31_cv2         5b25e08b9871   4 years ago   2.03GB
```

## docker run (makeblastdb)

- `docker run --rm -it -v `pwd`:`pwd` -w `pwd` biocontainers/blast:v2.2.31_cv2 makeblastdb -in uniprot_sprot.fasta -dbtype prot -hash_index -parse_seqids`
- `-w` オプションをつけたらうまくいくようになった...
- そしていつもタグをつけるのを忘れてしまう

&nbsp;

&nbsp;

## Command memo

### 1. BLASTP

- `docker run --rm -it -v `pwd`:`pwd` -w `pwd` biocontainers/blast:v2.2.31_cv2 blastp -query MSTN.fasta -db uniprot_sprot.fasta -evalue 1e-5 -num_threads 4 -outfmt 6 -out blastp_result_MSTN.txt -max_target_seqs 20`
- `-outfmt 6`にしよう

&nbsp;

### 2. awk 

- `awk '{ print $2 }' blastp_result_MSTN2.txt > blastp_result_id.txt`
- 2列目のヒットしたIDを抜き出す

&nbsp;

### 3. blastdbcmd

- `docker run --rm -it -v `pwd`:`pwd`  -w  `pwd` biocontainers/blast:v2.2.31_cv2 blastdbcmd -db uniprot_sprot.fasta -entry_batch blastp_result_id.txt  -out blastp_results_MSTN.fasta`
- 先程抜き出したIDをもとにblastdbcmdでアミノ酸配列を抜き出す
- これをもとにclustal omegaを実行する

&nbsp;

### 4. Clustalomega

- `docker run --rm -it -v `pwd`:`pwd`  -w  `pwd`  biocontainers/clustalo:v1.2.4-2-deb_cv1 clustalo -i `pwd`/blastp_results_MSTN.fasta --outfmt clustal -o MSTN_aligned_sequence.aln`
- 最後はalnファイルにしよう
- と､考えていたが､fasttreeがエラーが出たので､以下に修正
- `docker run --rm -it -v `pwd`:`pwd` -w `pwd` biocontainers/clustalo:v1.2.4-2-deb_cv1 clustalo -i `pwd`/blastp_results_MSTN.fasta --outfmt=fasta -o MSTN_aligned_sequence.fasta`

&nbsp;

### 5. Fasttree

- `docker run --rm -it -v `pwd`:`pwd` -w `pwd` biocontainers/fasttree:v2.1.10-2-deb_cv1 FastTree -out MSTN_tree.newick `pwd`/MSTN_aligned_sequence.fasta`
- うまくいったっぽい

&nbsp;

### 6. phylogenetic_workflow.cwl

- わかりやすいように全てのパラメータを明示する方針