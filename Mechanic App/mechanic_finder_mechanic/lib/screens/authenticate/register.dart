import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../services/authService.dart';
import '../../shared/loading.dart';
import '../../shared/util.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  const Register({Key? key,required this.toggleView}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String shopName = '';
  String ownerName='';
  String email = '';
  String password = '';
  String error = '';

  static const LatLng showLocation = const LatLng(6.821700, 80.045803); //location to show in map
  late final GoogleMapController mapController;
  final Set<Marker> markers = Set();
  CameraPosition? cameraPosition;
  double longitude = showLocation.longitude;
  double latitude = showLocation.latitude;

  void _onMapCreator(GoogleMapController controller){
    setState(() {
      this.mapController = controller;
      controller.setMapStyle(Utils.mapStyle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: const Color.fromRGBO(231,248,238,1),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 100.0),
                    Row(
                      children: const [
                        Text("EASY",
                          style: TextStyle(
                            fontSize: 60,
                            color: Colors.green,
                            fontWeight: FontWeight.w800,
                          ),
                        ),Text(" FIX",
                          style: TextStyle(
                            fontSize: 60,
                            color: Colors.blue,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text('Mechanic',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight:FontWeight.w500
                        ),
                      )
                    ),
                    const SizedBox(height: 50.0),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? 'Enter the shop name': null,
                      onChanged: (val){
                        setState(()=> shopName = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Shop Name',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? 'Enter the owner name': null,
                      onChanged: (val){
                        setState(()=> ownerName = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Owner Name',
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    TextFormField(
                      validator: (val) => val!.isEmpty ? 'Enter an email': null,
                      onChanged: (val){
                        setState(()=> email = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    TextFormField(
                      obscureText: true,
                      validator: (val) => val!.length<6 ? 'Enter a password longer than 6 characters'
                          : null,
                      onChanged: (val){
                        setState(()=> password = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Shop Location', style: TextStyle(fontSize: 15),),
                    ),
                    const SizedBox(height: 10.0,),
                    SizedBox(
                      height: 350,
                      child: Stack(
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
                    ),
                    const SizedBox(height: 40.0),
                    ElevatedButton(
                      child: const Text('Register',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                      onPressed:() async {
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(shopName,ownerName,latitude,
                              longitude,email,password);
                          if(result == null){
                            setState(() => {
                              error = 'Please supply a valid email',
                              loading = false,
                            });
                          }
                        }
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.0),
                            side: const BorderSide(color: Colors.green),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(120,45)
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(76, 175, 79,1)),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red,fontSize: 14.0),
                    ),
                    Row(
                      children: <Widget>[
                        const Text("Already got an account ?",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            widget.toggleView();
                          },
                          child: const Text('Log in'),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,//Center Row contents horizontally,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
