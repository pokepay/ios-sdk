public enum TokenInfo {
    case cashtray (String)
    case bill (BankAPI.Bill.Get.Response)
    case check (BankAPI.Check.Get.Response)
    case cpm (BankAPI.CpmToken.Get.Response)
    case pokeregi (String)
}
