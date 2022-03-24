import 'package:flutter/material.dart';

class QuotationReply extends StatefulWidget {
  const QuotationReply({Key? key}) : super(key: key);

  @override
  State<QuotationReply> createState() => _QuotationReplyState();
}

class _QuotationReplyState extends State<QuotationReply> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Send Quotation'),
          ),
          backgroundColor: Colors.teal,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: const [
                  Text('Task 1 from db :'),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cost',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: const [
                  Text('Task 2 from db :'),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cost',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: const [
                  SizedBox(
                    width: 200,
                  ),
                  Text('Total :'),
                  Text('Total from db')
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 300,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Send'),
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
