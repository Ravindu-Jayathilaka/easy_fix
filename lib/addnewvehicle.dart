import 'package:flutter/material.dart';

class AddNewVehicle extends StatefulWidget {
  const AddNewVehicle({Key? key}) : super(key: key);

  @override
  State<AddNewVehicle> createState() => _AddNewVehicleState();
}

class _AddNewVehicleState extends State<AddNewVehicle> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: (const Text('Add New Vehicle')),
          backgroundColor: Colors.teal,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: const [
                  Text('Brand'),
                  Text(':'),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  )
                ],
              ),
              Row(
                children: const [
                  Text('Model'),
                  Text(':'),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  )
                ],
              ),
              Row(
                children: const [
                  Text('Reg. No.'),
                  Text(':'),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  )
                ],
              ),
              Row(
                children: const [
                  Text('Color'),
                  Text(':'),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  )
                ],
              ),
              Row(
                children: const [
                  Text('Transmission'),
                  Text(':'),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  )
                ],
              ),
              Row(
                children: const [
                  Text('Fuel'),
                  Text(':'),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Text('Photo'),
                  const Text(':'),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Upload'),
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
