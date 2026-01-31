import '../entities/expense.dart';

abstract class ExpenseRepository {
  List<Expense> getExpenses();
  void addExpense(Expense expense);
}
