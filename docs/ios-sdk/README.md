<a name="api-operations"></a>
## API Operations

### Terminal
- [GetTerminal](./terminal.md#get-terminal): 端末の情報を取得
- [UpdateTerminal](./terminal.md#update-terminal): 端末の情報を変更
- [AddTerminalPublicKey](./terminal.md#add-terminal-public-key): 端末に新たな公開鍵を追加

### Check
- [DeleteCheck](./check.md#delete-check): チャージQRコードを無効にする
- [GetCheck](./check.md#get-check): チャージQRコードを取得する
- [UpdateCheck](./check.md#update-check): チャージQRコードを修正する
- [CreateCheck](./check.md#create-check): チャージQRコードの発行する

### Bill
- [DeleteBill](./bill.md#delete-bill): 作成済みBillを無効化する
- [GetBill](./bill.md#get-bill): 作成済みBillの設定内容を参照する
- [UpdateBill](./bill.md#update-bill): Billの設定内容を更新
- [ListBillTransactions](./bill.md#list-bill-transactions): Billによる取引一覧を取得する
- [GetBillLastTransaction](./bill.md#get-bill-last-transaction): Get the last transaction of bill
- [CreateBill](./bill.md#create-bill): 支払い用QR(トークン)を新規登録

### Cashtray
- [DeleteCashtray](./cashtray.md#delete-cashtray): Cashtrayを無効化
- [GetCashtray](./cashtray.md#get-cashtray): Cashtrayの設定内容を参照
- [UpdateCashtray](./cashtray.md#update-cashtray): Cashtrayの設定内容を更新
- [CreateCashtray](./cashtray.md#create-cashtray): Cashtrayを新規登録
- [GetCashtrayAttempts](./cashtray.md#get-cashtray-attempts): Cashtrayを利用した決済の状況を確認

### Credit Card
- [GetCreditCards](./credit_card.md#get-credit-cards): Get user credit cards
- [CreateCreditCard](./credit_card.md#create-credit-card): Create user credit card
- [DeleteCreditCard](./credit_card.md#delete-credit-card): Create user credit card
- [TopupWithCreditCardMembership](./credit_card.md#topup-with-credit-card-membership): 会員情報によるクレジットカードチャージ
- [TopupWithCreditCardMdkToken](./credit_card.md#topup-with-credit-card-mdk-token): MDKトークンによるクレジットカードチャージ

### User
- [GetUser](./user.md#get-user): Show the user information
- [UpdateUser](./user.md#update-user): ユーザ情報の更新
- [GetUserWithAuthFactors](./user.md#get-user-with-auth-factors): ユーザの認証情報の取得
- [GetUserTransactions](./user.md#get-user-transactions): 取引情報の取得
- [GetUserAccounts](./user.md#get-user-accounts): ユーザのアカウント一覧取得
- [GetUserSettingUrl](./user.md#get-user-setting-url): 一時的なフルアクセスを許可する認証のためのURLを取得

### Bank
- [DeleteBank](./bank.md#delete-bank): 銀行口座との連携を解除
- [ListBanks](./bank.md#list-banks): 登録済みの銀行一覧の取得
- [BankTopUp](./bank.md#bank-top-up): 登録した銀行からのチャージ

### Merchants
- [ListMerchantTransactions](./merchants.md#list-merchant-transactions): Show the merchant's transaction

### Transaction
- [GetTransaction](./transaction.md#get-transaction): 取引情報取得
- [RefundTransaction](./transaction.md#refund-transaction): 取引キャンセル
- [ListBillTransactions](./transaction.md#list-bill-transactions): Billによる取引一覧を取得する
- [GetBillLastTransaction](./transaction.md#get-bill-last-transaction): Get the last transaction of bill
- [GetUserTransactions](./transaction.md#get-user-transactions): 取引情報の取得
- [GetAccountTransactions](./transaction.md#get-account-transactions): 取引履歴取得
- [SendToAccount](./transaction.md#send-to-account): Send money to an account
- [GetAccountTransfers](./transaction.md#get-account-transfers): 取引明細一覧

### Account
- [GetUserAccounts](./account.md#get-user-accounts): ユーザのアカウント一覧取得
- [GetAccount](./account.md#get-account): ウォレット情報を取得する
- [UpdateAccount](./account.md#update-account): Update account information
- [CreateAccount](./account.md#create-account): アカウント作成
- [GetAccountTransactions](./account.md#get-account-transactions): 取引履歴取得
- [SendToAccount](./account.md#send-to-account): Send money to an account
- [GetAccountTransfers](./account.md#get-account-transfers): 取引明細一覧
- [GetAccountBalances](./account.md#get-account-balances): 残高内訳を取得する
- [CreateAccountCpmToken](./account.md#create-account-cpm-token): CPMトークン作成
- [GetAccountCoupons](./account.md#get-account-coupons): クーポン表示
- [GetAccountCouponDetail](./account.md#get-account-coupon-detail): クーポンを取得する
- [PatchAccountCouponDetail](./account.md#patch-account-coupon-detail): クーポンを受け取る
- [IdentifyIndividual](./account.md#identify-individual): マイナンバー確認セッションを作成する

### Individual Number Identification
- [IdentifyIndividual](./individual_number_identification.md#identify-individual): マイナンバー確認セッションを作成する

### Campaign
- [GetAccountCampaignPointAmounts](./campaign.md#get-account-campaign-point-amounts): キャンペーンのポイント付与総額取得

### Cpm
- [CreateAccountCpmToken](./cpm.md#create-account-cpm-token): CPMトークン作成
- [GetCpmToken](./cpm.md#get-cpm-token): CPMトークンの情報を取得

### Sevenbankatm

### Coupon
- [GetAccountCoupons](./coupon.md#get-account-coupons): クーポン表示
- [GetAccountCouponDetail](./coupon.md#get-account-coupon-detail): クーポンを取得する
- [PatchAccountCouponDetail](./coupon.md#patch-account-coupon-detail): クーポンを受け取る
- [GetPrivateMoneyCoupons](./coupon.md#get-private-money-coupons): マネーのクーポン情報を取得

### Private Money
- [GetPrivateMoney](./private_money.md#get-private-money): マネー情報を取得
- [GetPrivateMoneyTerms](./private_money.md#get-private-money-terms): Get the private money terms
- [GetPrivateMoneyPrivacyPolicy](./private_money.md#get-private-money-privacy-policy): Get the private money pricvacy-policy
- [GetPrivateMoneyPaymentAct](./private_money.md#get-private-money-payment-act): Get the private money payment-act
- [GetPrivateMoneyCommercialAct](./private_money.md#get-private-money-commercial-act): Get the private money commercial-act
- [GetUserAttributeSchema](./private_money.md#get-user-attribute-schema): ユーザアンケート項目
- [ListPrivateMoneys](./private_money.md#list-private-moneys): マネー一覧を取得する

### Voucher

### Open Exchange Rates

### Payspot

### Internal
- [GetUserAttributeSchema](./internal.md#get-user-attribute-schema): ユーザアンケート項目

