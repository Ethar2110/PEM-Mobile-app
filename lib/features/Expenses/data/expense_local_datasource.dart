
import '../domain/entities/expense.dart';

class ExpenseLocalDataSource {
  final List<Expense> _expenses = [
    Expense(
      id: "1",
      title: "Lunch at Joe’s",
      category: "Food",
      details: "Burger + drink",
      date: DateTime.now(),
      amount: 12.5,
    ),
    Expense(
      id: "3",
      title: "Movie Night",
      category: "Entertainment",
      details: "Cinema ticket",
      date: DateTime.now().subtract(const Duration(days: 2)),
      amount: 8.75,
    ),
    Expense(
      id: "4",
      title: "New Shoes",
      category: "Shopping",
      details: "Cinema ticket",
      date: DateTime.now().subtract(const Duration(days: 3)),
      amount: 45.0,
    ),
    Expense(
      id: "1",
      title: "Lunch at Joe’s",
      category: "Food",
      details: "Cinema ticket",
      date: DateTime.now(),
      amount: 12.5,
    ),
  ];

  List<Expense> getExpenses() {
    return _expenses;
  }

  void addExpense(Expense expense) {
    _expenses.add(expense);
  }
}
