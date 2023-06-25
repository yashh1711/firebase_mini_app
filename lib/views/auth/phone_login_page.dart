import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_mini_app/utils/utils.dart';
import 'package:firebase_mini_app/views/auth/verify_phone_page.dart';
import 'package:firebase_mini_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

final TextEditingController phoneNumberController = TextEditingController();
final auth = FirebaseAuth.instance;
bool loading = false;

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login With Phone '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Enter Phone Number'),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            RoundedButton(
              title: 'Login',
              loading: loading,
              onTap: () {
                setState(() {
                  loading = true;
                });
                auth.verifyPhoneNumber(
                  phoneNumber: phoneNumberController.text,
                  verificationCompleted: (phoneAuthCredential) {
                    setState(() {
                      loading = false;
                    });
                  },
                  verificationFailed: (error) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastErrorMessage(error.toString());
                  },
                  codeSent: (verificationId, forceResendingToken) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VerifyPhoneScreen(verificationId: verificationId),
                        ));
                    setState(() {
                      loading = false;
                    });
                  },
                  codeAutoRetrievalTimeout: (verificationId) {
                    Utils().toastErrorMessage(verificationId.toString());
                    setState(() {
                      loading = false;
                    });
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
