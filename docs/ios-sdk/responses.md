# Responses
<a name="user-with-details"></a>
## UserWithDetails
* `id`: 
* `name`: 
* `is-merchant`: 
* `tel`: 
* `email`: 

<a name="user-with-auth-factors"></a>
## UserWithAuthFactors
* `id`: 
* `name`: 
* `is-merchant`: 
* `tel`: 
* `email`: 
* `is-password-registered`: 

<a name="account-detail"></a>
## AccountDetail
* `id`: 
* `name`: 
* `balance`: 
* `money-balance`: 
* `point-balance`: 
* `is-suspended`: 
* `private_money`: 
* `nearest-expires-at`: 

`private_money`は [PrivateMoneyDetail](#private-money-detail) オブジェクトを返します。

<a name="account-campaign-point-amounts"></a>
## AccountCampaignPointAmounts
* `max-total-point-amount`: 
* `total-point-amount`: 
* `remain-point-amount`: 

<a name="paginated-private-moneys"></a>
## PaginatedPrivateMoneys
* `per-page`: 
* `count`: 
* `next`: 
* `prev`: 
* `items`: 

`items`は [PrivateMoney](#private-money) オブジェクトの配列を返します。

<a name="private-money-detail"></a>
## PrivateMoneyDetail

<a name="terminal"></a>
## Terminal
* `id`: 
* `name`: 
* `hardware-id`: 
* `push-service`: 
* `push-token`: 
* `user`: 
* `account`: 

`user`は [UserWithDetails](#user-with-details) オブジェクトを返します。

<a name="user-transaction"></a>
## UserTransaction
* `id`: 取引ID
* `user`: ユーザ
* `balance`: 
* `amount`: 
* `money-amount`: 取引マネー額
* `point-amount`: 取引ポイント額
* `account`: ウォレット
* `description`: 取引説明文
* `done-at`: 取引完了時刻
* `type`: 取引タイプ
* `is-modified`: 取引キャンセルの有無

`user`は [User](#user) オブジェクトを返します。

`account`は [Account](#account) オブジェクトを返します。

<a name="user-transaction-with-customer-balance"></a>
## UserTransactionWithCustomerBalance
* `id`: 
* `user`: ユーザ
* `balance`: 
* `customer-balance`: 
* `amount`: 
* `money-amount`: 
* `point-amount`: 
* `account`: ウォレット
* `description`: 
* `done-at`: 
* `type`: 
* `is-modified`: 

`user`は [User](#user) オブジェクトを返します。

`account`は [Account](#account) オブジェクトを返します。

<a name="credit-card"></a>
## CreditCard
* `card-number`: 
* `registered-at`: 

<a name="paginated-credit-cards"></a>
## PaginatedCreditCards
* `per-page`: 
* `count`: 
* `next`: 
* `prev`: 
* `items`: 

`items`は [CreditCard](#credit-card) オブジェクトの配列を返します。

<a name="user-banks"></a>
## UserBanks

<a name="check"></a>
## Check
* `id`: 
* `amount`: 
* `money-amount`: 
* `point-amount`: 
* `description`: 
* `user`: ユーザ
* `is-onetime`: 
* `is-disabled`: 
* `expires-at`: 
* `private_money`: 
* `token`: 

`user`は [User](#user) オブジェクトを返します。

`private_money`は [PrivateMoney](#private-money) オブジェクトを返します。

<a name="bill"></a>
## Bill
* `id`: 
* `amount`: 
* `description`: 
* `user`: ユーザ
* `is-onetime`: 
* `is-disabled`: 
* `private_money`: 
* `token`: 
* `max-amount`: 
* `min-amount`: 

`user`は [User](#user) オブジェクトを返します。

`private_money`は [PrivateMoney](#private-money) オブジェクトを返します。

<a name="bill-with-additional-private-moneys"></a>
## BillWithAdditionalPrivateMoneys
* `id`: 
* `amount`: 
* `description`: 
* `user`: ユーザ
* `is-onetime`: 
* `is-disabled`: 
* `private_money`: 
* `token`: 
* `max-amount`: 
* `min-amount`: 
* `additional-private-moneys`: 

`user`は [User](#user) オブジェクトを返します。

`private_money`は [PrivateMoney](#private-money) オブジェクトを返します。

`additional-private-moneys`は [PrivateMoney](#private-money) オブジェクトの配列を返します。

<a name="cashtray"></a>
## Cashtray
* `id`: 
* `amount`: 
* `description`: 
* `user`: ユーザ
* `private_money`: 
* `expires-at`: 
* `canceled-at`: 
* `token`: 

`user`は [User](#user) オブジェクトを返します。

`private_money`は [PrivateMoney](#private-money) オブジェクトを返します。

<a name="cashtray-attempts"></a>
## CashtrayAttempts
* `rows`: 

`rows`は [CashtrayAttempt](#cashtray-attempt) オブジェクトの配列を返します。

<a name="cashtray-with-attempt-and-transaction"></a>
## CashtrayWithAttemptAndTransaction

<a name="cpm-token"></a>
## CpmToken
* `cpm-token`: CPMトークン文字列
* `account`: ウォレット
* `transaction`: 
* `scopes`: 取引スコープ
* `expires-at`: 有効期限
* `metadata`: 取引メタデータ

`account`は [Account](#account) オブジェクトを返します。

`transaction`は [UserTransaction](#user-transaction) オブジェクトを返します。

<a name="terminal-server-key"></a>
## TerminalServerKey
* `server-key`: 

<a name="coupon-detail"></a>
## CouponDetail
* `id`: 
* `name`: 
* `description`: 
* `discount-amount`: 
* `discount-percentage`: 
* `starts-at`: 
* `ends-at`: 
* `display-starts-at`: 
* `display-ends-at`: 
* `usage-limit`: 
* `min-amount`: 
* `is-shop-specified`: 
* `is-disabled`: 
* `is-hidden`: 
* `coupon-image`: 
* `received-at`: 
* `usage-count`: 
* `available-shops`: 

`available-shops`は [User](#user) オブジェクトの配列を返します。

<a name="identification-result"></a>
## IdentificationResult
* `is-valid`: 
* `identified-at`: 
* `match`: 

<a name="paginated-account-balances"></a>
## PaginatedAccountBalances
* `per-page`: 
* `count`: 
* `next`: 
* `prev`: 
* `items`: 

`items`は [AccountBalance](#account-balance) オブジェクトの配列を返します。

<a name="paginated-account-coupons"></a>
## PaginatedAccountCoupons
* `per-page`: 
* `count`: 
* `next`: 
* `prev`: 
* `items`: 

`items`は [Coupon](#coupon) オブジェクトの配列を返します。

<a name="paginated-account-transactions"></a>
## PaginatedAccountTransactions
* `per-page`: 
* `count`: 
* `next`: 
* `prev`: 
* `items`: 

`items`は [UserTransaction](#user-transaction) オブジェクトの配列を返します。

<a name="paginated-account-transfers"></a>
## PaginatedAccountTransfers
* `per-page`: 
* `count`: 
* `next`: 
* `prev`: 
* `items`: 

`items`は [UserTransfer](#user-transfer) オブジェクトの配列を返します。

<a name="paginated-private-money-coupons"></a>
## PaginatedPrivateMoneyCoupons
* `per-page`: 
* `count`: 
* `next`: 
* `prev`: 
* `items`: 

`items`は [Coupon](#coupon) オブジェクトの配列を返します。

<a name="paginated-user-accounts"></a>
## PaginatedUserAccounts
* `per-page`: 
* `count`: 
* `next`: 
* `prev`: 
* `items`: 

`items`は [Account](#account) オブジェクトの配列を返します。

<a name="paginated-user-transactions"></a>
## PaginatedUserTransactions
* `per-page`: 
* `count`: 
* `next`: 
* `prev`: 
* `items`: 

`items`は [UserTransaction](#user-transaction) オブジェクトの配列を返します。

<a name="private-money"></a>
## PrivateMoney
* `id`: 
* `name`: 
* `type`: 
* `unit`: 
* `description`: 
* `oneline-message`: 
* `display-money-and-point`: 
* `account-image`: 
* `images`: 
* `organization`: 
* `max-balance`: 
* `transfer-limit`: 
* `expiration-type`: 
* `is-exclusive`: 
* `terms-url`: 
* `privacy-policy-url`: 
* `payment-act-url`: 
* `commercial-act-url`: 

`images`は [PrivateMoneyImages](#private-money-images) オブジェクトを返します。

`organization`は [Organization](#organization) オブジェクトを返します。

<a name="user"></a>
## User
* `id`: ユーザID
* `name`: ユーザ名(ニックネーム)
* `is-merchant`: ユーザが店舗ユーザかどうか

<a name="account"></a>
## Account
* `id`: ウォレットID
* `name`: ウォレット名
* `balance`: ウォレット残高(マネー額 + ポイント額)
* `money-balance`: ウォレット残高(マネー額)
* `point-balance`: ウォレット残高(ポイント額)
* `point-debt`: ポイント負債
* `is-suspended`: ウォレットが凍結状態かどうか
* `private_money`: 

`private_money`は [PrivateMoney](#private-money) オブジェクトを返します。

<a name="cashtray-attempt"></a>
## CashtrayAttempt
* `user`: ユーザ
* `account`: ウォレット
* `status-code`: 
* `error-type`: 
* `error-message`: 
* `created-at`: 
* `strategy`: 

`user`は [User](#user) オブジェクトを返します。

`account`は [Account](#account) オブジェクトを返します。

`strategy`は [TransactionStrategy](#transaction-strategy) オブジェクトを返します。

<a name="account-balance"></a>
## AccountBalance
* `expires-at`: 
* `money-amount`: 
* `point-amount`: 

<a name="coupon"></a>
## Coupon
* `id`: 
* `name`: 
* `description`: 
* `discount-amount`: 
* `discount-percentage`: 
* `starts-at`: 
* `ends-at`: 
* `display-starts-at`: 
* `display-ends-at`: 
* `usage-limit`: 
* `min-amount`: 
* `is-shop-specified`: 
* `is-disabled`: 
* `is-hidden`: 
* `coupon-image`: 

<a name="user-transfer"></a>
## UserTransfer
* `id`: 
* `transaction-id`: 
* `user`: ユーザ
* `balance`: 
* `amount`: 
* `money-amount`: 
* `point-amount`: 
* `account`: ウォレット
* `description`: 
* `done-at`: 
* `type`: 

`user`は [User](#user) オブジェクトを返します。

`account`は [Account](#account) オブジェクトを返します。

<a name="private-money-images"></a>
## PrivateMoneyImages
* `card`: 
* `300x300`: 
* `600x600`: 

<a name="organization"></a>
## Organization
* `code`: 
* `name`: 

<a name="transaction-strategy"></a>
## TransactionStrategy
