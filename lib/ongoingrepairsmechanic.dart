import 'package:flutter/material.dart';

class OngoingRepairsMechanic extends StatefulWidget {
  const OngoingRepairsMechanic({Key? key}) : super(key: key);

  @override
  State<OngoingRepairsMechanic> createState() => _OngoingRepairsMechanicState();
}

class _OngoingRepairsMechanicState extends State<OngoingRepairsMechanic> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  }
}
