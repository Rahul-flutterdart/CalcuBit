


import '../../data/models/expense_model.dart';
import '../../data/repo/expenserepository.dart';

class GetExpenseUseCase {
  final ExpenseRepository repository;

  GetExpenseUseCase(this.repository);

  Future<List<Expense>> call() async {

    return await repository.getExpenses();
  }
}
