import 'package:expensetracker/presentation/viewmodels/authcontroller.dart';
import 'package:expensetracker/services/notificationservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/routes.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AuthController authController = Get.put(AuthController());
  final notificationService = NotificationService();
  await notificationService.init();


  runApp(MyApp(isLoggedIn: await authController.authService.isLoggedIn()));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      initialRoute: isLoggedIn ? '/home' : '/login',  // ✅ Redirect based on auth state
      getPages: Routes.pages,
    );
  }
}
