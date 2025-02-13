import '../../data/models/expense_model.dart';
import '../../data/repo/expenserepository.dart';

import 'package:expensetracker/data/models/expense_model.dart';

class AddExpenseUseCase {
  final ExpenseRepository repository;

  AddExpenseUseCase(this.repository);

  Future<void> call(Expense expense) async {
    await repository.addExpense(expense);  // ✅ Pass Expense object, not Map
  }
}
