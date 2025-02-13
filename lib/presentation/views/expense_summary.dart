import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodels/expensecontroller.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';


class ExpenseSummaryView extends StatelessWidget {
  final ExpenseController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900, // ✅ Consistent Background
      appBar: AppBar(
        title: Text("Expense Summary", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4,
      ),
      body: Obx(() {
        if (controller.expenses.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitWave(color: Colors.blueAccent, size: 40), // ✅ Animated Loading
                SizedBox(height: 20),
                Text("No expenses recorded yet.", style: GoogleFonts.poppins(fontSize: 18, color: Colors.white70)),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // ✅ Expense Summary Card
              Card(
                color: Colors.blueGrey.shade800,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text("Total Expenses This Month",
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 10),
                      Text("₹${controller.getTotalExpensesThisMonth().toStringAsFixed(2)}",
                          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // ✅ Pie Chart for Expense Categories
              Expanded(
                child: Card(
                  color: Colors.blueGrey.shade800,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text("Expense Distribution",
                            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        SizedBox(height: 10),
                        Expanded(
                          child: PieChart(
                            PieChartData(
                              sections: controller.getExpenseCategoryData(),
                              sectionsSpace: 2,
                              centerSpaceRadius: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
