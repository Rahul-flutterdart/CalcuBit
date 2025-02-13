import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../viewmodels/authcontroller.dart';

class RegisterView extends StatelessWidget {
  final AuthController authController = Get.find();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body:  Center( // ✅ Centers the card on screen
        child: SingleChildScrollView( // ✅ Prevents overflow when keyboard appears
          child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 6,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person_add, size: 60, color: Colors.green), // ✅ 3D Icon
                  SizedBox(height: 20),
                  Text("Register", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  _buildTextField(usernameController, "Username", Icons.person),
                  SizedBox(height: 20),
                  _buildTextField(passwordController, "Password", Icons.lock, isPassword: true),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      bool success = await authController.register(usernameController.text, passwordController.text);
                      if (success) {
                        Get.snackbar("Success", "Account created!", snackPosition: SnackPosition.BOTTOM);
                        Get.offNamed('/home');
                      } else {
                        Get.snackbar("Error", "User already exists", snackPosition: SnackPosition.BOTTOM);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    ),
                    child: Text("Register", style: GoogleFonts.poppins(fontSize: 18)),
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed('/login'),
                    child: Text("Already have an account? Login", style: GoogleFonts.poppins(color: Colors.green)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),

      )
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade200,
      ),
    );
  }
}

