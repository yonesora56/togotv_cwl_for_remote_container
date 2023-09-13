# This is the yonezawa memo


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