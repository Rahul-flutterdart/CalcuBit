import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../viewmodels/authcontroller.dart';

class LoginView extends StatelessWidget {
  final AuthController authController = Get.find();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900, // ✅ Dark background for contrast
      body:  Center( // ✅ Centers the card on screen
        child: SingleChildScrollView( // ✅ Prevents overflow when keyboard appears
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 6,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.lock, size: 60, color: Colors.blueAccent), // ✅ 3D Icon
                  SizedBox(height: 20),
                  Text("Login", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  _buildTextField(usernameController, "Username", Icons.person),
                  SizedBox(height: 20),
                  _buildTextField(passwordController, "Password", Icons.lock, isPassword: true),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      bool success = await authController.login(usernameController.text, passwordController.text);
                      if (!success) {
                        Get.snackbar("Error", "Invalid username or password", snackPosition: SnackPosition.BOTTOM);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    ),
                    child: Text("Login", style: GoogleFonts.poppins(fontSize: 18)),
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed('/register'),
                    child: Text("Don't have an account? Register", style: GoogleFonts.poppins(color: Colors.blueAccent)),
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
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade200,
      ),
    );
  }
}




// // login_view.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../viewmodels/authcontroller.dart';
//
//
// class LoginView extends StatelessWidget {
//   final AuthController authController = Get.find();
//
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Login")),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(controller: usernameController, decoration: InputDecoration(labelText: "Username")),
//             TextField(controller: passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 bool success = await authController.login(usernameController.text, passwordController.text);
//                 if (!success) {
//                   Get.snackbar("Error", "Invalid username or password", snackPosition: SnackPosition.BOTTOM);
//                 }
//               },
//               child: Text("Login"),
//             ),
//             TextButton(
//               onPressed: () => Get.toNamed('/register'),
//               child: Text("Don't have an account? Register"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
