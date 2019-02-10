# tokenの取得。client_idとclient_secretを設定しておく必要がある
zuora_token=$(curl -X POST -H "Content-Type: application/x-www-form-urlencoded" \
  -d "client_id=$client_id" \
  -d "grant_type=client_credentials" \
  --data-urlencode "client_secret=$client_secret" \
  "https://rest.zuora.com/oauth/token" | jq -r '.access_token')

# 最初の2000行のSubscriptionデータ取得
curl -X POST -H "Authorization: Bearer $zuora_token" -H "Content-Type: application/json" \
  -d '{"queryString": "SELECT AccountId, SubscriptionStartDate, SubscriptionEndDate, status from Subscription"}' \
  "https://rest.zuora.com/v1/action/query"  > subscription.json

# 2000行以上取るときはquery_locatorをqueryMoreで使う必要がある
query_locator=$(cat subscription.json | jq -r '.queryLocator')

# 次の2000件の取得
curl -X POST -H "Authorization: Bearer $zuora_token" -H "Content-Type: application/json" \
  -d '{"queryLocator":"2c92a0fe68c46c9e0168d752f8fb2c2e-2000"}' \
  "https://rest.zuora.com/v1/action/queryMore"  > subscription_more.json

