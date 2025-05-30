# Credit Card
チャージのために利用されたクレジットカードを表すデータです。
カード番号などのデータはPokepayサーバでは管理対象外(決済GW側で保有)です。
利用カードを保存しておくことが可能であり、保存済みカードリストをあとから取得できます。
チャージ金額はマネー設定の範囲内でユーザが任意の金額を指定可能です。


<a name="get-credit-cards"></a>
## GetCreditCards: Get user credit cards

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

**`organization_code`** 
  


```json
{
  "type": "string"
}
```



成功したときは
[PaginatedCreditCards](./responses.md#paginated-credit-cards)
を返します



---


<a name="create-credit-card"></a>
## CreateCreditCard: Create user credit card

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

**`token`** 
  


```json
{
  "type": "string"
}
```

**`is_cardholder_name_specified`** 
  


```json
{
  "type": "boolean"
}
```

**`organization_code`** 
  


```json
{
  "type": "string"
}
```



成功したときは
[CreditCard](./responses.md#credit-card)
を返します



---






