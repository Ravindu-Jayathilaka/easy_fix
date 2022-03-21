import 'package:flutter/material.dart';

class MyJobs extends StatefulWidget {
  const MyJobs({Key? key}) : super(key: key);

  @override
  State<MyJobs> createState() => _MyJobsState();
}

class _MyJobsState extends State<MyJobs> {
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
          title: Text('My Jobs'),
          backgroundColor: Colors.teal,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Card(
                child: InkWell(
                  splashColor: Colors.teal,
                  onTap: () {},
                  child:
                      const Text('Job name.use reg no. as name of this card'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
