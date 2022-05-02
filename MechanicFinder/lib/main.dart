import 'package:firebase_core/firebase_core.dart';
import 'package:mechanic_finder/services/auth.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_finder/screens/wrapper.dart';
import 'package:provider/provider.dart';

import 'models/appUser.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      initialData: null,
      catchError: (context,appUser) {
        return null;
      },
      value: AuthService().user,
      child: const Wrapper(),
    );
  }
}
