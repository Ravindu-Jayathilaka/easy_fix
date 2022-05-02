import 'package:flutter/material.dart';
import 'package:mechanic_finder/models/mechanicReview.dart';
import 'package:mechanic_finder/models/vehicle.dart';
import 'package:mechanic_finder/services/mechanicService.dart';
import 'package:mechanic_finder/services/userService.dart';
import 'package:mechanic_finder/services/vehicleService.dart';
import 'package:mechanic_finder/shared/loading.dart';

import '../../../models/appUser.dart';
import '../../../models/mechanic.dart';
import '../../../services/auth.dart';

class RequestQuotation extends StatefulWidget {
  const RequestQuotation({Key? key}) : super(key: key);

  @override
  State<RequestQuotation> createState() => _RequestQuotationState();
}

class _RequestQuotationState extends State<RequestQuotation> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  double rating = 1;
  String review = '';
  String? vhlRegNo;
  String vhlBrand = '';
  String vhlModel = '';

  String error = '';
  late AppUser appUser;

  var brandController = TextEditingController();
  var modelController = TextEditingController();

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
              AppUserData? data = userSnapshot.data;
              List<String> dropDownValueList = [];
              List<Vehicle>? vehicleList = vehicleSnapshot.data as List<Vehicle>?;
              vehicleList?.forEach((element) {dropDownValueList.add(element.regNo);});
              return Scaffold(
                backgroundColor: const Color.fromRGBO(231, 248, 238, 1),
                appBar: AppBar(
                  title: Text('Quotation from ' + mechanic.name),
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
                                const SizedBox(height: 40.0),
                                InputDecorator(
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
                                            modelController.text = element.model;
                                            brandController.text = element.brand;
                                          }
                                        });
                                      },
                                      items: <String>[...?dropDownValueList]
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
                                const SizedBox(height: 40.0),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Vehicle Brand',
                                  ),
                                  readOnly: true,
                                  controller: brandController,
                                  validator: (val) =>
                                  val!.isEmpty
                                      ? 'Select the Vehicle'
                                      : null,
                                ),
                                const SizedBox(height: 40.0),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Vehicle Model',
                                  ),
                                  readOnly: true,
                                  controller: modelController,
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
                                    setState(() => review = val);
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Task Description',
                                  ),
                                  maxLines: 7,
                                  minLines: 5,
                                ),
                                const SizedBox(height: 30.0),
                                const Text(
                                    "Note : Price can be slightly different after the vehical inspection"),
                                const SizedBox(height: 30.0),
                                ElevatedButton(
                                  child: const Text('Add', style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      MechanicReview mechanicReview = MechanicReview(
                                          'null', rating.round(), review,
                                          appUser.uid, data?.name ?? '');
                                      bool success = await MechanicService()
                                          .addReview(mechanicReview, mechanic.id);
                                      if (success) {
                                        Navigator.pushNamed(
                                          context,
                                          '/home-mechanic',
                                          arguments: mechanic,
                                        );
                                      } else {
                                        setState(() {
                                          error = 'Adding the new review failed';
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