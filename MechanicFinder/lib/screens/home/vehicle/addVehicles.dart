import 'package:flutter/material.dart';
import 'package:mechanic_finder/models/vehicle.dart';
import 'package:mechanic_finder/services/vehicleService.dart';

import '../../../models/appUser.dart';
import '../../../services/auth.dart';
import '../../../shared/sideDrawer.dart';

class AddVehicles extends StatefulWidget {
  const AddVehicles({Key? key}) : super(key: key);

  @override
  State<AddVehicles> createState() => _AddVehiclesState();
}

class _AddVehiclesState extends State<AddVehicles> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String brand = '';
  String model = '';
  String regNo = '';
  String color = '';
  String transmission = '';
  String fuleType = '';
  String mileage = '';

  String error = '';
  late AppUser appUser;

  @override
  void initState() {
    super.initState();
    appUser = _auth.getCurrentUser()!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(231,248,238,1),
      appBar: AppBar(
        title: const Text('Add New Vehicle'),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/vehicles");
            }),
        backgroundColor: Colors.green[600],
        elevation: 0.0,
      ),
      drawer: const SideDrawer(),
      body:SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 25.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? 'Enter the brand': null,
                      onChanged: (val){
                        setState(()=> brand = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Brand',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? 'Enter the model': null,
                      onChanged: (val){
                        setState(()=> model = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Model',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? 'Enter the reg. no': null,
                      onChanged: (val){
                        setState(()=> regNo = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Reg No',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? 'Enter the Color': null,
                      onChanged: (val){
                        setState(()=> color = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Color',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? 'Enter the transmission': null,
                      onChanged: (val){
                        setState(()=> transmission = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Transmission',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? 'Enter the fule type': null,
                      onChanged: (val){
                        setState(()=> fuleType = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Fule Type',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? 'Enter the Mileage': null,
                      onChanged: (val){
                        setState(()=> mileage = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Mileage',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(error,style: const TextStyle(color: Colors.red,fontSize: 14.0),),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      child: const Text('Add',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                      onPressed:() async {
                        if(_formKey.currentState!.validate()){
                          Vehicle vehicle = Vehicle('null',brand,model,regNo,color,transmission,fuleType,int.parse(mileage));
                          bool success = await VehicleService(uid: appUser.uid).updateVehicle(vehicle);
                          if(success){
                            Navigator.pushNamed(context, '/vehicles');
                          } else {
                            setState(() {
                              error = 'Adding the new vehicle failed';
                            });
                          }
                        }
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.0),
                            side: const BorderSide(color: Color.fromRGBO(46, 185, 160,1)),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(120,45)
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(46, 185, 160,1)),
                      ),
                    ),
                  ],
                )
              ),
            )
          ],
        ),
      ) ,
    );
  }
}
