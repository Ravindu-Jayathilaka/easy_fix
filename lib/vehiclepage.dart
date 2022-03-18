import 'package:flutter/material.dart';

class VehiclePage extends StatefulWidget {
  const VehiclePage({Key? key}) : super(key: key);

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Toyota Corolla')),
          backgroundColor: Colors.teal,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                child: const Image(
                  image: NetworkImage(
                      'https://cdcssl.ibsrv.net/cimg/www.carsdirect.com/580x337_85/310/2021-Toyota-Corolla-Apex_008-601310.jpg'),
                ),
                height: 200.0,
                color: Colors.teal,
              ),
              Row(
                children: const [Text('Brand'), Text(':'), Text('Toyota')],
              ),
              Row(
                children: const [Text('Model'), Text(':'), Text('Corolla')],
              ),
              Row(
                children: const [Text('Reg. No.'), Text(':'), Text('KP-3380')],
              ),
              Row(
                children: const [Text('Color'), Text(':'), Text('White')],
              ),
              Row(
                children: const [
                  Text('Transmission'),
                  Text(':'),
                  Text('Automatic')
                ],
              ),
              Row(
                children: const [Text('Fuel'), Text(':'), Text('Petrol')],
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.teal,
                    ),
                    child: const Icon(Icons.engineering),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.teal,
                    ),
                    child: const Icon(Icons.build),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.teal,
                    ),
                    child: const Icon(Icons.assignment),
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
