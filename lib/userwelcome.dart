import 'package:flutter/material.dart';

class UserWelcome extends StatefulWidget {
  const UserWelcome({Key? key}) : super(key: key);

  @override
  State<UserWelcome> createState() => _UserWelcomeState();
}

class _UserWelcomeState extends State<UserWelcome> {
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
              Column(
                children: const [
                  Text('My Vehicles'),
                  Text('Search Mechanics'),
                  Text('Make an Appointment'),
                  Text('Request Quotation'),
                  Text('Arrange Maintenance'),
                  Text('Ongoing Repairs'),
                  Text('Payments'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
