#!/bin/zsh

# kmsの復号化
function kms-decrypt() {
  aws kms decrypt --ciphertext-blob fileb://<(echo "$1"|base64 -d) | jq .Plaintext --raw-output |base64 -d
}

# ファイルに日付をつける
function adddate () {
    mv "$1" "$(date "+%Y%m%d")_${1}"
}

# 暗号化しながらファイルに名前をつける
function ezip () {
    zip -re "$(date "+%Y%m%d")_${1}.zip" "$1"
}

# S3からファイルを取得してそのまま表示
function sg () {
    s3cmd get --no-progress "$1" -
}

# S3からファイルを取得してlessで開く
function sless() {
    s3cmd get --no-progress "$1" - | less
}

# S3からgzファイルを取得してzcatで開く
function szcat () {
    s3cmd get --no-progress "$1" - | zcat
}

# S3からgzファイルを取得してlessで開く
function szless () {
    s3cmd get --no-progress "$1" - | zcat | less
}

# aws lambdaのソースをダウンロード
function get-lambda () {
    curl -o "${1}.zip" "$(aws lambda get-function --function-name "$1" | jq -r '.Code.Location')"
}

# 落ちたjobの情報を取得
function get-failed-job () {
    aws batch list-jobs --job-queue "$1" --job-status FAILED |
        jq '.jobSummaryList[] | .createdAt |= (./1000 | todate) | .startedAt |= (./1000 | todate) | .stoppedAt |= (./1000 | todate)'
}

# Nameタグを利用してec2のinstance idを取得
function ec2iid () {
    aws ec2 describe-instances --filters "Name=tag:Name,Values=$1" | jq -r '.Reservations[].Instances[] | .InstanceId'
}

# ecrにあるimageをtagをつけて表示
function describe-ecr-images () {
    aws ecr describe-images --repository-name "$1" | jq -r '.imageDetails[] | "\(.repositoryName):\(.imageTags[])"' | sort
}

# AWS Batchのjobのステータスとログの情報を取得
function get-job-status() {
    aws batch describe-jobs --jobs "$1" | jq -r '.jobs[] | "\(.status)\t\(.attempts[].container.logStreamName)"'
}

# AWS Glue
function get-glue-job-runs() {
    aws glue get-job-runs --job-name "$1" | jq -r '.JobRuns[] | "\(.Id)\t\(.JobRunState)\t\(.StartedOn | todate)\t\(.CompletedOn | todate)"'
}
