# kmsの復号化
function kms-decrypt() {
  aws kms decrypt --ciphertext-blob fileb://<(echo "$1"|base64 -d) | jq .Plaintext --raw-output |base64 -d
}
