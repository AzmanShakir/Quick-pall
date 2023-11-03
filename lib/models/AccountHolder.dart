class AccountHolder {
  AccountHolder(
      {required this.Country,
      required this.Email,
      required this.Image,
      required this.Money,
      required this.Name,
      required this.Password,
      required this.Phone,
      required this.IsActive,
      required this.Pin});

  String Email;
  String Password;
  String Name;
  String Country;
  String Phone;
  String Pin;
  String Image;
  int Money;
  bool IsActive;
}
