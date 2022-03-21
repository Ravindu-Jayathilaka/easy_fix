import 'package:flutter/material.dart';

class AddWorkshop extends StatefulWidget {
  const AddWorkshop({Key? key}) : super(key: key);

  @override
  State<AddWorkshop> createState() => _AddWorkshopState();
}

class _AddWorkshopState extends State<AddWorkshop> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Center(child: Text('Add Workshop')),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: const [
                  Text('Name :'),
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
                  Text('Location :'),
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
                  Text('Open Hours :'),
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
                  Text('Specialities :'),
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
                    child: const Text('Add'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
