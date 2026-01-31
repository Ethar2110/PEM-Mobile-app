import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/expense.dart';
import '../../domain/repositories/expense_repository.dart';

class ExpenseCubit extends Cubit<List<Expense>> {
  final ExpenseRepository repository;

  ExpenseCubit(this.repository) : super([]) {
    loadExpenses();
  }

  void loadExpenses() {
    emit(repository.getExpenses());
  }

  void addExpense(Expense expense) {
    repository.addExpense(expense);
    emit(repository.getExpenses());
  }
}
