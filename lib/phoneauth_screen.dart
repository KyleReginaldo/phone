// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:phone/otp_screen.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final number = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              key: formKey,
              decoration: const InputDecoration(
                hintText: 'enter phone number',
                prefix: Text(
                  '+63',
                ),
              ),
              controller: number,
              maxLength: 10,
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtpScreen(number: number.text),
                  ),
                );
              },
              child: const Text('hehe'),
            ),
          ],
        ),
      ),
    );
  }
}
