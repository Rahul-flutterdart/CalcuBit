
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../presentation/views/addexpenseview.dart';
import '../presentation/views/expense_summary.dart';
import '../presentation/views/homeview.dart';
import '../presentation/views/loginview.dart';
import '../presentation/views/registerationview.dart';

import 'package:flutter/material.dart';


class Routes {
  static const String login = '/login';
  static const String home = '/home';
  static const String register = '/register';
  static const String addExpense = '/add-expense';
  static const String expenseSummary = '/expense-summary'; // ✅ New Route

  static final List<GetPage> pages = [
    GetPage(name: login, page: () => _buildWithLoader(LoginView())),
    GetPage(name: home, page: () => _buildWithLoader(HomeView())),
    GetPage(name: register, page: () => _buildWithLoader(RegisterView())),
    GetPage(name: addExpense, page: () => _buildWithLoader(AddExpenseView())),
    GetPage(name: expenseSummary, page: () => _buildWithLoader(ExpenseSummaryView())), // ✅ New Page
  ];

  // ✅ Wrapper Function to Show Loader Before Page Loads
  static Widget _buildWithLoader(Widget page) {
    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: 500)), // Simulate Loading Time
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SpinKitFadingCircle( // ✅ Loading Animation
              color: Colors.blueAccent,
              size: 50.0,
            ),
          );
        } else {
          return page;
        }
      },
    );
  }
}

