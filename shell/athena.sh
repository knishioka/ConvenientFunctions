#!/bin/bash

set -Ceu

function cancel () {
    aws athena stop-query-execution --query-execution-id "$query_id"
    echo "CANCELLED $query_id"
    exit
}
trap 'cancel'  {1,2,3,15}

query_id=$(aws athena start-query-execution --query-string "$1"  --result-configuration OutputLocation=$2 | jq -r '.QueryExecutionId')
if [[ -z $query_id ]]; then
    exit
fi
echo "query_id=$query_id"

while :
do
    query_execution=$(aws athena get-query-execution --query-execution-id "$query_id" | jq '.QueryExecution')
    state=$(echo "$query_execution" | jq -r '.Status.State')
    echo "$(date '+%Y-%m-%d %H:%M:%S')" "$state"
    case "${state}" in
        "SUCCEEDED")
            echo "$query_execution" | jq -r '.Statistics | "ExecutionTime: \(.EngineExecutionTimeInMillis/1000) seconds, Scanned: \(.DataScannedInBytes/1000000) GB"'
            echo "$query_execution" | jq -r '"output: \(.ResultConfiguration.OutputLocation)"'
            break;;
        "FAILED")
            echo "$query_execution" | jq -r '.Status.StateChangeReason'
            break;;
    esac
    sleep 3
done
