import 'package:flutter/material.dart';
import 'package:mechanic_finder/models/mechanicRoadSideAssistance.dart';
import '../../../models/appUser.dart';
import '../../../services/auth.dart';
import '../../../shared/sideDrawer.dart';

class ViewRoadSideAssistance extends StatefulWidget {
  const ViewRoadSideAssistance({Key? key}) : super(key: key);

  @override
  State<ViewRoadSideAssistance> createState() => _ViewRoadSideAssistanceState();
}

class _ViewRoadSideAssistanceState extends State<ViewRoadSideAssistance> {

  final AuthService _auth = AuthService();

  String status = ''; // created -> accept or decline -> finish
  double price = 0;
  String task  = '';
  String userName  = '';
  String mechanicShopName = '';
  String vehicleRegNo = '' ;
  String brand = '';
  String model = '';

  String error = '';

  late AppUser appUser;

  @override
  void initState() {
    super.initState();
    appUser = _auth.getCurrentUser()!;
  }

  @override
  Widget build(BuildContext context) {
    final assistance = ModalRoute.of(context)!.settings.arguments as MechanicRoadSideAssistance;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(231,248,238,1),
      appBar: AppBar(
        title: Text("Assistance from " + assistance.mechanicShopName),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              if(assistance.status == 'created' ||
                  assistance.status =='accept'){
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
                            title: Text("Status : "+assistance.status.toUpperCase(),style: TextStyle(fontSize: 30),)
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
                    if(assistance.status == 'decline') ...[
                      const Text('Mechanic shop do not wish to '
                          'proceed with your request at the moment',
                      style: TextStyle(color: Colors.red),)
                    ],
                    if(assistance.status == 'accept') ...[
                      const Text('Mechanic is on his way to your location',
                        style: TextStyle(color: Colors.green),)
                    ],
                    if(assistance.status == 'done') ...[
                      const Text('The task is done. Please proceed to the payment',
                        style: TextStyle(color: Colors.green),),
                      const SizedBox(height: 30.0),
                      ElevatedButton(
                        child: const Text('Pay', style: TextStyle(
                            color: Colors.white, fontSize: 20.0),),
                        onPressed: () async {
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
