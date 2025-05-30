# Account
ウォレットを表すデータです。
CustomerもMerchantも所有し、同一ウォレット間の送金は取引として記録されます。
Customerのウォレットはマネー残高(有償バリュー)、ポイント残高(無償バリュー)の2種類の残高をもちます。
また有効期限別で金額管理しており、有効期限はチャージ時のコンテキストによって決定されます。
ユーザはマネー別に複数のウォレットを保有することが可能です。
ただし１マネー１ウォレットのみであり、同一マネーのウォレットを複数所有することはできません。


<a name="get-user-accounts"></a>
## GetUserAccounts: ユーザのアカウント一覧取得
ユーザのアカウント一覧を取得します

```swift

```



### Parameters
**`user_id`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```

**`before`** 
  


```json
{
  "type": "string"
}
```

**`after`** 
  


```json
{
  "type": "string"
}
```

**`per_page`** 
  


```json
{
  "type": "integer",
  "format": "int32",
  "minimum": 1,
  "maximum": 100
}
```



成功したときは
[PaginatedUserAccounts](./responses.md#paginated-user-accounts)
を返します



---


<a name="get-account"></a>
## GetAccount: ウォレット情報を取得する
指定したウォレットの情報を取得します。

```swift

```



### Parameters
**`account_id`** 
  

ウォレットIDです。

```json
{
  "type": "string",
  "format": "uuid"
}
```



成功したときは
[AccountDetail](./responses.md#account-detail)
を返します



---


<a name="update-account"></a>
## UpdateAccount: Update account information

```swift

```



### Parameters
**`account_id`** 
  

ウォレットIDです。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`name`** 
  


```json
{
  "type": "string",
  "maxLength": 256
}
```



成功したときは
[AccountDetail](./responses.md#account-detail)
を返します



---


<a name="create-account"></a>
## CreateAccount: アカウント作成
新規アカウントを作成します。

```swift

```



### Parameters
**`name`** 
  

作成するアカウントの名前です。

```json
{
  "type": "string",
  "maxLength": 256
}
```

**`private_money_id`** 
  

作成するアカウントに紐づくマネーのIDです。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`external_id`** 
  

作成するアカウントに紐づく外部IDです。

```json
{
  "type": "string",
  "maxLength": 50
}
```



成功したときは
[AccountDetail](./responses.md#account-detail)
を返します



---


<a name="get-account-transactions"></a>
## GetAccountTransactions: 取引履歴取得
指定したIDのウォレットの取引履歴を取得します。

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

**`before`** 
  

ページングのためのパラメータです。
指定したIDの要素より後の取引履歴が返されます。
直前のページの最後の要素のIDを指定することで次のページへ遷移することができます。
ここで指定したIDの要素それ自体は結果に含まれないことに注意してください。

```json
{
  "type": "string"
}
```

**`after`** 
  

ページングのためのパラメータです。
指定したIDの要素より前の取引履歴が返されます。
直前のページの最初の要素のIDを指定することで前のページへ遷移することができます。
ここで指定したIDの要素それ自体は結果に含まれないことに注意してください。

```json
{
  "type": "string"
}
```

**`per_page`** 
  

1ページあたりに表示する取引履歴の件数です。デフォルト値は30件です。

```json
{
  "type": "integer",
  "format": "int32",
  "minimum": 1,
  "maximum": 100
}
```



成功したときは
[PaginatedAccountTransactions](./responses.md#paginated-account-transactions)
を返します



---


<a name="send-to-account"></a>
## SendToAccount: Send money to an account

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

**`receiver_terminal_id`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```

