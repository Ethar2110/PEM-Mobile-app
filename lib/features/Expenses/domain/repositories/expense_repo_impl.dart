import '../../data/expense_local_datasource.dart';
import '../../domain/entities/expense.dart';
import '../../domain/repositories/expense_repository.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource localDataSource;

  ExpenseRepositoryImpl(this.localDataSource);

  @override
  List<Expense> getExpenses() {
    return localDataSource.getExpenses();
  }

  @override
  void addExpense(Expense expense) {
    localDataSource.addExpense(expense);
  }
}
