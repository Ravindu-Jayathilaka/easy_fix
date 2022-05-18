import 'package:flutter/material.dart';
import 'package:mechanic_finder/models/appUser.dart';
import 'package:mechanic_finder/screens/authenticate/authenticate.dart';
import 'package:mechanic_finder/screens/home/mechanic/addReview.dart';
import 'package:mechanic_finder/screens/home/mechanic/mechanicHome.dart';
import 'package:mechanic_finder/screens/home/mechanic/requestAppointment.dart';
import 'package:mechanic_finder/screens/home/mechanic/requestRoadSideAssistance.dart';
import 'package:mechanic_finder/screens/home/quotation/quotations.dart';
import 'package:mechanic_finder/screens/home/quotation/viewQuotation.dart';
import 'package:mechanic_finder/screens/home/roadSideAssistance/roadAssistanceTasks.dart';
import 'package:mechanic_finder/screens/home/roadSideAssistance/viewRoadSideAssistance.dart';
import 'package:mechanic_finder/screens/home/task/tasks.dart';
import 'package:mechanic_finder/screens/home/task/viewTask.dart';
import 'package:mechanic_finder/screens/home/vehicle/addVehicles.dart';
import 'package:mechanic_finder/screens/home/vehicle/vehicles.dart';
import 'package:provider/provider.dart';
import '../models/appUser.dart';
import 'home/home.dart';
import 'home/mechanic/findMechanic.dart';
import 'home/mechanic/requestQuotation.dart';
import 'home/vehicle/viewVehicles.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser?>(context);
    if(user != null ){
      return MaterialApp(
          routes: {
            '/find-mechanic': (context) => const FindMechanic(),
            '/home-mechanic': (context) => const MechanicHome(),
            '/review-mechanic': (context) => const AddReviews(),
            '/quotation-mechanic': (context) => const RequestQuotation(),
            '/appointment-mechanic': (context) => const RequestAppointment(),
            '/road-side-assistance-mechanic':
                (context) => const RequestRoadSideAssistance(),
            '/vehicles': (context) => const Vehicles(),
            '/add-vehicles': (context) => const AddVehicles(),
            '/view-vehicles': (context) => const ViewVehicles(),
            '/quotations': (context) => const Quotations(),
            '/view-quotation': (context) => const ViewQuotation(),
            '/tasks': (context) => const Tasks(),
            '/view-tasks': (context) => const ViewTask(),
            '/view-road-side-assistance': (context) => const ViewRoadSideAssistance(),
            '/road-side-assistance-tasks': (context) => const RoadAssistanceTasks(),
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
