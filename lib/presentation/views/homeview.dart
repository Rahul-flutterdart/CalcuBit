import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../viewmodels/expensecontroller.dart';
import '../viewmodels/authcontroller.dart';
import '../../data/models/expense_model.dart';

class HomeView extends StatelessWidget {
  final ExpenseController controller = Get.put(ExpenseController());
  final AuthController authController = Get.find(); // ✅ Auth Controller for Logout

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900, // ✅ Modern background color
      appBar: AppBar(
        title: Text('Expense Tracker', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        actions: [
          // ✅ Expense Summary Navigation
          IconButton(
            icon: Icon(Icons.bar_chart, color: Colors.white),
            tooltip: "View Expense Summary",
            onPressed: () => Get.toNamed('/expense-summary'),
          ),
          // ✅ Logout Menu
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              if (value == "logout") {
                _showLogoutDialog();
                Get.toNamed('/login');
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: "logout", child: Text("Logout")),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(() {
          if (controller.expenses.isEmpty) {
            return Center(
              child: Text(
                "No Expenses Yet",
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.white70),
              ),
            );
          }
          return ListView.builder(
            itemCount: controller.expenses.length,
            itemBuilder: (context, index) {
              final expense = controller.expenses[index];
              return _buildExpenseCard(expense);
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/add-expense'),
        backgroundColor: Colors.blueAccent,
        elevation: 6,
        child: Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }

  // ✅ Custom Card UI for expenses with Edit Feature
  Widget _buildExpenseCard(Expense expense) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent.shade100,
          child: Icon(Icons.money, color: Colors.white),
        ),
        title: Text(
          expense.title,
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          "₹${expense.amount.toStringAsFixed(2)} - ${expense.description}",
          style: GoogleFonts.poppins(color: Colors.grey.shade700),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ Edit Button
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () => Get.toNamed('/add-expense', arguments: expense), // ✅ Pass expense for editing
            ),
            // ✅ Delete Button
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _showDeleteDialog(expense.id!),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Confirm delete dialog
  void _showDeleteDialog(int id) {
    Get.defaultDialog(
      title: "Delete Expense?",
      middleText: "Are you sure you want to delete this expense?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: Colors.white,
      onConfirm: () {
        controller.deleteExpense(id);
        Get.back();
        Get.snackbar("Deleted", "Expense removed successfully", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
      },
    );
  }

  // ✅ Confirm logout dialog
  void _showLogoutDialog() {
    Get.defaultDialog(
      title: "Logout?",
      middleText: "Are you sure you want to logout?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: Colors.white,
      onConfirm: () {
        authController.logout();
      },
    );
  }
}
