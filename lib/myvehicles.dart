import 'package:flutter/material.dart';

class MyVehicles extends StatefulWidget {
  const MyVehicles({Key? key}) : super(key: key);

  @override
  State<MyVehicles> createState() => _MyVehiclesState();
}

class _MyVehiclesState extends State<MyVehicles> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.teal,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Center(child: Text('My Vehicles')),
          backgroundColor: Colors.teal,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Card(
                child: InkWell(
                  splashColor: Colors.teal,
                  onTap: () {},
                  child: const Text('Toyota Corolla'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
