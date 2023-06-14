class Bill {
  String name;
  DateTime payDate;
  bool isPaid;
  double amount;
  String details;
  String billId;

  Bill({
    required this.name,
    required this.payDate,
    required this.isPaid,
    required this.amount,
    required this.details,
    required this.billId,
  });
}
