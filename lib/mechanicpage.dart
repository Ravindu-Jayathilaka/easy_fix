import 'package:flutter/material.dart';

class MechanicPage extends StatefulWidget {
  const MechanicPage({Key? key}) : super(key: key);

  @override
  State<MechanicPage> createState() => _MechanicPageState();
}

class _MechanicPageState extends State<MechanicPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Center(
            child: Text('Mechanic\'s Details'),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.teal,
                height: 100,
                child: Row(
                  children: [
                    Icon(Icons.person),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text('Name'),
                            Text(':'),
                            Text('Name from db'),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Location'),
                            Text(':'),
                            Text('Name from db'),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Rating'),
                            Text(':'),
                            Text('star rate bar'),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Specialities'),
                            Text(':'),
                            Text('from db'),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                child: InkWell(
                  splashColor: Colors.teal,
                  onTap: () {},
                  child: const Text('Request Roadside Assistance'),
                ),
              ),
              Card(
                child: InkWell(
                  splashColor: Colors.teal,
                  onTap: () {},
                  child: const Text('Request a Quotation'),
                ),
              ),
              Card(
                child: InkWell(
                  splashColor: Colors.teal,
                  onTap: () {},
                  child: const Text('Arrange Maintenance'),
                ),
              ),
              Card(
                child: InkWell(
                  splashColor: Colors.teal,
                  onTap: () {},
                  child: const Text('My Appointments'),
                ),
              ),
              Card(
                child: InkWell(
                  splashColor: Colors.teal,
                  onTap: () {},
                  child: const Text('Feedback'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
