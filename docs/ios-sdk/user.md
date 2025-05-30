# User
ユーザを表すデータです。
エンドユーザ(Customer)と店舗ユーザ(Merchant)の2種類が存在します。
エンドユーザは認証の主体であり、マネー毎にウォレットを持ちます。
店舗ユーザは組織に所属し、同じくマネー毎にウォレットを持ちます。


<a name="get-user"></a>
## GetUser: Show the user information

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



成功したときは
[UserWithDetails](./responses.md#user-with-details)
を返します



---


<a name="update-user"></a>
## UpdateUser: ユーザ情報の更新
ユーザ情報を更新します

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

**`name`** 
  

ユーザのニックネームを指定します

```json
{
  "type": "string",
  "maxLength": 256
}
```



成功したときは
[UserWithDetails](./responses.md#user-with-details)
を返します



---


<a name="get-user-with-auth-factors"></a>
## GetUserWithAuthFactors: ユーザの認証情報の取得
ユーザの認証情報を取得します

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



成功したときは
[UserWithAuthFactors](./responses.md#user-with-auth-factors)
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


<a name="get-user-accounts"></a>
## GetUserAccounts: ユーザのアカウント一覧取得
ユーザのアカウント一覧を取得します

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



成功したときは
[PaginatedUserAccounts](./responses.md#paginated-user-accounts)
を返します



---


<a name="get-user-setting-url"></a>
## GetUserSettingUrl: 一時的なフルアクセスを許可する認証のためのURLを取得
OAuthを使って一時的なフルアクセスを許可するための認証ページURLを取得します。

通常のOAuth認証では、特定の発行体のスコープでの操作が許可されています。
一方で、ログイン時の電話番号やEmail、パスワードの変更はそのユーザのポケペイプラットフォーム上の全てのマネーに影響するため、ポケペイが提供するWeb UI上での再認証と認証要素の変更操作が必要になります。
このAPIではポケペイプラットフォームの認証情報変更ページへのワンタイムURLを返します。

```swift

```









---



