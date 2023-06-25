import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_mini_app/utils/routes.dart';
import 'package:firebase_mini_app/utils/utils.dart';
import 'package:firebase_mini_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({super.key, required this.verificationId});
  final String verificationId;

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

final TextEditingController otpController = TextEditingController();
final auth = FirebaseAuth.instance;
bool loading = false;

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Enter 6 Digit OTP'),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            RoundedButton(
                title: 'Verify',
                loading: loading,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  final credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: otpController.text);

                  try {
                    await auth.signInWithCredential(credential).then((value) =>
                        Navigator.pushReplacementNamed(
                            context, MyRoutes.homeRoute));
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastErrorMessage(e.toString());
                  }
                })
          ],
        ),
      ),
    );
  }
}
