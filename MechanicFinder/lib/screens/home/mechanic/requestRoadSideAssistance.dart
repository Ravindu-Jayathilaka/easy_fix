import 'package:flutter/material.dart';
import 'package:mechanic_finder/models/screenArgs/roadSideAssistantScreenArgs.dart';
import 'package:mechanic_finder/models/vehicle.dart';
import 'package:mechanic_finder/services/userService.dart';
import 'package:mechanic_finder/services/vehicleService.dart';
import 'package:mechanic_finder/shared/loading.dart';

import '../../../models/appUser.dart';
import '../../../models/mechanic.dart';
import '../../../models/mechanicRoadSideAssistance.dart';
import '../../../services/auth.dart';

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

  @override
  void initState() {
    super.initState();
    appUser = _auth.getCurrentUser()!;
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
                              ElevatedButton(
                                child: const Text('Next', style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    MechanicRoadSideAssistance assitance = MechanicRoadSideAssistance(
                                      '','created',problemDescription, DateTime.now(),0,0,appUser.uid, userData?.name ?? '',
                                      mechanic.id,mechanic.name,vhlRegNo!,vhlBrand,vhlModel
                                    );
                                    RoadSideAssistanceScreenArgs args = RoadSideAssistanceScreenArgs(mechanic,assitance);
                                    Navigator.pushNamed(
                                      context,
                                      '/assistance-location-select-mechanic',
                                      arguments: args,
                                    );
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