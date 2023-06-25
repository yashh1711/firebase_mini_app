import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_mini_app/utils/routes.dart';
import 'package:firebase_mini_app/utils/utils.dart';
import 'package:firebase_mini_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signUp() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      _auth
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((value) {
        Utils().toastCompleteMessage('User ID created sucessfully.');

        setState(() {
          loading = false;
        });
        Timer(const Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
        });
      }).onError((error, stackTrace) {
        setState(() {
          loading = false;
        });
        Utils().toastErrorMessage(error.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                    ),
                  ],
                )),
            SizedBox(
              height: height * 0.05,
            ),
            RoundedButton(
              title: 'Sign Up',
              loading: loading,
              onTap: () {
                signUp();
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
              },
              child: const Text('Already have an account? Login'),
            )
          ],
        ),
      ),
    );
  }
}
