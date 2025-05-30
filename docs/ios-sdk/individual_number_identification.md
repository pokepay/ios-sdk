# Individual Number Identification
マイナンバーを表すデータです。
マイナンバーカード認証の機能を提供しています。
カード情報はサーバでは保有せず、カード読み取り(抽出)、読み取り情報の正当性確認を外部サービスで実施しています。


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



