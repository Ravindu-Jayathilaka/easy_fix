import 'package:flutter/material.dart';

class PwReset extends StatefulWidget {
  const PwReset({Key? key}) : super(key: key);

  @override
  State<PwReset> createState() => _PwResetState();
}

class _PwResetState extends State<PwReset> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Text('Enter the Email associated with your account'),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Submit'),
                style: const ButtonStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
