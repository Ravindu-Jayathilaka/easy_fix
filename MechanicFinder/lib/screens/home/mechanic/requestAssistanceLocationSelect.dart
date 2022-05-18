import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mechanic_finder/services/roadSideAssistanceService.dart';
import 'package:mechanic_finder/services/userService.dart';

import '../../../models/appUser.dart';
import '../../../models/mechanic.dart';
import '../../../models/mechanicRoadSideAssistance.dart';
import '../../../models/screenArgs/roadSideAssistantScreenArgs.dart';
import '../../../services/auth.dart';
import '../../../shared/util.dart';

class RequestAssistanceLocationSelect extends StatefulWidget {
  const RequestAssistanceLocationSelect({Key? key}) : super(key: key);

  @override
  State<RequestAssistanceLocationSelect> createState() => _RequestAssistanceLocationSelectState();
}

class _RequestAssistanceLocationSelectState extends State<RequestAssistanceLocationSelect> {

  final AuthService _auth = AuthService();

  String error = '';
  late AppUser appUser;

  var vehicleController = TextEditingController();
  static const LatLng showLocation = const LatLng(6.821700, 80.045803); //location to show in map
  late final GoogleMapController mapController;
  final Set<Marker> markers = Set();
  CameraPosition? cameraPosition;
  double longitude = showLocation.longitude;
  double latitude = showLocation.latitude;

  @override
  void initState() {
    super.initState();
    appUser = _auth.getCurrentUser()!;
  }

  void _onMapCreator(GoogleMapController controller){
    setState(() {
      mapController = controller;
      controller.setMapStyle(Utils.mapStyle);
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
      .of(context)!
      .settings
      .arguments as RoadSideAssistanceScreenArgs;
    Mechanic mechanic = args.mechanic;
    MechanicRoadSideAssistance assistance = args.assistance;
    return StreamBuilder<AppUserData>(
      stream: UserService(uid: appUser.uid).user,
      builder: (context, userSnapshot) {
        return Scaffold(
          backgroundColor: const Color.fromRGBO(231, 248, 238, 1),
          appBar: AppBar(
            title: const Text('Select the location'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_outlined),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/home-mechanic',
                  arguments: mechanic,
                );
              },
            ),
            backgroundColor: Colors.green[600],
            elevation: 0.0,
          ),
          body:Stack(
            children: [
              GoogleMap(
                zoomGesturesEnabled: true,
                mapType: MapType.normal,
                markers: markers,
                initialCameraPosition: const CameraPosition(
                  target: showLocation,
                  zoom: 14,
                ),
                onMapCreated:_onMapCreator,
                onCameraMove: (CameraPosition cameraPositiona) {
                  setState(() {
                    cameraPosition = cameraPositiona;
                  });
                },
                onCameraIdle: () async {
                  setState(() {
                    longitude = cameraPosition!.target.longitude;
                    latitude = cameraPosition!.target.latitude;
                  });
                },
              ),
              Center( //picker image on google map
                child: Image.asset('images/picker.png', width: 30,),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              assistance.longitude = longitude;
              assistance.latitude = latitude;
              bool success = await RoadSideAssistanceService()
                  .addRoadSideAssistance(assistance);
              if (success) {
                Navigator.pushNamed(
                  context,
                  '/',
                  arguments: mechanic,
                );
              } else {
                setState(() {
                  error = 'Adding the new assistance request failed';
                });
              }
            },
            child: const Text("DONE"),
            backgroundColor: Colors.green,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        );
      }
    );
  }
}