class TransactionsViewModel {
  TransactionsViewModel(
      {required this.Image,
      required this.Money,
      required this.Name,
      required this.dateTime,
      required this.transactionType,
      required this.Reason,
      required this.TransactionReference,
      required this.Email,
      required this.IsActive});
  String Name;
  String Email;
  String Image;
  String Money;
  DateTime dateTime;
  String transactionType;
  String TransactionReference;
  String Reason;
  bool IsActive;
}
