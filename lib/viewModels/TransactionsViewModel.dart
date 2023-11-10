class TransactionsViewModel {
  TransactionsViewModel(
      {required this.Image,
      required this.Money,
      required this.Name,
      required this.dateTime,
      required this.transactionType});
  String Name;
  String Image;
  String Money;
  DateTime dateTime;
  String transactionType;
}
