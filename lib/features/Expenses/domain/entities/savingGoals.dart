class SavingGoal {
  final String id;
  final String title;
  final double currentAmount;
  final double targetAmount;
  final DateTime targetDate;
  final String status;

  SavingGoal({
    required this.id,
    required this.title,
    required this.currentAmount,
    required this.targetAmount,
    required this.targetDate,
    required this.status,
  });

  double get progress => currentAmount / targetAmount;
}
