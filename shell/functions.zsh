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

