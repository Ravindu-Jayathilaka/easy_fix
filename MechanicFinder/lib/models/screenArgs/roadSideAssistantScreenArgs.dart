import 'package:mechanic_finder/models/mechanic.dart';
import 'package:mechanic_finder/models/mechanicRoadSideAssistance.dart';

class RoadSideAssistanceScreenArgs {
  final Mechanic mechanic;
  final MechanicRoadSideAssistance assistance;

  RoadSideAssistanceScreenArgs(this.mechanic, this.assistance);
}