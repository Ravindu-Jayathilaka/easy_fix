import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appUser.dart';
import 'authenticate/authenticate.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser?>(context);
    if(user != null ){
      return MaterialApp(
          routes: {
            '/find-mechanic': (context) => const Home(),
          },
          home: const Home(),
      );
    } else {
      return const MaterialApp(
          home: Authenticate()
      );
    }
  }
}
