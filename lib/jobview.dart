import 'package:flutter/material.dart';

class JobView extends StatefulWidget {
  const JobView({Key? key}) : super(key: key);

  @override
  State<JobView> createState() => _JobViewState();
}

class _JobViewState extends State<JobView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: const Text('Job Name from db')),
          backgroundColor: Colors.teal,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: const [
                  Text('Vehicle :'),
                  Text('text from db'),
                ],
              ),
              Row(
                children: const [
                  Text('Registration No. :'),
                  Text('text from db'),
                ],
              ),
              Row(
                children: const [
                  Text('Start Date :'),
                  Text('text from db'),
                ],
              ),
              Row(
                children: const [
                  Text('Estimated Completion :'),
                  Text('text from db'),
                ],
              ),
              Row(
                children: const [
                  Text('Tasks :'),
                  Text('text from db'),
                ],
              ),
              Row(
                children: const [
                  Text('Completed Tasks :'),
                  Text('text from db'),
                ],
              ),
              Row(
                children: const [
                  Text('Cost :'),
                  Text('text from db'),
                ],
              ),
              Row(
                children: const [
                  Text('Payment Done :'),
                  Text('add a tick button')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
