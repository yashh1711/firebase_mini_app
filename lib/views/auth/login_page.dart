import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_mini_app/utils/routes.dart';
import 'package:firebase_mini_app/utils/utils.dart';
import 'package:firebase_mini_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  bool loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
  }

  void login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      _auth
          .signInWithEmailAndPassword(
              email: _emailController.text.toString(),
              password: _passwordController.text.toString())
          .then((value) {
        Utils().toastCompleteMessage('User logged in  sucessfully.');

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
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
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
                        focusNode: emailNode,
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
                        focusNode: passwordNode,
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
                title: 'Login',
                loading: loading,
                onTap: () {
                  login();
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, MyRoutes.signUpRoute);
                },
                child: const Text('Don\'t have an account? Sign Up'),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.phoneLoginRoute);
                },
                tileColor: Colors.deepPurple,
                textColor: Colors.white,
                iconColor: Colors.white,
                leading: const Icon(Icons.phone),
                minLeadingWidth: 70,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: const Text('Login With Phone Number'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
