class NotificationViewModel {
  NotificationViewModel(
      {required this.Amount,
      required this.FromEmail,
      required this.Id,
      required this.IsActive,
      required this.IsClicked,
      required this.NotificationType,
      required this.createdAt,
      required this.updatedAt,
      required this.Image,
      required this.Name});
  NotificationViewModel.copy(NotificationViewModel n)
      : this.Id = n.Id,
        this.Amount = n.Amount,
        this.FromEmail = n.FromEmail,
        this.Image = n.Image,
        this.IsActive = n.IsActive,
        this.IsClicked = n.IsClicked,
        this.Name = n.Name,
        this.NotificationType = n.NotificationType,
        this.createdAt = n.createdAt,
        this.updatedAt = n.updatedAt;

  String Id;
  String FromEmail;
  String Image;
  String Name;
  bool IsActive;
  String NotificationType;
  bool IsClicked;
  String Amount;
  DateTime createdAt;
  DateTime updatedAt;
}
