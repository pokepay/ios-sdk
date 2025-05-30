# Coupon
割引クーポンを表すデータです。
クーポンをユーザが明示的に利用することによって支払い決済時の割引(固定金額 or 割引率)が適用されます。
クーポン原資の負担する発行店舗を設定したり、配布先を指定することも可能です。


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


<a name="get-private-money-coupons"></a>
## GetPrivateMoneyCoupons: マネーのクーポン情報を取得
指定したマネーの利用可能なクーポンの一覧を返します。

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
[PaginatedPrivateMoneyCoupons](./responses.md#paginated-private-money-coupons)
を返します



---



