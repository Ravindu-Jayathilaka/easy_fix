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
              Container(
                child: Text('Request Emergency Assistance'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.teal,
                ),
              ),
              Container(
                child: Text('Request A Quotation'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.teal,
                ),
              ),
              Container(
                child: Text('Arrange Maintenance'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.teal,
                ),
              ),
              Container(
                child: Text('Feedback'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.teal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


MaterialApp(
home: Scaffold(
appBar: AppBar(
title: Text('Ongoing Repairs'),
backgroundColor: Colors.teal,
),
body: SafeArea(
child: Column(
children: [
Row(
children: [
Text('Vehicle :'),
Text('dropdown'),
],
),
Row(
children: const [
Text('Start Date :'),
Expanded(
child: TextField(
decoration: InputDecoration(
border: OutlineInputBorder(),
),
),
),
],
),
Row(
children: const [
Text('Estimated Time :'),
Expanded(
child: TextField(
decoration: InputDecoration(
border: OutlineInputBorder(),
),
),
),
],
),
Row(
children: const [
Text('Tasks :'),
Expanded(
child: TextField(
decoration: InputDecoration(
border: OutlineInputBorder(),
),
),
),
],
),
Row(
children: const [
Text('Completed Tasks :'),
Expanded(
child: TextField(
decoration: InputDecoration(
border: OutlineInputBorder(),
),
),
),
],
),
Row(
children: const [
Text('Cost :'),
Expanded(
child: TextField(
decoration: InputDecoration(
border: OutlineInputBorder(),
),
),
),
],
),
Row(
children: [
const SizedBox(
width: 300,
),
ElevatedButton(
onPressed: () {},
child: const Text('Submit'),
)
],
)
],
),
),
),
);