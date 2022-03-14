import 'package:flutter/material.dart';

class VerificationCode extends StatefulWidget {
  const VerificationCode({Key? key}) : super(key: key);

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: const [
          Text('Enter the verification code sent you by Email'),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Verification Code',
            ),
          ),
          RaisedButton(
            onPressed: (null),
            child: Text('Submit'),
            color: Colors.teal,
          ),
        ],
      )),
    );
  }
}
