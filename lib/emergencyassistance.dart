import 'package:flutter/material.dart';

class EmergencyAssistance extends StatefulWidget {
  const EmergencyAssistance({Key? key}) : super(key: key);

  @override
  State<EmergencyAssistance> createState() => _EmergencyAssistanceState();
}

class _EmergencyAssistanceState extends State<EmergencyAssistance> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Roadside Emergency Assistance')),
          backgroundColor: Colors.teal,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 400.0,
                color: Colors.teal,
              ),
              Text('Drag and drop the pin to mark your location'),
              Row(
                children: [Text('Vehicle type'), Text(':'), Text('dropdown')],
              ),
              Row(
                children: const [
                  Text('Emergency'),
                  Text(':'),
                  /*TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  )*/
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 300),
                  Container(
                    child: Text('Submit'),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.teal,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
