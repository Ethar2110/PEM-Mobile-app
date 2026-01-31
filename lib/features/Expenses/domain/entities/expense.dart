class Expense {
  final String id;
  final String title;
  final String category;
  final String details;
  final DateTime date;
  final double amount;

  Expense({
    required this.id,
    required this.title,
    required this.category,
    required this.details,
    required this.date,
    required this.amount,
  });
}
