import 'package:flutter/material.dart';

class SearchMechanic extends StatefulWidget {
  const SearchMechanic({Key? key}) : super(key: key);

  @override
  State<SearchMechanic> createState() => _SearchMechanicState();
}

class _SearchMechanicState extends State<SearchMechanic> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Search Mechanic'),
          ),
          backgroundColor: Colors.teal,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Text('search bar'),
              Container(
                height: 350,
                color: Colors.teal,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 150,
                color: Colors.teal,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Name'),
                        Text(':'),
                        Text('Name from database'),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Location'),
                        Text(':'),
                        Text('Name from database'),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Rating'),
                        Text(':'),
                        Text('Name from database'),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                child: Text('Submit'),
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
