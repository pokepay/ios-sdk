# Cashtray
設定金額(正負)によって、支払い/チャージトークンの双方を表すデータです。
対面決済において、店舗側アプリケーションによって動的に生成、ユーザへ提示されることを想定しています。
そのためCashtrayを作成できるのは店舗ユーザのみで、ユーザによって読み取られることにより取引が作成されます。
店舗ユーザはCashtrayの状態を監視することができ、取引の成否やエラー事由を知ることができます。

作成時には、設定金額が正の整数である場合はチャージとなり、設定金額が負の整数である場合は支払いとなります。
読み取り後、取引の成否に関わらず１回のみしか利用できないワンタイムトークンです。
有効期限は短命で利用される事例が多いです。これは対面ですぐに読み取られることを想定運用としているためです。



<a name="get-cashtray"></a>
## GetCashtray: Cashtrayの設定内容を参照
作成済みCashtrayの設定内容を確認したいケースに利用します

```swift

```



### Parameters
**`cashtray_id`** 
  

確認するCashtrayのID（トークン作成時のレスポンスに含まれるID）

```json
{
  "type": "string",
  "format": "uuid"
}
```



成功したときは
[CashtrayWithAttemptAndTransaction](./responses.md#cashtray-with-attempt-and-transaction)
を返します



---


<a name="update-cashtray"></a>
## UpdateCashtray: Cashtrayの設定内容を更新
作成済みCashtrayの設定値を変更したいケースに利用します

```swift

```



### Parameters
**`cashtray_id`** 
  

確認するCashtrayのID（トークン作成時のレスポンスに含まれるID）

```json
{
  "type": "string",
  "format": "uuid"
}
```

**`amount`** 
  

決済金額を指定します。正の整数が支払い、負の整数がチャージ決済を意味します

```json
{
  "type": "integer"
}
```

**`description`** 
  

決済用途メモを指定します。決済完了時の取引データの説明欄に転写されます

```json
{
  "type": "string",
  "maxLength": 200
}
```

**`expires_in`** 
  

Cashtrayトークンが有効な期間を秒数で指定します

```json
{
  "type": "integer",
  "minimum": 0
}
```

**`products`** 
  

任意で購入商品情報を指定することが可能です

```json
{
  "type": "array",
  "items": {
    "type": "Product"
  }
}
```



成功したときは
[Cashtray](./responses.md#cashtray)
を返します



---


<a name="create-cashtray"></a>
## CreateCashtray: Cashtrayを新規登録
エンドユーザに対して支払いまたはチャージを行う店舗の情報(店舗ユーザIDとマネーID)と、取引金額が必須項目です。
店舗ユーザIDとマネーIDから店舗ウォレットを特定します。
その他に、Cashtrayから作られる取引に対する説明文や失効時間を指定できます。


```swift

```



### Parameters
**`amount`** 
  

Cashtrayを使った決済金額を表すパラメタです。
正の整数を指定すると支払い、
負の整数を指定するとチャージとなります。

```json
{
  "type": "number",
  "format": "decimal"
}
```

**`description`** 
  

Cashtrayの用途などを記載するメモ欄です。
取引のdescriptionにも転写されるのでエンドユーザにも見えるデータとなります。

```json
{
  "type": "string",
  "maxLength": 200
}
```

**`expires_in`** 
  

Cashtrayトークンが有効な期間を秒数で指定します

```json
{
  "type": "integer",
  "format": "int32",
  "minimum": 0
}
```



成功したときは
[Cashtray](./responses.md#cashtray)
を返します



---


<a name="get-cashtray-attempts"></a>
## GetCashtrayAttempts: Cashtrayを利用した決済の状況を確認
CashtrayはMPM方式で利用されるトークンであり、決済実行する主体はユーザアプリとなるため、店舗側(レジなど)が決済状況を確認するために利用します。
取引が成功した場合は取引データを取得でき、失敗した際はエラー内容を参照できます。

```swift

```



### Parameters
**`cashtray_id`** 
  

確認するCashtrayのIDを指定します（トークン作成時のレスポンスに含まれるID）

```json
{
  "type": "string",
  "format": "uuid"
}
```



成功したときは
[CashtrayAttempts](./responses.md#cashtray-attempts)
を返します



---



