import 'package:flutter/material.dart';

class MechanicWelcome extends StatefulWidget {
  const MechanicWelcome({Key? key}) : super(key: key);

  @override
  State<MechanicWelcome> createState() => _MechanicWelcomeState();
}

class _MechanicWelcomeState extends State<MechanicWelcome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 150.0,
                color: Colors.teal,
                child: Row(
                  children: [
                    const SizedBox(width: 150),
                    Column(
                      children: const [
                        Icon(
                          Icons.person,
                          size: 120,
                        ),
                        Text('Welcome'),
                      ],
                    ),
                    Column(
                      children: const [
                        Icon(Icons.mail, size: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
