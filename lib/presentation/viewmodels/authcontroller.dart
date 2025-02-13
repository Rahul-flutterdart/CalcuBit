// auth_controller.dart
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/authservice.dart';
class AuthController extends GetxController {
  final AuthService authService = AuthService();
  var username = "".obs;

  @override
  void onInit() {
    checkUser();
    super.onInit();
  }

  // ✅ Check if a user is already logged in
  void checkUser() async {
    username.value = await authService.getUser() ?? "";
  }

  // ✅ Register User (Now uses `AuthService`)
  Future<bool> register(String user, String password) async {
    bool success = await authService.register(user, password);

    if (success) {
      username.value = user;
    }

    return success;
  }


  // ✅ Login User (Now uses `AuthService`)
  Future<bool> login(String user, String password) async {
    bool success = await authService.login(user, password);

    if (success) {
      username.value = user;
      print("Login successful! Navigating to Home...");
      Get.offAllNamed('/home');  // ✅ Navigate after login
    } else {
      print("Login failed: Showing error");
      Get.snackbar("Error", "Invalid username or password", snackPosition: SnackPosition.BOTTOM);
    }

    return success;
  }


  // ✅ Logout (Now uses `AuthService`)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    username.value = "";
    Get.offAllNamed('/login');  // ✅ Navigate to login screen
  }

  // ✅ Check if User is Logged In
  Future<bool> isLoggedIn() async {
    return await authService.isLoggedIn();
  }
}
