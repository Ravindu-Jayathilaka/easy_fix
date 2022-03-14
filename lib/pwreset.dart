import 'package:flutter/material.dart';

class PwReset extends StatefulWidget {
  const PwReset({Key? key}) : super(key: key);

  @override
  State<PwReset> createState() => _PwResetState();
}

class _PwResetState extends State<PwReset> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            Text('Enter the Email associated with your account'),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
            ),
            RaisedButton(
              onPressed: (null),
              child: Text('Submit'),
              color: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
