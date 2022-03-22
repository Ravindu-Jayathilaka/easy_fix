import 'package:flutter/material.dart';

class MechanicAlerts extends StatefulWidget {
  const MechanicAlerts({Key? key}) : super(key: key);

  @override
  State<MechanicAlerts> createState() => _MechanicAlertsState();
}

class _MechanicAlertsState extends State<MechanicAlerts> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Alerts'),
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
                  child: const Text('Appointments'),
                ),
              ),
              Card(
                child: InkWell(
                  splashColor: Colors.teal,
                  onTap: () {},
                  child: const Text('Quotation Requests'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
