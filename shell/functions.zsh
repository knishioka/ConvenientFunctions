# kmsの復号化
function kms-decrypt() {
  aws kms decrypt --ciphertext-blob fileb://<(echo "$1"|base64 -d) | jq .Plaintext --raw-output |base64 -d
}

# ファイルに日付をつける
function adddate () {
    mv $1 `date "+%Y%m%d"`_$1
}

# 暗号化しながらファイルに名前をつける
function ezip () {
    zip -re `date "+%Y%m%d"`_$1.zip $1
}

# S3からファイルを取得してそのまま表示
function sg () {
    s3cmd get --no-progress $1 -
}

# S3からファイルを取得してlessで開く
function sless() {
    s3cmd get --no-progress $1 - | less
}


# S3からgzファイルを取得してlessで開く
function szless (){
    s3cmd get --no-progress $1 - | zcat | less
}

