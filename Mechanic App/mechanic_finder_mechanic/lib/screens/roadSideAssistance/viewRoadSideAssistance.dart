import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../models/appUser.dart';
import '../../../shared/sideDrawer.dart';
import '../../models/mechanicRoadSideAssistance.dart';
import '../../services/authService.dart';
import '../../services/roadSideAssistanceService.dart';
import '../../shared/util.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewRoadSideAssistance extends StatefulWidget {
  const ViewRoadSideAssistance({Key? key}) : super(key: key);

  @override
  State<ViewRoadSideAssistance> createState() => _ViewRoadSideAssistanceState();
}

class _ViewRoadSideAssistanceState extends State<ViewRoadSideAssistance> {

  final AuthService _auth = AuthService();
  String error = '';
  late AppUser appUser;
  String status = '';

  @override
  void initState() {
    super.initState();
    appUser = _auth.getCurrentUser()!;
  }

  final Set<Marker> markers = Set();
  static const LatLng showLocation = LatLng(6.821700, 80.045803);
  LatLng requestLocation = const LatLng(6.821700, 80.045803);
  late final GoogleMapController mapController;

  void _onMapCreator(GoogleMapController controller){
    setState(() {
      mapController = controller;
      controller.setMapStyle(Utils.mapStyle);
    });
    mapController.moveCamera(CameraUpdate.newLatLng(requestLocation));
  }

  void _launchMapsUrl(double lat, double lon) async {
    final Uri url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lon');
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    final assistance = ModalRoute.of(context)!.settings.arguments as MechanicRoadSideAssistance;
    setState(() {
      requestLocation = LatLng(assistance.latitude, assistance.longitude);
      status = status.trim() == '' ? assistance.status : status;
    });
    markers.add(
      Marker(
        markerId: MarkerId(assistance.userName
          +assistance.latitude.toString()
          +assistance.longitude.toString()),
        position: LatLng(assistance.latitude, assistance.longitude),
        infoWindow: InfoWindow(
          title: assistance.userName,
          snippet: assistance.brand + '' + assistance.model,
          onTap:()=>_launchMapsUrl(assistance.latitude,assistance.longitude),
        ),
        icon: BitmapDescriptor.defaultMarker,
      )
    );

    return Scaffold(
      backgroundColor: const Color.fromRGBO(231,248,238,1),
      appBar: AppBar(
        title: Text("Assistance to " + assistance.userName),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              if(status == 'created' || status =='accept'){
              Navigator.pushReplacementNamed(context, "/");
              } else {
                Navigator.pushReplacementNamed(context, "/road-side-assistance-tasks");
              };
            }),
        backgroundColor: Colors.green[600],
        elevation: 0.0,
      ),
      drawer: const SideDrawer(),
      body:SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              child: Form(
                child: Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.fromLTRB(10,20,10,0),
                      elevation: 4,
                      shadowColor: Colors.green,
                      shape: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child: ListTileTheme(
                        contentPadding: const EdgeInsets.all(10),
                        tileColor: Colors.blue,
                        iconColor: Colors.white,
                        textColor: Colors.white,
                        style: ListTileStyle.list,
                        shape: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: ListTile(
                            title: Text("Status : "+ status.toUpperCase()
                              ,style: const TextStyle(fontSize: 30),)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,20,10,0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1.0),
                          ),
                          labelText: 'Vehicle',
                        ),
                        initialValue:assistance.vehicleRegNo,
                        enabled:false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,20,10,10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1.0),
                          ),
                          labelText: 'Task Description',
                        ),
                        initialValue:assistance.problemDescription,
                        minLines: 5,
                        maxLines: 7,
                        enabled:false,
                      ),
                    ),
                    if(status == 'accept') ...[
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Card(
                          child: ListTile(
                            leading: Icon(Icons.warning),
                              title: Text("You have accepted this request."
                                  "Try to move the location as fast as you can")
                          ),
                        ),
                      )
                    ],
                    if(status == 'created'
                        || status == 'accept') ...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10,10,10,0),
                        child: SizedBox(
                          height: 350,
                          child: GoogleMap(
                            mapType: MapType.normal,
                            markers: markers,
                            initialCameraPosition: const CameraPosition(
                              target: showLocation,
                              zoom: 14,
                            ),
                            onMapCreated:_onMapCreator,
                          ),
                        ),
                      )
                    ],
                    if(status == 'created') ...[
                      const SizedBox(height: 20.0),
                      Text(error, style: const TextStyle(color: Colors.red),),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: const Text('Accept', style: TextStyle(
                                color: Colors.white, fontSize: 20.0),),
                            onPressed: () async {
                              bool success = await RoadSideAssistanceService()
                                  .updateAssistanceRequestStatus(assistance.id,'accept');
                              if(success){
                                setState(() {
                                  status = 'accept';
                                  error = '';
                                });
                                _launchMapsUrl(assistance.latitude,assistance.longitude);
                              } else {
                                error = 'Error in accepting the request';
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
                          const SizedBox(width: 10,),
                          ElevatedButton(
                            child: const Text('Decline', style: TextStyle(
                                color: Colors.white, fontSize: 20.0),),
                            onPressed: () async {
                              bool success = await RoadSideAssistanceService()
                                  .updateAssistanceRequestStatus(assistance.id,'decline');

                              if(success){
                                setState(() {
                                  status = 'decline';
                                  error = '';
                                });
                              } else {
                                error = 'Error in decline the request';
                              }
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.0),
                                  side: const BorderSide(
                                      color: Color.fromRGBO(
                                          252, 5, 5, 1)),
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all<Size>(
                                  const Size(120, 45)
                              ),
                              backgroundColor: MaterialStateProperty.all<
                                  Color>(
                                  const Color.fromRGBO(252, 5, 5, 1)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,)
                    ],
                    if(status == 'decline') ...[
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Card(
                          child: ListTile(
                            leading: Icon(Icons.warning,color: Colors.red),
                            title: Text("You have rejected this request",
                              style: TextStyle(color: Colors.red),)
                          ),
                        ),
                      )
                    ],
                    if(status == 'done') ...[
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Card(
                          child: ListTile(
                              leading: Icon(Icons.volunteer_activism,color: Colors.green),
                              title: Text("You have completed this request",
                                style: TextStyle(color: Colors.green),)
                          ),
                        ),
                      )
                    ]
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
