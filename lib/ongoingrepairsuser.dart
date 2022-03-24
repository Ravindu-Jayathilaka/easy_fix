import 'package:flutter/material.dart';

class OngoingRepairsUser extends StatefulWidget {
  const OngoingRepairsUser({Key? key}) : super(key: key);

  @override
  State<OngoingRepairsUser> createState() => _OngoingRepairsUserState();
}

class _OngoingRepairsUserState extends State<OngoingRepairsUser> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Ongoing Repairs')),
          backgroundColor: Colors.teal,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [Text('Vehicle :'), Text('text from db')],
              ),
              Row(
                children: [Text('Start Date :'), Text('text from db')],
              ),
              Row(
                children: [Text('Estimated Time :'), Text('text from db')],
              ),
              Row(
                children: [Text('Task 1:'), Text('text from db')],
              ),
              Row(
                children: [Text('Task 2:'), Text('text from db')],
              ),
              Row(
                children: [Text('Task 3:'), Text('text from db')],
              ),
              Row(
                children: [Text('Completed Tasks :'), Text('text from db')],
              ),
              Row(
                children: [Text('Cost :'), Text('text from db')],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