**`sender_account_id`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```

**`amount`** 
  


```json
{
  "type": "number",
  "format": "decimal",
  "minimum": 0
}
```

**`description`** 
  


```json
{
  "type": "string",
  "maxLength": 200
}
```



成功したときは
[UserTransaction](./responses.md#user-transaction)
を返します



---


<a name="get-account-transfers"></a>
## GetAccountTransfers: 取引明細一覧
指定したウォレットIDの取引履歴を明細レベルで取得します。
取引明細には返金やキャンペーンによるポイント付与などが含まれます。

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

**`before`** 
  

ページングのためのパラメータです。
指定したIDの要素より後の取引履歴が返されます。
直前のページの最後の要素のIDを指定することで次のページへ遷移することができます。
ここで指定したIDの要素それ自体は結果に含まれないことに注意してください。

```json
{
  "type": "string"
}
```

**`after`** 
  

ページングのためのパラメータです。
指定したIDの要素より前の取引履歴が返されます。
直前のページの最初の要素のIDを指定することで前のページへ遷移することができます。
ここで指定したIDの要素それ自体は結果に含まれないことに注意してください。

```json
{
  "type": "string"
}
```

**`per_page`** 
  

1ページあたりに表示する取引履歴の件数です。デフォルト値は30件です。

```json
{
  "type": "integer",
  "format": "int32",
  "minimum": 1,
  "maximum": 100
}
```



成功したときは
[PaginatedAccountTransfers](./responses.md#paginated-account-transfers)
を返します



---


<a name="get-account-balances"></a>
## GetAccountBalances: 残高内訳を取得する
指定したウォレットの有効期限別残高一覧を取得します。

```swift

```



### Parameters
**`account_id`** 
  

ウォレットIDです。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`before`** 
  

有効期限によるフィルターの期間指定のために使います。
このパラメータを指定すると、有効期限が指定した日時より前の残高が抽出されます。

```json
{
  "type": "string",
  "format": "date-time"
}
```

**`after`** 
  

有効期限によるフィルターの期間指定のために使います。
このパラメータを指定すると、有効期限が指定した日時より後の残高が抽出されます。

```json
{
  "type": "string",
  "format": "date-time"
}
```

**`per_page`** 
  

1ページ当たり取得数です。デフォルト値は30です。

```json
{
  "type": "integer",
  "format": "int32",
  "minimum": 1,
  "maximum": 100
}
```

**`expired`** 
  

失効済みの残高を表示するかどうかのフラグです。
trueの場合、失効済みの残高のみを取得し、falseの場合は有効な残高のみを取得します。
デフォルト値はfalseです。

```json
{
  "type": "string",
  "enum": [
    "true",
    "false"
  ]
}
```



成功したときは
[PaginatedAccountBalances](./responses.md#paginated-account-balances)
を返します



---


<a name="create-account-cpm-token"></a>
## CreateAccountCpmToken: CPMトークン作成
ユーザのウォレットID (account_id) を指定してCPMトークンを作成します。

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

**`scopes`** 
  


```json
{
  "type": "array",
  "items": {
    "type": "string",
    "enum": [
      "payment",
      "topup",
      "external-transaction"
    ]
  }
}
```

**`expires_in`** 
  

CPMトークンの有効期限です。単位は秒で、デフォルトの値は300秒(5分)です。
最大値は2592000秒(30日)ですが、セキュリティの観点では短い時間が望ましいとされています。

```json
{
  "type": "integer",
  "format": "int32",
  "minimum": 1,
  "maximum": 2592000
}
```

**`metadata`** 
  

CPMトークンにメタデータを設定します。
ここで指定したメタデータは取引作成時に引き継がれ、キャンペーンの発火条件などに使用されます。

```json
{
  "type": "string",
  "format": "json"
}
```

**`keep_alive`** 
  

通常、新しいCPMトークンが生成されると、それまでに作られたCPMトークンはたとえ有効期限内であっても失効します。
keep_aliveフラグを true にすると、後のCPMトークン生成時にも失効させられないCPMトークンを作ることができます。
テスト時などに長寿命のCPMトークンを作る際に、同時に指定することが多いです。
デフォルトでは false になります。

```json
{
  "type": "boolean"
}
```

**`is_short_token`** 
  

このパラメータが true に設定されているとき、20桁に短縮されたCPMトークンが生成されます。
通常は22桁で、下位8桁がランダム部分ですが、is_short_tokenを true にすると下位6桁がランダム部分になります。
デフォルトではfalseで、22桁のCPMトークンが生成されます。

```json
{
  "type": "boolean"
}
```



成功したときは
[CpmToken](./responses.md#cpm-token)
を返します



---


<a name="get-account-coupons"></a>
## GetAccountCoupons: クーポン表示
指定したアカウントが対象のクーポンを取得します。

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

**`is_available`** 
  

利用可能なクーポンのみを表示するかどうかのフラグです。
デフォルト値はtrueです。

```json
{
  "type": "string",
  "enum": [
    "true",
    "false"
  ]
}
```

**`before`** 
  

ページングのためのパラメータです。
指定したIDの要素より後の取引履歴が返されます。
直前のページの最後の要素のIDを指定することで次のページへ遷移することができます。
ここで指定したIDの要素それ自体は結果に含まれないことに注意してください。

```json
{
  "type": "string"
}
```

**`after`** 
  

ページングのためのパラメータです。
指定したIDの要素より前の取引履歴が返されます。
直前のページの最初の要素のIDを指定することで前のページへ遷移することができます。
ここで指定したIDの要素それ自体は結果に含まれないことに注意してください。

```json
{
  "type": "string"
}
```

**`per_page`** 
  

1ページあたりに表示するクーポンの件数です。デフォルト値は30件です。

```json
{
  "type": "integer",
  "format": "int32",
  "minimum": 1
}
```



成功したときは
[PaginatedAccountCoupons](./responses.md#paginated-account-coupons)
を返します



---


<a name="get-account-coupon-detail"></a>
## GetAccountCouponDetail: クーポンを取得する
指定したウォレットのクーポンを取得します。

```swift

