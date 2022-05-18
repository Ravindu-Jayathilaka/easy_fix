import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mechanic_finder/models/vehicle.dart';
import 'package:mechanic_finder/services/roadSideAssistanceService.dart';
import 'package:mechanic_finder/services/userService.dart';
import 'package:mechanic_finder/services/vehicleService.dart';
import 'package:mechanic_finder/shared/loading.dart';

import '../../../models/appUser.dart';
import '../../../models/mechanic.dart';
import '../../../models/mechanicRoadSideAssistance.dart';
import '../../../services/auth.dart';
import '../../../shared/util.dart';

class RequestRoadSideAssistance extends StatefulWidget {
  const RequestRoadSideAssistance({Key? key}) : super(key: key);

  @override
  State<RequestRoadSideAssistance> createState() => _RequestRoadSideAssistanceState();
}

class _RequestRoadSideAssistanceState extends State<RequestRoadSideAssistance> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String problemDescription = '';
  String? vhlRegNo;
  String vhlBrand = '';
  String vhlModel = '';


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
      this.mapController = controller;
      controller.setMapStyle(Utils.mapStyle);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mechanic = ModalRoute
      .of(context)!
      .settings
      .arguments as Mechanic;
    return StreamBuilder<AppUserData>(
      stream: UserService(uid: appUser.uid).user,
      builder: (context, userSnapshot) {
        return StreamBuilder(
          stream: VehicleService(uid: appUser.uid).vehicles,
          builder: (context, vehicleSnapshot) {
            if (vehicleSnapshot.data != null) {
              AppUserData? userData = userSnapshot.data;
              List<String> dropDownValueList = [];
              List<Vehicle>? vehicleList = vehicleSnapshot.data as List<Vehicle>?;
              vehicleList?.forEach((element) {dropDownValueList.add(element.regNo);});
              return Scaffold(
                backgroundColor: const Color.fromRGBO(231, 248, 238, 1),
                appBar: AppBar(
                  title: Text('Assistance from ' + mechanic.name),
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
                body: SingleChildScrollView(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 25.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 10.0),
                              SizedBox(
                                height: 60,
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: vhlRegNo,
                                      hint: const Text('Select the Vehicle'),
                                      icon: const Icon(Icons.arrow_downward),
                                      elevation: 16,
                                      style: const TextStyle(color: Colors.black),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          vhlRegNo = newValue!;
                                        });
                                        vehicleList?.forEach((element) {
                                          if(element.regNo == newValue){
                                            vehicleController.text = element.brand+' '+element.model;
                                            setState(() {
                                              vhlBrand = element.brand;
                                              vhlModel = element.model;
                                            });
                                          }
                                        });
                                      },
                                      items: <String>[...dropDownValueList]
                                          .map<DropdownMenuItem<String>>((
                                          String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40.0),
                              TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Vehicle model',
                                ),
                                readOnly: true,
                                controller: vehicleController,
                                validator: (val) =>
                                val!.isEmpty
                                    ? 'Select the Vehicle'
                                    : null,
                              ),
                              const SizedBox(height: 40.0),
                              TextFormField(
                                validator: (val) =>
                                val!.isEmpty
                                    ? 'Enter the description'
                                    : null,
                                onChanged: (val) {
                                  setState(() => problemDescription = val);
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Task Description',
                                ),
                                maxLines: 4,
                                minLines: 3,
                              ),
                              const SizedBox(height: 30.0),
                              SizedBox(
                                height: 350,
                                child: Stack(
                                  children: [
                                    GoogleMap(
                                      zoomGesturesEnabled: true,
                                      mapType: MapType.normal,
                                      markers: markers,
                                      initialCameraPosition: CameraPosition(
                                        target: showLocation,
                                        zoom: 14,
                                      ),
                                      onMapCreated:_onMapCreator,
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
                              ),

                              const SizedBox(height: 30.0),
                              ElevatedButton(
                                child: const Text('Create', style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    MechanicRoadSideAssistance assitance = MechanicRoadSideAssistance(
                                      '','created',problemDescription, DateTime.now(),longitude,latitude,appUser.uid, userData?.name ?? '',
                                      mechanic.id,mechanic.name,vhlRegNo!,vhlBrand,vhlModel
                                    );
                                    bool success = await RoadSideAssistanceService()
                                        .addRoadSideAssistance(assitance);
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
                                  }
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28.0),
                                      side: const BorderSide(
                                        color: Color.fromRGBO(
                                            46, 185, 160, 1)),
                                    ),
                                  ),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                    const Size(120, 45)
                                  ),
                                  backgroundColor: MaterialStateProperty.all<
                                    Color>(
                                    const Color.fromRGBO(46, 185, 160, 1)),
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            else {
              return const Loading();
            }
          }
        );
      }
    );
  }
}