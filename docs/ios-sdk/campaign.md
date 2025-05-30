# Campaign
自動ポイント還元ルールの設定を表すデータです。
Pokepay管理画面やPartnerSDK経由でルール登録、更新が可能です。
取引(Transaction)または外部決済イベント(ExternalTransaction)の内容によって還元するポイント額を計算し、自動で付与するルールを設定可能です。
targetとして取引または外部決済イベントを選択して個別設定します。


<a name="get-account-campaign-point-amounts"></a>
## GetAccountCampaignPointAmounts: キャンペーンのポイント付与総額取得
対象のウォレットにおいて、指定キャンペーンにより付与されたポイントの総額を取得します。
キャンペーンの設定によってはユーザ毎にポイントの累積での付与上限が決められている場合があり、
現時点でユーザがどれだけのポイントを受け取っているのかを表示するときに必要になります。


```swift

```



### Parameters
**`account_id`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```

**`campaign_id`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```



成功したときは
[AccountCampaignPointAmounts](./responses.md#account-campaign-point-amounts)
を返します



---



