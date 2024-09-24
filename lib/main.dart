import 'package:authentication/models/cart.dart';
import 'package:authentication/pages/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Combined App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/', // Set the initial route
        routes: {
          '/': (context) => const SigninScreen(), // Sign-in screen
          '/home': (context) => const IntroPage(), // Main footwear hub
        },
      ),
    );
  }
}