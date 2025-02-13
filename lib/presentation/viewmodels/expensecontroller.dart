
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/expense_model.dart';
import '../../data/repo/expenserepository.dart';
import '../../services/notificationservice.dart';

class ExpenseController extends GetxController {
  final ExpenseRepository repository = ExpenseRepository();
  final NotificationService notificationService = NotificationService();

  var expenses = <Expense>[].obs;

  @override
  void onInit() {
    fetchExpenses();
    super.onInit();
  }

  // ✅ Fetch all expenses from the database
  Future<void> fetchExpenses() async {
    expenses.value = await repository.getExpenses();
  }
  double getTotalExpensesThisMonth() {
    DateTime now = DateTime.now();
    return expenses
        .where((expense) => expense.date.month == now.month && expense.date.year == now.year)
        .fold(0, (sum, item) => sum + item.amount);
  }
  Future<void> updateExpense(Expense expense) async {
    await repository.updateExpense(expense);
    fetchExpenses();  // ✅ Refresh List
  }

  // ✅ Prepare Data for Pie Chart
  List<PieChartSectionData> getExpenseCategoryData() {
    Map<String, double> categoryTotals = {};

    for (var expense in expenses) {
      categoryTotals.update(expense.description, (value) => value + expense.amount, ifAbsent: () => expense.amount);
    }

    return categoryTotals.entries.map((entry) {
      return PieChartSectionData(
        title: entry.key,
        value: entry.value,
        color: Colors.primaries[categoryTotals.keys.toList().indexOf(entry.key) % Colors.primaries.length],
        radius: 50,
      );
    }).toList();
  }

  // ✅ Add a new expense
  Future<void> addExpense(Expense expense) async {
    await repository.addExpense(expense);
    fetchExpenses(); // Refresh the list
    //
    // ✅ Instant Notification
    Future.delayed(Duration(milliseconds: 300), () {
      Get.snackbar(
        "Success", "Expense Added Successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    });

    // ✅ Navigate back to Home
    Future.delayed(Duration(seconds: 1), () {
      Get.offNamed('/home');
    });
    await notificationService.showNotification(
      title: "Expense Added",
      body: "You added ${expense.title} for ₹${expense.amount}",
    );

    await notificationService.scheduleNotification(
      title: "Expense Reminder",
      body: "Don't forget your expense: ${expense.title} for ₹${expense.amount}",
      scheduledTime: DateTime.now().add(Duration(days: 1)), // Notification in 1 day
    );
  }

  // ✅ Delete an expense
  Future<void> deleteExpense(int id) async {
    await repository.deleteExpense(id);
    fetchExpenses(); // Refresh the list
  }
}


