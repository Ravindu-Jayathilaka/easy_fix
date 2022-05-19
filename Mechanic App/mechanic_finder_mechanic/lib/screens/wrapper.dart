import 'package:flutter/material.dart';
import 'package:mechanic_finder_mechanic/screens/roadSideAssistance/roadAssistanceTasks.dart';
import 'package:mechanic_finder_mechanic/screens/roadSideAssistance/viewRoadSideAssistance.dart';
import 'package:mechanic_finder_mechanic/screens/task/appointment.dart';
import 'package:mechanic_finder_mechanic/screens/task/ongoingTasks.dart';
import 'package:mechanic_finder_mechanic/screens/task/tasks.dart';
import 'package:mechanic_finder_mechanic/screens/task/viewTask.dart';
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
            '/view-road-side-assistance': (context) => const ViewRoadSideAssistance(),
            '/road-side-assistance-tasks': (context) => const RoadAssistanceTasks(),
            '/tasks': (context) => const Tasks(),
            '/ongoing-tasks': (context) => const OngoingTasks(),
            '/appointments': (context) => const Appointments(),
            '/view-tasks': (context) => const ViewTask(),
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
