import 'package:flutter/material.dart';

class MyWorkshops extends StatefulWidget {
  const MyWorkshops({Key? key}) : super(key: key);

  @override
  State<MyWorkshops> createState() => _MyWorkshopsState();
}

class _MyWorkshopsState extends State<MyWorkshops> {
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
          title: const Center(
            child: Text('My Workshops'),
          ),
          backgroundColor: Colors.teal,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Card(
                child: InkWell(
                  splashColor: Colors.teal,
                  onTap: () {},
                  child: const Text('Workshop name'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
