import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  final String number;
  const OtpScreen({
    Key? key,
    required this.number,
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final pinController = TextEditingController();
  String verificationId = '';
  Future<void> verify(String number) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+63${widget.number}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        print('complete');
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);

        // Handle other errors
      },
      codeSent: (String verificationId, int? resendToken) async {
        print('code sent');
        print('verificationId');

        setState(() {
          this.verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print(verificationId);
        print('timeout');
      },
      timeout: const Duration(seconds: 60),
    );
  }

  @override
  void initState() {
    verify(widget.number);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PinCodeTextField(
              appContext: context,
              length: 6,
              onChanged: (value) {},
              animationType: AnimationType.slide,
              controller: pinController,
            ),
            ElevatedButton(
              onPressed: () async {
                print('$verificationId ${widget.number}');
                await FirebaseAuth.instance
                    .signInWithCredential(
                  PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: pinController.text,
                  ),
                )
                    .then(
                  (value) {
                    print('Success Login');
                    Navigator.pop(context);
                  },
                );
              },
              child: const Text('verify'),
            ),
          ],
        ),
      ),
    );
  }
}
