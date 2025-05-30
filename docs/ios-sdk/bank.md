# Bank
チャージのために利用される金融機関口座を表すデータです。
口座番号などのデータはPokepayサーバでは管理対象外(決済GW側で保有)です。
口座登録は決済GWの用意する専用websiteにて実施されます。
利用口座を保存しておくことが可能であり、保存済み口座リストをあとから取得できます。
チャージ金額はマネー設定の範囲内でユーザが任意の金額を指定可能です。



<a name="list-banks"></a>
## ListBanks: 登録済みの銀行一覧の取得
ユーザが登録した銀行の一覧を取得します

private_money_idを指定すると、対象のマネーに登録した銀行のみ取得できます

```swift

```



### Parameters
**`user_id`** 
  

ユーザID

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`private_money_id`** 
  

マネーIDを指定します

```json
{
  "type": "string",
  "format": "uuid"
}
```



成功したときは
[UserBanks](./responses.md#user-banks)
を返します



---


<a name="bank-top-up"></a>
## BankTopUp: 登録した銀行からのチャージ
ユーザの登録した銀行から、対象のマネーのアカウントにチャージします

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

**`account_id`** 
  

対象のマネーのアカウントを指定します

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`bank_id`** 
  

登録した銀行のIDを指定します

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`amount`** 
  

チャージしたい金額を指定します

```json
{
  "type": "integer",
  "minimum": 1
}
```

**`request_id`** 
  

取引作成APIの羃等性を担保するためのリクエスト固有のIDです

後から対象の取引を `GetTransactionByRequestId` を使って取り出すために用いられます

リクエストIDを指定したとき、まだそのリクエストIDに対する取引がない場合、新規に取引が作られレスポンスとして返されます。もしそのリクエストIDに対する取引が既にある場合、既存の取引がレスポンスとして返されます

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



