import '../domain/entities/savingGoals.dart';

final List<SavingGoal> savingGoals = [
  SavingGoal(
    id: "1",
    title: "New Laptop",
    currentAmount: 3000,
    targetAmount: 8000,
    targetDate: DateTime(2026, 6, 1),
    status: "In progress",
  ),
  SavingGoal(
    id: "2",
    title: "Trip to Turkey",
    currentAmount: 5000,
    targetAmount: 5000,
    targetDate: DateTime(2025, 12, 1),
    status: "Completed",
  ),
];
