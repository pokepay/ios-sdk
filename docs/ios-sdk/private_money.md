# Private Money
Pokepay上で発行する電子マネーを表すデータです。
電子マネーは１つの発行体(Organization)によって発行されます。
電子マネーはCustomerやMerchantが所有するウォレット間を送金されます。
電子マネー残高はユーザが有償で購入するマネーと無償で付与されるポイントの2種類のバリューで構成され、
それぞれ有効期限決定ロジックは電子マネーの設定に依存します。


<a name="get-private-money"></a>
## GetPrivateMoney: マネー情報を取得
マネーの詳細情報を返します。マネーに対して許可されているチャージ手段などが含まれます。


```swift

```



### Parameters
**`private_money_id`** 
  

マネーID

```json
{
  "type": "string",
  "format": "uuid"
}
```



成功したときは
[PrivateMoneyDetail](./responses.md#private-money-detail)
を返します



---


<a name="get-private-money-terms"></a>
## GetPrivateMoneyTerms: Get the private money terms

```swift

```



### Parameters
**`private_money_id`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```






---


<a name="get-private-money-privacy-policy"></a>
## GetPrivateMoneyPrivacyPolicy: Get the private money pricvacy-policy

```swift

```



### Parameters
**`private_money_id`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```






---


<a name="get-private-money-payment-act"></a>
## GetPrivateMoneyPaymentAct: Get the private money payment-act

```swift

```



### Parameters
**`private_money_id`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```






---


<a name="get-private-money-commercial-act"></a>
## GetPrivateMoneyCommercialAct: Get the private money commercial-act

```swift

```



### Parameters
**`private_money_id`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```






---


<a name="get-user-attribute-schema"></a>
## GetUserAttributeSchema: ユーザアンケート項目
マネーに設定されたユーザアンケートの聞き取り項目をJSON形式で取得します。


```swift

```



### Parameters
**`private_money_id`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```






---


<a name="list-private-moneys"></a>
## ListPrivateMoneys: マネー一覧を取得する
ユーザが利用可能なマネーの一覧を取得します。

OAuth認証を経て取得したアクセストークンの場合、認可した組織に属するマネーのみ取得できます。

```swift

```



### Parameters
**`name`** 
  

検索するマネー名です。

```json
{
  "type": "string"
}
```

**`include_exclusive`** 
  

部分一致で表示するマネーの指定です。

trueの場合、部分一致で表示するマネーを一覧に含めます。
デフォルトはfalseです。
OAuthにより取得したアクセストークンの場合、この機能は無効です。

```json
{
  "type": "boolean"
}
```

**`before`** 
  

前のページへのマネーIDです。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`after`** 
  

後のページへのマネーIDです。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`per_page`** 
  

1ページ分の取得するマネー数です。デフォルトは30です。

```json
{
  "type": "integer",
  "format": "int32",
  "minimum": 1,
  "maximum": 100
}
```



成功したときは
[PaginatedPrivateMoneys](./responses.md#paginated-private-moneys)
を返します



---



