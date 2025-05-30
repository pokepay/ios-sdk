# Transaction
取引を表すデータです。
同一マネーのウォレット間の送金を記録し、キャンセルなどで状態が更新されることがあります。
取引種類として以下が存在します。
topup: チャージ。Merchant => Customer送金
payment: 支払い。Customer => Merchant送金
transfer: 個人間譲渡。Customer => Customer送金
exchange: マネー間交換。１ユーザのウォレット間の送金（交換）。
expire: 退会時失効。退会時の払戻を伴わない残高失効履歴。
cashback: 退会時払戻。退会時の払戻金額履歴。


<a name="get-transaction"></a>
## GetTransaction: 取引情報取得
取引ID(transaaction_id)から取引情報を取得します。


```swift

```



### Parameters
**`transaction_id`** 
  

ポケペイの取引IDです。

UUIDの形式である必要があります(36文字)


```json
{
  "type": "string",
  "format": "uuid"
}
```



成功したときは
[UserTransaction](./responses.md#user-transaction)
を返します



---


<a name="refund-transaction"></a>
## RefundTransaction: 取引キャンセル
取引IDから取引をキャンセルします。
このAPIは店舗ユーザからのみ利用可能です。
部分キャンセルはできません。全額払い戻しにのみ対応しています。


```swift

```



### Parameters
**`transaction_id`** 
  


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
  "minimum": 1
}
```



成功したときは
[UserTransaction](./responses.md#user-transaction)
を返します



---


<a name="list-bill-transactions"></a>
## ListBillTransactions: Billによる取引一覧を取得する
ワンタイムでない支払いQRコード(Bill)の場合、複数の支払い取引が発生し得ます。
このAPIでは、BillのIDからそのBillから発生した支払い取引のリストを取得します。


```swift

```



### Parameters
**`bill_id`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```

**`before`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```

**`after`** 
  


```json
{
  "type": "string",
  "format": "uuid"
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






---


<a name="get-bill-last-transaction"></a>
## GetBillLastTransaction: Get the last transaction of bill

```swift

```



### Parameters
**`bill_id`** 
  

支払いQRコードID

```json
{
  "type": "string",
  "format": "uuid"
}
```



成功したときは
[UserTransaction](./responses.md#user-transaction)
を返します



---


<a name="get-user-transactions"></a>
## GetUserTransactions: 取引情報の取得
ユーザの取引一覧を取得します

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
  "type": "string",
  "format": "uuid"
}
```

**`after`** 
  


```json
{
  "type": "string",
  "format": "uuid"
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
[PaginatedUserTransactions](./responses.md#paginated-user-transactions)
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



