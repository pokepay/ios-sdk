# Merchants
店舗ユーザを表すデータです。
発行体直営店と加盟組織直営店(加盟店)の2種類が存在します。
店舗毎に所有するウォレットによって取引可能なマネーが決定されます。


<a name="list-merchant-transactions"></a>
## ListMerchantTransactions: Show the merchant's transaction

```swift

```



### Parameters
**`transaction_id`** 
  


```json
{
  "type": "string",
  "format": "uuid"
}
```



成功したときは
[UserTransactionWithCustomerBalance](./responses.md#user-transaction-with-customer-balance)
を返します



---



