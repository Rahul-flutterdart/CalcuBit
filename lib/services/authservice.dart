// auth_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _usernameKey = "username";
  static const String _passwordKey = "password";
  static const String _loggedInKey = "is_logged_in";

  // ✅ Register User (Save username & password)

  Future<bool> register(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.clear();
    // 🔹 Check if the exact username already exists
    String? storedUsername = prefs.getString(_usernameKey);

    if (storedUsername != null && storedUsername == username) {
      return false;  // ❌ User already exists
    }

    // ✅ Store new user credentials
    await prefs.setString(_usernameKey, username);
    await prefs.setString(_passwordKey, password);
    await prefs.setBool(_loggedInKey, true);  // ✅ Mark user as logged in
    return true;  // ✅ Registration successful
  }


  // ✅ Login User (Verify credentials)
  Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final storedUsername = prefs.getString(_usernameKey);
    final storedPassword = prefs.getString(_passwordKey);

    print("Stored username: $storedUsername, Entered: $username");
    print("Stored password: $storedPassword, Entered: $password");

    if (storedUsername == username && storedPassword == password) {
      await prefs.setBool(_loggedInKey, true);
      return true;  // ✅ Login successful
    }

    print("Login failed: Incorrect credentials");
    return false;  // ❌ Login failed
  }


  // ✅ Get Logged-in User
  Future<String?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) == true ? prefs.getString(_usernameKey) : null;
  }

  // ✅ Logout User
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, false);
  }

  // ✅ Check if User is Logged In
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }
}

