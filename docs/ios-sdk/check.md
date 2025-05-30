# Check
チャージトークン(URL形式)を表すデータです。
URL文字列のまま利用されるケースとQR画像化して利用されるケースがあります。
ログイン済みユーザアプリで読込むことで、チャージ取引を作成します。
設定されるチャージ金額(amount)は固定であり、データ作成時に指定可能です。
１ユーザあたり１回しか読込みできない制限があります。
有効期限は比較的長命で利用される事例が多いです。



<a name="get-check"></a>
## GetCheck: チャージQRコードを取得する
指定したIDのチャージQRコードの情報を取得します。

```swift

```



### Parameters
**`check_id`** 
  

チャージQRコードID

```json
{
  "type": "string",
  "format": "uuid"
}
```



成功したときは
[Check](./responses.md#check)
を返します



---


<a name="update-check"></a>
## UpdateCheck: チャージQRコードを修正する
指定したチャージQRコードを修正します。

```swift

```



### Parameters
**`check_id`** 
  

チャージQRコードID

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`amount`** 
  

チャージQRコードによって付与されるマネー額です。


```json
{
  "type": "number",
  "format": "decimal",
  "minimum": 1
}
```

**`description`** 
  

チャージQRコードの説明文です。

チャージ取引後は、取引の説明文に転記され、取引履歴などに表示されます。


```json
{
  "type": "string",
  "maxLength": 200
}
```

**`expires_at`** 
  

チャージQRコード自体の失効日時を指定します。

この日時以降はチャージQRコードを読み取れなくなります。
チャージQRコード自体の失効日時であって、チャージQRコードによって付与されるマネー残高の有効期限とは異なることに注意してください。マネー残高の有効期限はマネー設定で指定されているものになります。


```json
{
  "type": "string",
  "format": "date-time"
}
```

**`point_expires_at`** 
  

チャージQRコードによって付与されるポイント残高の有効期限を指定します。

チャージQRコードにより付与されるマネー残高の有効期限はQRコード毎には指定できませんが、ポイント残高の有効期限は本パラメータにより、QRコード毎に個別に指定することができます。
マネー残高の有効期限はマネーの設定に準じます。


```json
{
  "type": "string",
  "format": "date-time"
}
```

**`point_expires_in_days`** 
  

チャージQRコードによって付与されるポイント残高の有効期限を相対日数で指定します。

1を指定すると、チャージQRコード作成日の当日中に失効します(翌日0時に失効)。
`point_expires_at`と`point_expires_in_days`が両方指定されている場合は、チャージQRコードによるチャージ取引ができた時点からより近い方が採用されます。
`point_expires_at`と`point_expires_in_days`が両方NULLに設定されている場合は、マネーに設定されている残高の有効期限と同じになります。


```json
{
  "type": "integer",
  "minimum": 1
}
```



成功したときは
[Check](./responses.md#check)
を返します



---


<a name="create-check"></a>
## CreateCheck: チャージQRコードの発行する
チャージQRコードを発行します。

```swift

```



### Parameters
**`amount`** 
  

チャージQRコードによって付与されるマネー額です。

`money_amount`や`point_amount`が同時に指定された場合エラーになります。


```json
{
  "type": "number",
  "format": "decimal",
  "minimum": 1
}
```

**`money_amount`** 
  

チャージQRコードによって付与されるマネー額です。

`amount`が同時に指定された場合エラーになります。
`money_amount`と`point_amount`が両方0になるような更新リクエストはエラーになります。


```json
{
  "type": "number",
  "format": "decimal",
  "minimum": 0
}
```

**`point_amount`** 
  

チャージQRコードによって付与されるポイント額です。

`amount`が同時に指定された場合エラーになります。
`money_amount`と`point_amount`が両方0になるような更新リクエストはエラーになります。


```json
{
  "type": "number",
  "format": "decimal",
  "minimum": 0
}
```

**`account_id`** 
  

送金元のウォレットIDです。

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`description`** 
  

チャージQRコードの説明文です。

チャージ取引後は、取引の説明文に転記され、取引履歴などに表示されます。


```json
{
  "type": "string",
  "maxLength": 200
}
```

**`is_onetime`** 
  

チャージQRコードが一度の読み取りで失効するときに`true`にします。デフォルト値は`true`です。

`false`の場合、複数ユーザによって読み取り可能なQRコードになります。
ただし、その場合も1ユーザにつき1回のみしか読み取れません。


```json
{
  "type": "boolean"
}
```

**`usage_limit`** 
  

複数ユーザによって読み取り可能なチャージQRコードの最大読み取り回数を指定します。

NULLに設定すると無制限に読み取り可能なチャージQRコードになります。
デフォルト値はNULLです。
ワンタイム指定(`is_onetime`)がされているときは、本パラメータはNULLである必要があります。


```json
{
  "type": "integer",
  "minimum": 1
}
```

**`expires_at`** 
  

チャージQRコード自体の失効日時を指定します。

この日時以降はチャージQRコードを読み取れなくなります。
チャージQRコード自体の失効日時であって、チャージQRコードによって付与されるマネー残高の有効期限とは異なることに注意してください。マネー残高の有効期限はマネー設定で指定されているものになります。


```json
{
  "type": "string",
  "format": "date-time"
}
```

**`point_expires_at`** 
  

チャージQRコードによって付与されるポイント残高の有効期限を指定します。

チャージQRコードにより付与されるマネー残高の有効期限はQRコード毎には指定できませんが、ポイント残高の有効期限は本パラメータにより、QRコード毎に個別に指定することができます。


```json
{
  "type": "string",
  "format": "date-time"
}
```

**`point_expires_in_days`** 
  

チャージQRコードによって付与されるポイント残高の有効期限を相対日数で指定します。

1を指定すると、チャージQRコード作成日の当日中に失効します(翌日0時に失効)。
`point_expires_at`と`point_expires_in_days`が両方指定されている場合は、チャージQRコードによるチャージ取引ができた時点からより近い方が採用されます。
`point_expires_at`と`point_expires_in_days`が両方NULLに設定されている場合は、マネーに設定されている残高の有効期限と同じになります。


```json
{
  "type": "integer",
  "minimum": 1
}
```

**`metadata`** 
  


```json
{
  "type": "string",
  "format": "json"
}
```



成功したときは
[Check](./responses.md#check)
を返します



---



