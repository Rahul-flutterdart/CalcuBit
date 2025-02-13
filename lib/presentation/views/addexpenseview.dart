import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../services/notificationservice.dart';
import '../viewmodels/expensecontroller.dart';
import '../../data/models/expense_model.dart';


class AddExpenseView extends StatefulWidget {
  @override
  _AddExpenseViewState createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  final ExpenseController controller = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final NotificationService notificationService = NotificationService();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String formattedTime = "";  // ✅ Formatted time string

// ✅ Default time

  Future<void> _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    formattedTime = _formatTime(selectedTime);  // ✅ Initialize time format
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        title: Text("Add Expense", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 4,
      ),
      body:SingleChildScrollView( // ✅ Fix Overflow on Keyboard
    child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(titleController, "Title", Icons.title),
            SizedBox(height: 12),
            _buildTextField(amountController, "Amount", Icons.attach_money, keyboardType: TextInputType.number),
            SizedBox(height: 12),
            _buildTextField(categoryController, "Discription", Icons.category),
            SizedBox(height: 16),

            // ✅ Date Picker
            InkWell(
              onTap: _pickDate,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2))],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Selected Date: ${DateFormat.yMMMd().format(selectedDate)}",
                      style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                    ),
                    Icon(Icons.calendar_today, color: Colors.white),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: _pickTime,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2))],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Selected Time: ${selectedTime.format(context)}",
                      style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                    ),
                    Icon(Icons.access_time, color: Colors.white),
                  ],
                ),
              ),
            ),


            SizedBox(height: 20),

            // ✅ Save Button
            ElevatedButton(
              onPressed: _saveExpense,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent.shade700,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.save, color: Colors.white),
                  SizedBox(width: 8),
                  Text("Save Expense", style: GoogleFonts.poppins(color: Colors.blueAccent)),

                ],
              ),
            ),
          ],
        ),
      ),
      )


    );
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _saveExpense() async {
    final isEditing = Get.arguments != null;
    final expense = Expense(
      id: isEditing ? Get.arguments.id : null,
      title: titleController.text,
      amount: double.tryParse(amountController.text) ?? 0.0,
      date: selectedDate,
      description: categoryController.text,
      time: formattedTime,


    );

    if (isEditing) {
      await controller.updateExpense(expense);  // ✅ Call Update instead of Add
    } else {
      await controller.addExpense(expense);
    }

    // ✅ Show Snackbar ALWAYS (whether notification works or not)
    Get.snackbar(
      "Success", isEditing ? "Expense Updated" : "Expense Added",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    try {
      // ✅ Attempt to send notification
      // await notificationService.showNotification(
      //   title: "Expense Added",
      //   body: "You added ${expense.title} for ₹${expense.amount}",
      // );
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
    } catch (e) {
      print("❌ Error sending notification: $e");
    }

    // ✅ Always Navigate Back
    Get.back();
  }

  String _formatTime(TimeOfDay time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";  // 24-hour format
  }
  // ✅ Custom TextField with Icons
  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.blueGrey.shade800,
      ),
    );
  }
}
