import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mechanic_finder_mechanic/models/appUser.dart';

import '../../services/authService.dart';
import '../../shared/loading.dart';
import '../../shared/util.dart';

class RegisterSelectLocation extends StatefulWidget {

  const RegisterSelectLocation({Key? key}) : super(key: key);

  @override
  State<RegisterSelectLocation> createState() => _RegisterSelectLocationState();
}

class _RegisterSelectLocationState extends State<RegisterSelectLocation> {

  final AuthService _auth = AuthService();
  bool loading = false;

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

    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as AppUserData;

    return loading ? const Loading() : Scaffold(
      backgroundColor: const Color.fromRGBO(231,248,238,1),
      appBar: AppBar(
        title: const Text('Select the shop location'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/register',
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
          dynamic result = await _auth
              .registerWithEmailAndPassword(args.name,args.owner,latitude,
              longitude,args.email,args.password);
          if(result != null) {
            Navigator.pushNamed(context, '/',);
          }
        },
        child: const Text("DONE"),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
