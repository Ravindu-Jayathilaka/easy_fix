import 'package:mechanic_finder/models/mechanic.dart';
import 'package:mechanic_finder/models/mechanicQuotation.dart';

class AppointmentScreenArgs {
  final Mechanic mechanic;
  final MechanicQuotation quotation;

  AppointmentScreenArgs(this.mechanic, this.quotation);
}