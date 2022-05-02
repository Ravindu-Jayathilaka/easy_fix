import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final String details;
  final MaterialColor color;
  const AppCard({Key? key,required this.details,required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10,20,10,0),
      elevation: 4,
      shadowColor: Colors.green,
      shape: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 1),
          borderRadius: BorderRadius.circular(6)
      ),
      child: ListTileTheme(
        contentPadding: const EdgeInsets.fromLTRB(10,0,10,0),
        tileColor: color,
        iconColor: Colors.white,
        textColor: Colors.white,
        style: ListTileStyle.list,
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1),
            borderRadius: BorderRadius.circular(6)
        ),
        child: ListTile(
          title: Text(details, style: const TextStyle(fontSize: 20),),
        ),
      ),
    );
  }
}