```



### Parameters
**`account_id`** 
  

ウォレットIDです。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`coupon_id`** 
  

クーポンIDです。

```json
{
  "type": "string",
  "format": "uuid"
}
```



成功したときは
[CouponDetail](./responses.md#coupon-detail)
を返します



---


<a name="patch-account-coupon-detail"></a>
## PatchAccountCouponDetail: クーポンを受け取る
指定したウォレットに、クーポンを追加します。

```swift

```



### Parameters
**`account_id`** 
  

ウォレットIDです。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`coupon_id`** 
  

クーポンIDです。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`is_received`** 
  

指定したクーポンが過去にウォレットが取得したかを示すブーリアン値です。デフォルト値は真です。

```json
{
  "type": "boolean"
}
```

**`code`** 
  

クーポン取得に必要なコードを表す文字列です。

```json
{
  "type": "string"
}
```



成功したときは
[CouponDetail](./responses.md#coupon-detail)
を返します



---


<a name="identify-individual"></a>
## IdentifyIndividual: マイナンバー確認セッションを作成する
指定したウォレットのマイナンバー(個人番号)を確認するためのセッションを作成します。

このAPIのパラメータは全てマイナンバーカードからAndroid/iOSのeKYCライブラリで取得できるものです。
氏名、性別、住所、生年月日もマイナンバーカードから外部通信なしで取得できます。
APIの氏名、性別、住所、生年月日はオプショナルですが、これらを送ることにより実際に登録されているものと一致しているかどうかがそれぞれbooleanで返されます。

```swift

```



### Parameters
**`account_id`** 
  

ウォレットIDです。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`signature`** 
  

マイナンバーカードの電子署名機能により作成された電子署名です。

Base64符号化したものを指定してください。

```json
{
  "type": "string"
}
```

**`signing_cert`** 
  

電子署名に用いた署名用電子証明書です。

Base64符号化したものを指定してください。

```json
{
  "type": "string"
}
```

**`expected_hash`** 
  

本文から算出したメッセージダイジェストです。

ハッシュアルゴリズムはSHA256です。
Base64符号化したものを指定してください。

```json
{
  "type": "string"
}
```

**`name`** 
  

氏名です。

スペースは無視されます。公的個人認証で表示できないものは、正式な氏名ではなく代替文字との比較になります。

```json
{
  "type": "string"
}
```

**`gender`** 
  

性別です。

male, female, otherのいずれかを選択できます。

```json
{
  "type": "string",
  "enum": [
    "male",
    "female",
    "other"
  ]
}
```

**`address`** 
  

住所です。

スペースは無視されます。公的個人認証で表示できないものは、正式な住所ではなく代替文字との比較になります。

```json
{
  "type": "string"
}
```

**`date_of_birth`** 
  

生年月日です。

```json
{
  "type": "string",
  "pattern": "^\\w{4}-?\\w{2}-?\\w{2}$"
}
```



成功したときは
[IdentificationResult](./responses.md#identification-result)
を返します



---



