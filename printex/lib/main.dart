import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'splash_screen.dart';
import 'home_screen.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';
import 'auth_selector_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const Color baseColor = Color(0xFFF8C794);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Printex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: baseColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: baseColor,
          foregroundColor: Colors.black,
          elevation: 2,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: baseColor,
          secondary: baseColor,
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(color: baseColor),
      ),

      home: SplashScreen(),
      routes: {
        '/login': (_) => LoginScreen(),
        '/register': (_) => RegisterScreen(),
        '/home': (_) => HomeScreen(),
        '/auth_selector': (_) => AuthSelectorScreen(),
      },
    );
  }
}
