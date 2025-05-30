# Bill
支払いトークン(URL形式)を表すデータです。
URL文字列のまま利用されるケースとQR画像化して利用されるケースがあります。
ログイン済みユーザアプリで読込むことで、支払い取引を作成します。
設定される支払い金額(amount)は、固定値とユーザによる自由入力の2パターンがあります。
amountが空の場合は、ユーザによる自由入力で受け付けた金額で支払いを行います。
有効期限は比較的長命で利用される事例が多いです。

複数マネー対応支払いコードについて:
オプショナルで複数のマネーを１つの支払いコードに設定可能です。
その場合ユーザ側でどのマネーで支払うか指定可能です。
複数マネー対応支払いコードにはデフォルトのマネーウォレットを設定する必要があり、ユーザがマネーを明示的に選択しなかった場合はデフォルトのマネーによる支払いになります。



<a name="get-bill"></a>
## GetBill: 作成済みBillの設定内容を参照する
作成済みBillの設定内容を参照する

```swift

```



### Parameters
**`bill_id`** 
  

参照したいBillのIDを指定する

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
[BillWithAdditionalPrivateMoneys](./responses.md#bill-with-additional-private-moneys)
を返します



---


<a name="update-bill"></a>
## UpdateBill: Billの設定内容を更新
支払いQRコードの内容を更新します。支払い先の店舗ユーザは指定したマネーのウォレットを持っている必要があります。

```swift

```



### Parameters
**`bill_id`** 
  

参照したいBillのIDを指定する

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`amount`** 
  

支払い金額を指定する

```json
{
  "type": "integer",
  "minimum": 0
}
```

**`description`** 
  

支払いQRに用途メモをつける

```json
{
  "type": "string",
  "maxLength": 200
}
```

**`products`** 
  

Billによる支払いの対象商品情報をつける

```json
{
  "type": "array",
  "items": {
    "type": "Product"
  }
}
```



成功したときは
[Bill](./responses.md#bill)
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


<a name="create-bill"></a>
## CreateBill: 支払い用QR(トークン)を新規登録
支払いQRコードの新たに作成します。支払い先の店舗ユーザは指定したマネーのウォレットを持っている必要があります。

```swift

```



### Parameters
**`amount`** 
  

支払いQRコードの支払い金額を指定する。省略するかnullを渡すと任意金額の支払いQRコードとなり、エンドユーザがアプリで読み取った際に金額を入力させます。

```json
{
  "type": "number",
  "format": "decimal",
  "minimum": 1
}
```

**`account_id`** 
  

支払い先となるウォレット(Account)を指定します。支払い先がCustomer, Merchant所有のAccountどちらのケースも存在します。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`additional_account_ids`** 
  

１つのBillで複数マネー対応したい場合に指定します。account_id以外の電子マネーでユーザ支払いを受け付けたい場合に利用します

```json
{
  "type": "array",
  "items": {
    "type": "string",
    "format": "uuid"
  }
}
```

**`description`** 
  

支払い用途などを記載するメモ欄です。
取引のdescriptionにも転写されるのでエンドユーザにも見えるデータとなります。

```json
{
  "type": "string",
  "maxLength": 200
}
```

**`is_onetime`** 
  

1回のみ利用可能なワンタイムトークンとする場合にtrueを指定します

```json
{
  "type": "boolean"
}
```

**`min_amount`** 
  

Billを利用して支払い可能な最小金額(含む)を指定することが可能です

```json
{
  "type": "number",
  "format": "decimal",
  "minimum": 0
}
```

**`max_amount`** 
  

Billを利用して支払い可能な最大金額(含む)を指定することが可能です

```json
{
  "type": "number",
  "format": "decimal",
  "minimum": 0
}
```

**`products`** 
  

購入商品情報を任意で持たせることが可能です

```json
{
  "type": "array",
  "items": {
    "type": "Product"
  }
}
```

**`metadata`** 
  

任意の補足情報をメタ情報として持たせることが可能です

```json
{
  "type": "string",
  "format": "json"
}
```



成功したときは
[Bill](./responses.md#bill)
を返します



---



