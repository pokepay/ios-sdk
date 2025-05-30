# Cpm
QRをCustomer側が提示する方式または提示するCPMトークンそのものを表すデータです。
CPMトークンは主にQRコードとしてレジ側に提示される利用方法が一般的です。
また顧客側がQRコードを提示される決済方式をMpmと呼びます。


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


<a name="get-cpm-token"></a>
## GetCpmToken: CPMトークンの情報を取得
CPMトークンの情報を取得します。
内容にはユーザの口座、利用スコープ(支払い、チャージの両方またはいずれか)、トークンの有効期限、取引情報 (取引が完了している場合) が含まれます。


```swift

```



### Parameters
**`cpm_token`** 
  

CPMトークンを指定します。

```json
{
  "type": "string",
  "minLength": 20,
  "maxLength": 22
}
```



成功したときは
[CpmToken](./responses.md#cpm-token)
を返します



---



