import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mechanic_finder/models/mechanic.dart';
import 'package:mechanic_finder/services/mechanicService.dart';
import 'package:mechanic_finder/shared/loading.dart';

import '../../../shared/util.dart';

class FindMechanicMap extends StatefulWidget {
  const FindMechanicMap({Key? key}) : super(key: key);

  @override
  State<FindMechanicMap> createState() => _FindMechanicMapState();
}

class _FindMechanicMapState extends State<FindMechanicMap> {
  MechanicService _mechanicService = MechanicService();
  final Set<Marker> markers = Set();
  static const LatLng showLocation = const LatLng(6.821700, 80.045803); //location to show in map
  late final GoogleMapController mapController;

  void _onMapCreator(GoogleMapController controller){
    setState(() {
      mapController = controller;
      controller.setMapStyle(Utils.mapStyle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Mechanic>>(
      stream: _mechanicService.mechanics,
      builder: (context, snapshot) {
        if(snapshot.data != null) {
          List<Mechanic> mechanics = snapshot.data ?? [];
          for( var i = 0 ; i < mechanics.length; i++ ) {
            markers.add(Marker(
              markerId: MarkerId(mechanics[i].name
                  +mechanics[i].latitude.toString()
                  +mechanics[i].longitude.toString()),
              position: LatLng(mechanics[i].latitude, mechanics[i].longitude),
              infoWindow: InfoWindow(
                title: mechanics[i].name,
                snippet: mechanics[i].owner,
                onTap: (){
                  Navigator.pushNamed(
                    context,
                    '/home-mechanic',
                    arguments:mechanics[i],
                  );
                },
              ),
              icon: BitmapDescriptor.defaultMarker,
            ));
          }
          return Scaffold(
            backgroundColor: const Color.fromRGBO(231,248,238,1),
            body: GoogleMap(
              mapType: MapType.normal,
              markers: markers,
              initialCameraPosition: const CameraPosition(
                target: showLocation,
                zoom: 14,
              ),
              onMapCreated:_onMapCreator,
            ),
          );
        } else {
          return const Loading();
        }
      }
    );
  }
}