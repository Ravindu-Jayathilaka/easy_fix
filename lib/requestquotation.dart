import 'package:flutter/material.dart';

class RequestQuotation extends StatefulWidget {
  const RequestQuotation({Key? key}) : super(key: key);

  @override
  State<RequestQuotation> createState() => _RequestQuotationState();
}

class _RequestQuotationState extends State<RequestQuotation> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Center(child: Text('Request a quotation')),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: const [
                  Text('Mechanic'),
                  Text(':'),
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
                  Text('Vehicle'),
                  Text(':'),
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
                  Text('Tasks'),
                  Text(':'),
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
                  SizedBox(
                    width: 300,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Submit'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
