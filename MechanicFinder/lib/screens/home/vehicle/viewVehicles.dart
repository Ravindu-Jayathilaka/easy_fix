import 'package:flutter/material.dart';
import 'package:mechanic_finder/models/vehicle.dart';
import '../../../models/appUser.dart';
import '../../../services/auth.dart';
import '../../../shared/sideDrawer.dart';

class ViewVehicles extends StatefulWidget {
  const ViewVehicles({Key? key}) : super(key: key);

  @override
  State<ViewVehicles> createState() => _ViewVehiclesState();
}

class _ViewVehiclesState extends State<ViewVehicles> {

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
    final vehicle = ModalRoute.of(context)!.settings.arguments as Vehicle;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(231,248,238,1),
      appBar: AppBar(
        title: Text(vehicle.regNo),
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
                      initialValue:vehicle.brand ,
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
                      initialValue:vehicle.model,
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
                      initialValue:vehicle.regNo,
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
                      initialValue:vehicle.color,
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
                      initialValue:vehicle.transmission,
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
                      initialValue:vehicle.fuleType,
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
                      initialValue:vehicle.mileage.toString(),
                    ),
                    const SizedBox(height: 20.0),
                    Text(error,style: const TextStyle(color: Colors.red,fontSize: 14.0),),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      child: const Text('Update',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                      onPressed:() async {
                        if(_formKey.currentState!.validate()){
                          Vehicle updateVehicle = Vehicle(vehicle.id,brand,model,regNo,color,transmission,fuleType,int.parse(mileage));
                          //todo: update method fix
                          bool success = true;
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
