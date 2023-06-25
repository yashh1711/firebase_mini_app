import 'package:firebase_mini_app/utils/routes.dart';
import 'package:firebase_mini_app/views/auth/login_page.dart';
import 'package:firebase_mini_app/views/auth/phone_login_page.dart';
import 'package:firebase_mini_app/views/auth/signup_page.dart';
import 'package:firebase_mini_app/views/posts_page.dart';
import 'package:firebase_mini_app/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        // useMaterial3: true,
      ),
      initialRoute: MyRoutes.splashRoute,
      routes: {
        MyRoutes.splashRoute: (context) => const SplashScreen(),
        MyRoutes.loginRoute: (context) => const LoginPage(),
        MyRoutes.signUpRoute: (context) => const SignUpPage(),
        MyRoutes.homeRoute: (context) => const PostsPage(),
        MyRoutes.phoneLoginRoute: (context) => const PhoneLoginScreen(),
      },
    );
  }
}
