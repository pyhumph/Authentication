import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:authentication/screens/Resert_Password.dart';
import 'package:authentication/screens/home_screen.dart';
import 'signup_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  // Controllers for capturing email and password input
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Main container for the sign-in screen
      body: Container(
        // Full-screen width and height
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // Background gradient from dark blue to light blue
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade900, Colors.lightBlueAccent],
          ),
        ),
        // Scrollable content for better UI
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.08, 20, 0),
            child: Column(
              children: [
                // Shop logo at the top
                Image.asset(
                  "../assets/images/logo1.png",
                  fit: BoxFit.fitWidth,
                  width: 340,
                  height: 340,
                ),
                // Email input field
                TextField(
                  controller: _emailTextController,
                  obscureText: false, // Not obscured for email
                  enableSuggestions: true,
                  autocorrect: false,
                  cursorColor: Colors.yellow,
                  style: TextStyle(color: Colors.blue.shade900),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person_2_outlined,
                      color: Colors.yellow,
                    ),
                    labelText: "Enter your Email",
                    labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.yellow.withOpacity(0.3),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 20,
                ),
                // Password input field
                TextField(
                  controller: _passwordTextController,
                  obscureText: true, // Password is obscured
                  enableSuggestions: false,
                  autocorrect: false,
                  cursorColor: Colors.yellow,
                  style: TextStyle(color: Colors.blue.shade900),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock_outline_rounded,
                      color: Colors.yellow,
                    ),
                    labelText: "Enter your Password",
                    labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.yellow.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 20,
                ),
                // SignIn button
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(90)),
                  child: ElevatedButton(
                    onPressed: () {
                      // Firebase authentication on button press
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                          .then(
                        (value) {
                          // If successful, navigate to HomePage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        },
                      ).onError(
                        (error, stackTrace) {
                          // Print error for debugging (remove in production)
                          print(error);
                          // Error handling for invalid email format
                          if (error.toString() ==
                              "[firebase_auth/invalid-email] The email address is badly formatted.") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.yellowAccent,
                                dismissDirection: DismissDirection.up,
                                duration: const Duration(seconds: 7),
                                content: const Text(
                                  "       📛Wrong Email format📛",
                                  style: TextStyle(
                                      backgroundColor: Colors.yellowAccent,
                                      color: Colors.red,
                                      fontSize: 30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                            );
                          }
                          // Error handling for incorrect credentials
                          else if (error.toString() ==
                              "[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.yellowAccent,
                                dismissDirection: DismissDirection.up,
                                duration: const Duration(seconds: 7),
                                content: const Text(
                                  "       📛Wrong Email or Password📛",
                                  style: TextStyle(
                                      backgroundColor: Colors.yellowAccent,
                                      color: Colors.red,
                                      fontSize: 30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                            );
                          }
                        },
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.blue;
                          }
                          return Colors.yellow;
                        }),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
                    child: const Text(
                      "SignIn",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
                // Sign Up / Forgot Password row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?",
                        style: TextStyle(color: Colors.white70)),
                    GestureDetector(
                      onTap: () {
                        // Navigate to SignUpScreen
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      child: const Text(
                        " Sign Up",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 9,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to ResetPasswordScreen
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ResetPasswordScreen()));
                      },
                      child: const Text(
                        " Forget Password",
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
