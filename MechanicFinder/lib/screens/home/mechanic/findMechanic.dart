import 'package:flutter/material.dart';
import 'package:mechanic_finder/shared/findMechanicMap.dart';
import '../../../shared/sideDrawer.dart';

class FindMechanic extends StatefulWidget {
  const FindMechanic({Key? key}) : super(key: key);

  @override
  State<FindMechanic> createState() => _FindMechanicState();
}

class _FindMechanicState extends State<FindMechanic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(231,248,238,1),
      appBar: AppBar(
        title: const Text('Find Mechanic'),
        backgroundColor: Colors.green[600],
        elevation: 0.0,
      ),
      drawer: const SideDrawer(),
      body: const FindMechanicMap(),
    );
  }
}